//
//  DSAPISiteSettingTests.m
//  DeskAPIClient
//
//  Created by Desk.com on 5/23/14.
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

@interface DSAPISiteSettingTests : DSAPITestCase

@property (nonatomic, strong) DSAPIClient *client;

@end

@implementation DSAPISiteSettingTests

- (void)setUp
{
    [super setUp];
    [Expecta setAsynchronousTestTimeout:5.0];
    _client = [DSAPITestUtils APIClientBasicAuth];
}

- (void)testListSiteSettings
{
    __block NSArray *_siteSettings = nil;
    [DSAPISiteSetting listSiteSettingsWithParameters:nil client:self.client queue:self.APICallbackQueue success:^(DSAPIPage *page) {
        _siteSettings = page.entries;
        [self done];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        EXPFail(self, __LINE__, __FILE__, [error description]);
        [self done];
    }];
    
    expect([self isDone]).will.beTruthy();
    expect(_siteSettings.count).will.beGreaterThan(0);
    expect(_siteSettings[0]).will.beKindOf([DSAPISiteSetting class]);
}

- (void)testShowSiteSetting
{
    __block DSAPISiteSetting *_siteSetting = nil;
    [DSAPISiteSetting listSiteSettingsWithParameters:nil client:self.client queue:self.APICallbackQueue success:^(DSAPIPage *page) {
        [(DSAPISiteSetting *)page.entries[0] showWithParameters:nil queue:self.APICallbackQueue success:^(DSAPISiteSetting *siteSetting) {
            _siteSetting = siteSetting;
            [self done];
        } failure:^(NSHTTPURLResponse *response, NSError *error) {
            EXPFail(self, __LINE__, __FILE__, [error description]);
            [self done];
        }];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        EXPFail(self, __LINE__, __FILE__, [error description]);
        [self done];
    }];
    
    expect([self isDone]).will.beTruthy();
    expect(_siteSetting).willNot.beNil();
    expect(_siteSetting).will.beKindOf([DSAPISiteSetting class]);
    expect(_siteSetting[@"value"]).willNot.beNil();
    expect(_siteSetting[@"name"]).willNot.beNil();
}


@end
