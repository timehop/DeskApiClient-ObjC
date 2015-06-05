//
//  DSAPITwitterAccount.m
//  DeskAPIClient
//
//  Created by Desk.com on 5/13/14.
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

#import "DSAPITwitterAccount.h"
#import "DSAPILink.h"

#define kClassName @"twitter_account"
#define kFollowsKey @"follows"

@implementation DSAPITwitterAccount

#pragma mark - Class Methods

+ (NSString *)className
{
    return kClassName;
}


+ (void)listTwitterAccountsWithParameters:(NSDictionary *)parameters
                                  success:(DSAPIPageSuccessBlock)success
                                  failure:(DSAPIFailureBlock)failure
{
    [self listTwitterAccountsWithParameters:parameters
                                    success:success
                                notModified:nil
                                    failure:failure];
}


+ (void)listTwitterAccountsWithParameters:(NSDictionary *)parameters
                                  success:(DSAPIPageSuccessBlock)success
                              notModified:(DSAPIPageSuccessBlock)notModified
                                  failure:(DSAPIFailureBlock)failure
{
    [super listResourcesAt:[DSAPITwitterAccount classLink]
                parameters:parameters
                   success:success
               notModified:notModified
                   failure:failure];
}


- (void)showWithParameters:(NSDictionary *)parameters
                   success:(void (^)(DSAPITwitterAccount *filter))success
                   failure:(DSAPIFailureBlock)failure
{
    [super showWithParameters:parameters success:^(DSAPIResource *resource) {
        if (success) {
            success((DSAPITwitterAccount *)resource);
        }
    } failure:failure];
}


- (void)listTweetsWithParameters:(NSDictionary *)parameters
                         success:(DSAPIPageSuccessBlock)success
                         failure:(DSAPIFailureBlock)failure
{
    [self listTweetsWithParameters:parameters
                           success:success
                       notModified:nil
                           failure:failure];
}


- (void)listTweetsWithParameters:(NSDictionary *)parameters
                         success:(DSAPIPageSuccessBlock)success
                     notModified:(DSAPIPageSuccessBlock)notModified
                         failure:(DSAPIFailureBlock)failure
{
    [self listResourcesForRelation:[DSAPITweet classNamePlural]
                        parameters:parameters
                           success:success
                       notModified:notModified
                           failure:failure];
}


- (void)createTweet:(NSDictionary *)tweetDict
            success:(void (^)(DSAPITweet *))success
            failure:(DSAPIFailureBlock)failure
{
    DSAPILink *linkToTweets = [self linkForRelation:[DSAPITweet classNamePlural]];
    [DSAPIResource createResource:tweetDict atLink:linkToTweets success:^(DSAPIResource *resource) {
        if (success) {
            success((DSAPITweet *)resource);
        }
    } failure:failure];
}


- (void)showFollowWithUsername:(NSString *)username
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(DSAPITwitterFollow *))success
                       failure:(DSAPIFailureBlock)failure
{
    NSString *href = [NSString stringWithFormat:@"%@/%@/%@", self.linkToSelf, kFollowsKey, username];
    DSAPILink *linkToFollow = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:href,
                                                                     kClassKey:[DSAPITwitterFollow className]}];
    [DSAPIResource showResourceAtLink:linkToFollow
                           parameters:parameters success:^(DSAPIResource *resource) {
                               if (success) {
                                   success((DSAPITwitterFollow *)resource);
                               }
                           } failure:failure];
}


- (void)createFollow:(NSDictionary *)followDict
             success:(void (^)(DSAPITwitterFollow *))success
             failure:(DSAPIFailureBlock)failure
{
    NSString *href = [NSString stringWithFormat:@"%@/%@", self.linkToSelf, kFollowsKey];
    DSAPILink *linkToFollows = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:href,
                                                                       kClassKey:[DSAPITwitterFollow className]}];
    
    [DSAPIResource createResource:followDict
                           atLink:linkToFollows
                          success:^(DSAPIResource *resource) {
                              if (success) {
                                  success((DSAPITwitterFollow *)resource);
                              }
                          } failure:failure];
}

@end
