//
//  DeskAPIClientTests.m
//  DeskAPIClientTests
//
//  Created by Desk.com on 9/17/13.
//  Copyright (c) 2015 Salesforce, Inc All rights reserved.
//

#import "DSAPITestCase.h"

@interface DSAPIClient()

@property (nonatomic, strong) NSMutableDictionary *downloadProgressBlocks;
@property (nonatomic, strong) NSMutableDictionary *downloadCompletionBlocks;

@end

@interface DSAPIClientTests : DSAPITestCase

@property (strong, nonatomic) DSAPIClient *client;

@end

@implementation DSAPIClientTests

- (void)setUp
{
    [super setUp];
    [Expecta setAsynchronousTestTimeout:5.0];
    _client = [DSAPITestUtils APIClientBasicAuth];
}
- (void)testThatWeCanCommunicateWithTheWebService
{
    __block id blockResponseObject = nil;
    
    [_client GET:@"/api/v2/cases" parameters:nil queue:self.APICallbackQueue success:^(NSHTTPURLResponse *response, id responseObject) {
        //NSLog(@"%@", responseObject);
        blockResponseObject = responseObject;
        [self done];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        EXPFail(self, __LINE__, __FILE__, [error description]);
        [self done];
    }];
    
    expect([self isDone]).will.beTruthy();
    expect(blockResponseObject).willNot.beNil();
}

- (void)testInitializationOfClient
{
    expect(_client).toNot.beNil();
    expect(_client).to.beKindOf([DSAPIClient class]);
}

- (void)testCannotUseOAuth
{
    XCTAssertThrows([_client acquireOAuthRequestTokenWithQueue:self.APICallbackQueue success:^(DSAPIOAuth1Token *requestToken) {
        //
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        //
    }], @"Client initialized with basic oauth but accepted oauth method.");
}

- (void)testThatWebServiceSendsResponseObject
{
    __block id blockResponseObject = nil;
    [_client GET:@"/api/v2/cases" parameters:nil queue:self.APICallbackQueue success:^(NSHTTPURLResponse *response, id responseObject) {
        NSLog(@"%@", responseObject);
        blockResponseObject = responseObject;
        [self done];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        EXPFail(self, __LINE__, __FILE__, [error description]);
        [self done];
    }];
    
    expect([self isDone]).will.beTruthy();
    expect(blockResponseObject).willNot.beNil();
}

- (void)testFiresRateLimitingResponse
{
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:nil statusCode:DSC_HTTP_STATUS_TOO_MANY_REQUESTS HTTPVersion:nil headerFields:nil];
    
    id mockNotificationCenter = [OCMockObject partialMockForObject:[NSNotificationCenter defaultCenter]];
    [[mockNotificationCenter expect] postNotificationName:DSAPIDidErrorWithTooManyRequestsNotification object:_client userInfo:OCMOCK_ANY];
    
    [_client postRateLimitingNotificationIfNecessary:response];
    [mockNotificationCenter verify];
}

- (void)testDoesntFireRateLimitingResponse
{
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:nil statusCode:DSC_HTTP_STATUS_NOT_FOUND HTTPVersion:nil headerFields:nil];
    
    id mockNotificationCenter = [OCMockObject partialMockForObject:[NSNotificationCenter defaultCenter]];
    [[mockNotificationCenter reject] postNotificationName:DSAPIDidErrorWithTooManyRequestsNotification object:_client userInfo:OCMOCK_ANY];
    
    [_client postRateLimitingNotificationIfNecessary:response];
    [mockNotificationCenter verify];
}

- (void)testTokenAuthentication
{
    DSAPIClient *client = [DSAPITestUtils APIClientTokenAuth];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should get 200 response"];
    
    [client GET:@"/api/v2/articles" parameters:nil queue:self.APICallbackQueue success:^(NSHTTPURLResponse *response, id responseObject) {
        expect(response.statusCode).to.equal(DSC_HTTP_STATUS_OK);
        [expectation fulfill];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        EXPFail(self, __LINE__, __FILE__, [error description]);
    }];
    
    [self waitForExpectationsWithTimeout:3.f handler:nil];
}

- (void)testDownloadTaskCallsProgressBlock
{
    NSURL *url = [NSURL URLWithString:@"http://google.com/favicon.ico"];
    
    XCTestExpectation *exp = [self expectationWithDescription:@"wait for download progress"];
    __block BOOL calledOnce = NO;
    [_client downloadTaskWithURL:url
                           queue:self.APICallbackQueue
                 progressHandler:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
                     expect([[_client downloadProgressBlocks] count]).to.equal(1);
                     if (!calledOnce) {
                         [exp fulfill];
                         calledOnce = YES;
                     }
                 }
               completionHandler:nil];
    
    [self waitForExpectationsWithTimeout:2.0 handler:nil];
}

- (void)testDownloadTaskCallsCompletionHandler
{
    NSURL *url = [NSURL URLWithString:@"http://google.com/favicon.ico"];
    
    XCTestExpectation *exp = [self expectationWithDescription:@"wait for download"];
    
    [_client downloadTaskWithURL:url
                           queue:self.APICallbackQueue
                 progressHandler:nil
               completionHandler:^(NSData *data, NSHTTPURLResponse *response, NSError *error) {
                   expect(data).toNot.beNil();
                   expect([[_client downloadProgressBlocks] count]).to.equal(0);
                   [exp fulfill];
               }];
    
    [self waitForExpectationsWithTimeout:DSAPIDefaultTimeout handler:^(NSError *error) {
        expect([[_client downloadCompletionBlocks] count]).to.equal(0);
    }];
}

- (void)testCancelDownloadTasks
{
    XCTestExpectation *exp = [self expectationWithDescription:@"wait for completion"];
    
    // Launch and cancel 20 download tasks
    for (int i = 1; i <= 10; i++) {
        NSURLSessionDownloadTask *task = [self startDownloadTaskWithExpectation:exp];
        expect([[_client downloadProgressBlocks] count]).to.equal(i);
        expect([[_client downloadCompletionBlocks] count]).to.equal(i);
        [task cancel];
        expect(task.state).will.equal(NSURLSessionTaskStateCanceling);
    }
    
    // Wait 5 seconds for all cancelations to finish.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [exp fulfill];
    });
    
    // Verify client state is correct.
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        expect([[_client downloadProgressBlocks] count]).to.equal(0);
        expect([[_client downloadCompletionBlocks] count]).to.equal(0);
    }];
}

- (NSURLSessionDownloadTask *)startDownloadTaskWithExpectation:(XCTestExpectation *)expectation
{
    NSURL *url = [NSURL URLWithString:@"http://google.com/favicon.ico"];
    
    return [_client downloadTaskWithURL:url
                                  queue:self.APICallbackQueue
                        progressHandler:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
                            // dummy block
                        }
                      completionHandler:^(NSData *data, NSHTTPURLResponse *response, NSError *error) {
                          // Completion should not be called if cancelled.
                          XCTFail(@"Completion called.");
                          [expectation fulfill];
                      }];
}

@end
