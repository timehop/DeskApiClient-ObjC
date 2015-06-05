//
//  DSAPIPageTests.m
//  DeskAPIClient
//
//  Created by Desk.com on 10/30/13.
//  Copyright (c) 2015, Salesforce.com, Inc.
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided
//  that the following conditions are met:
//  
//     Redistributions of source code must retain the above copyright notice, this list of conditions and the
//     following disclaimer.
//  
//     Redistributions in binary form must reproduce the above copyright notice, this list of conditions and
//     the following disclaimer in the documentation and/or other materials provided with the distribution.
//  
//     Neither the name of Salesforce.com, Inc. nor the names of its contributors may be used to endorse or
//     promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
//  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
//  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
//  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//

#import "DSAPITestCase.h"
#import "DSAPIPage.h"
#import <objc/runtime.h>

@interface DSAPIPageTests : DSAPITestCase

@end

@implementation DSAPIPageTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testThatRepliesHasAPropertyForEntries
{
    DSAPIResource *replies = [DSAPITestUtils resourceFromJSONFile:@"case41replies"];
    expect(((DSAPIPage *)replies).entries.count).to.equal(2);
}

- (void)testThatRepliesHasAPropertyForTotalEntries
{
    DSAPIResource *replies = [DSAPITestUtils resourceFromJSONFile:@"case41replies"];
    expect([((DSAPIPage *)replies).totalEntries integerValue]).to.equal(2);
}

- (void)testFirstPageLink
{
    DSAPIResource *replies = [DSAPITestUtils resourceFromJSONFile:@"case41repliespageone"];
    expect(((DSAPIPage *)replies).linkToFirstPage.href).to.equal(@"/api/v2/cases/41/replies?page=1&per_page=1");
    expect(((DSAPIPage *)replies).linkToFirstPage.className).to.equal(@"page");
}

- (void)testLastPageLink
{
    DSAPIResource *replies = [DSAPITestUtils resourceFromJSONFile:@"case41repliespageone"];
    expect(((DSAPIPage *)replies).linkToLastPage.href).to.equal(@"/api/v2/cases/41/replies?page=2&per_page=1");
    expect(((DSAPIPage *)replies).linkToLastPage.className).to.equal(@"page");
}

- (void)testPreviousPageLink
{
    DSAPIResource *replies = [DSAPITestUtils resourceFromJSONFile:@"case41repliespageone"];
    expect(((DSAPIPage *)replies).linkToPreviousPage.href).to.beNil();
}

- (void)testNextPageLink
{
    DSAPIResource *replies = [DSAPITestUtils resourceFromJSONFile:@"case41repliespageone"];
    expect(((DSAPIPage *)replies).linkToNextPage.href).to.equal(@"/api/v2/cases/41/replies?page=2&per_page=1");
    expect(((DSAPIPage *)replies).linkToNextPage.className).to.equal(@"page");
}

- (void)testShouldLoadNextPage
{
    DSAPIResource *replies = [DSAPITestUtils resourceFromJSONFile:@"case41repliespageone"];
    expect(((DSAPIPage *)replies).shouldLoadNextPage).to.beTruthy();
}

- (void)testShouldNotLoadNextPage
{
    DSAPIPage *page = [DSAPIPage pageFromPageHref:nil withNextPageHref:nil];
    expect(page.shouldLoadNextPage).toNot.beTruthy();
}

- (void)testPageNumber
{
    DSAPIResource *replies = [DSAPITestUtils resourceFromJSONFile:@"case41repliespageone"];
    expect(((DSAPIPage *)replies).pageNumber).to.equal(1);
}

- (void)testPerPage
{
    DSAPIResource *replies = [DSAPITestUtils resourceFromJSONFile:@"case41repliespageone"];
    expect(((DSAPIPage *)replies).perPage).to.equal(1);
}

- (void)testPageNumberForNotModifiedPage
{
    DSAPIResource *replies = [DSAPITestUtils resourceFromJSONFile:@"case41repliespageone"];
    DSAPIPage *page = [DSAPIPage pageFromPageHref:replies.linkToSelf.href withNextPageHref:nil];
    expect(page.pageNumber).to.equal(1);
}

@end
