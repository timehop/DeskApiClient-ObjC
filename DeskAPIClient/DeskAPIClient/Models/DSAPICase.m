//
//  DSAPICase.m
//  DeskAPIClient
//
//  Created by Desk.com on 9/24/13.
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

#import "DSAPICase.h"
#import "DSAPIClient.h"

#define kClassName @"case"
#define kMessageKey @"message"
#define kRepliesKey @"replies"
#define kHistoryKey @"history"
#define kDraftKey @"draft"
#define kPreviewKey @"preview"
#define kFeedKey @"feed"

@implementation DSAPICase

#pragma mark - Class Methods

+ (NSString *)className
{
    return kClassName;
}


+ (NSURLSessionDataTask *)listCasesWithParameters:(NSDictionary *)parameters
                                           client:(DSAPIClient *)client
                                            queue:(NSOperationQueue *)queue
                                          success:(DSAPIPageSuccessBlock)success
                                          failure:(DSAPIFailureBlock)failure
{
    return [self listCasesWithParameters:parameters
                                  client:client
                                   queue:queue
                                 success:success
                             notModified:nil
                                 failure:failure];
}


+ (NSURLSessionDataTask *)listCasesWithParameters:(NSDictionary *)parameters
                                           client:(DSAPIClient *)client
                                            queue:(NSOperationQueue *)queue
                                          success:(DSAPIPageSuccessBlock)success
                                      notModified:(DSAPIPageSuccessBlock)notModified
                                          failure:(DSAPIFailureBlock)failure
{
    return [super listResourcesAt:[DSAPICase classLinkWithBaseURL:client.baseURL]
                       parameters:parameters
                           client:client
                            queue:queue
                          success:success
                      notModified:notModified
                          failure:failure];
}


+ (NSURLSessionDataTask *)searchCasesWithParameters:(NSDictionary *)parameters
                                             client:(DSAPIClient *)client
                                              queue:(NSOperationQueue *)queue
                                            success:(DSAPIPageSuccessBlock)success
                                            failure:(DSAPIFailureBlock)failure
{
    return [super searchResourcesAt:[DSAPICase classLinkWithBaseURL:client.baseURL]
                         parameters:parameters
                             client:client
                              queue:queue
                            success:success
                            failure:failure];
}

+ (NSURLSessionDataTask *)searchCasesWithParameters:(NSDictionary *)parameters
                                             client:(DSAPIClient *)client
                                              queue:(NSOperationQueue *)queue
                                            success:(DSAPIPageSuccessBlock)success
                                        notModified:(DSAPIPageSuccessBlock)notModified
                                            failure:(DSAPIFailureBlock)failure
{
    return [super searchResourcesAt:[DSAPICase classLinkWithBaseURL:client.baseURL]
                         parameters:parameters
                             client:client
                              queue:queue
                            success:success
                        notModified:notModified
                            failure:failure];
}


+ (NSURLSessionDataTask *)createCase:(NSDictionary *)caseDict
                              client:(DSAPIClient *)client
                               queue:(NSOperationQueue *)queue
                             success:(void (^)(DSAPICase *newCase))success
                             failure:(DSAPIFailureBlock)failure
{
    return [super createResource:caseDict
                            link:[DSAPICase classLinkWithBaseURL:client.baseURL]
                          client:client
                           queue:queue
                         success:^(DSAPIResource *resource) {
                             if (success) {
                                 success((DSAPICase *)resource);
                             }
                         }
                         failure:failure];
}


+ (NSURLSessionDataTask *)showById:(NSNumber *)caseId
                        parameters:(NSDictionary *)parameters
                            client:(DSAPIClient *)client
                             queue:(NSOperationQueue *)queue
                           success:(void (^)(DSAPICase *))success
                           failure:(DSAPIFailureBlock)failure
{
    NSString *href = [NSString stringWithFormat:@"%@/%@", [DSAPICase classLinkWithBaseURL:client.baseURL], caseId];
    DSAPILink *linkToCase = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:href,
                                                                    kClassKey:[DSAPICase className]}
                                                          baseURL:client.baseURL];
    DSAPICase *theCase = (DSAPICase *)[linkToCase resourceWithClient:client];
    
    return [theCase showWithParameters:parameters
                                 queue:queue
                               success:success
                               failure:failure];
}


#pragma mark - Instance Methods

- (NSURLSessionDataTask *)showWithParameters:(NSDictionary *)parameters
                                       queue:(NSOperationQueue *)queue
                                     success:(void (^)(DSAPICase *theCase))success
                                     failure:(DSAPIFailureBlock)failure
{
    return [super showWithParameters:parameters
                               queue:queue
                             success:^(DSAPIResource *resource) {
                                 if (success) {
                                     success((DSAPICase *)resource);
                                 }
                             }
                             failure:failure];
}


- (NSURLSessionDataTask *)updateWithDictionary:(NSDictionary *)dictionary
                                         queue:(NSOperationQueue *)queue
                                       success:(void (^)(DSAPICase *theCase))success
                                       failure:(DSAPIFailureBlock)failure
{
    return [super updateWithDictionary:dictionary
                                 queue:queue
                               success:^(DSAPIResource *resource) {
                                   if (success) {
                                       success((DSAPICase *)resource);
                                   }
                               }
                               failure:failure];
}


#pragma mark - Message, Replies, and Draft
- (NSURLSessionDataTask *)showMessageWithParameters:(NSDictionary *)parameters
                                              queue:(NSOperationQueue *)queue
                                            success:(void (^)(DSAPIInteraction *message))success
                                            failure:(DSAPIFailureBlock)failure
{
    DSAPIResource *message = [[self linkForRelation:kMessageKey] resourceWithClient:self.client];
    return [message showWithParameters:parameters
                                 queue:queue
                               success:^(DSAPIResource *message) {
                                   if (success) {
                                       success((DSAPIInteraction *)message);
                                   }
                               }
                               failure:failure];
}


- (NSURLSessionDataTask *)listRepliesWithParameters:(NSDictionary *)parameters
                                              queue:(NSOperationQueue *)queue
                                            success:(DSAPIPageSuccessBlock)success
                                            failure:(DSAPIFailureBlock)failure
{
    return [self listRepliesWithParameters:parameters
                                     queue:queue
                                   success:success
                               notModified:nil
                                   failure:failure];
}


- (NSURLSessionDataTask *)listRepliesWithParameters:(NSDictionary *)parameters
                                              queue:(NSOperationQueue *)queue
                                            success:(DSAPIPageSuccessBlock)success
                                        notModified:(DSAPIPageSuccessBlock)notModified
                                            failure:(DSAPIFailureBlock)failure
{
    return [self listResourcesForRelation:kRepliesKey
                               parameters:parameters
                                    queue:queue
                                  success:success
                              notModified:notModified
                                  failure:failure];
}


- (NSURLSessionDataTask *)listFeedWithParameters:(NSDictionary *)parameters
                                           queue:(NSOperationQueue *)queue
                                         success:(DSAPIPageSuccessBlock)success
                                         failure:(DSAPIFailureBlock)failure
{
    return [self listFeedWithParameters:parameters
                                  queue:queue
                                success:success
                            notModified:nil
                                failure:failure];
}


- (NSURLSessionDataTask *)listFeedWithParameters:(NSDictionary *)parameters
                                           queue:(NSOperationQueue *)queue
                                         success:(DSAPIPageSuccessBlock)success
                                     notModified:(DSAPIPageSuccessBlock)notModified
                                         failure:(DSAPIFailureBlock)failure
{
    NSString *feedHref = [NSString stringWithFormat:@"%@/%@", self.linkToSelf.href, kFeedKey];
    DSAPILink *feedLink = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:feedHref} baseURL:self.client.baseURL];
    return [DSAPIResource listResourcesAt:feedLink
                               parameters:parameters
                                   client:self.client
                                    queue:queue
                                  success:success
                                  failure:failure];
}


- (NSURLSessionDataTask *)createReply:(NSDictionary *)replyDict
                                queue:(NSOperationQueue *)queue
                              success:(void (^)(DSAPIInteraction *newReply))success
                              failure:(DSAPIFailureBlock)failure
{
    DSAPILink *linkToReplies = [self linkForRelation:kRepliesKey];
    return [DSAPIResource createResource:replyDict
                                    link:linkToReplies
                                  client:self.client
                                   queue:queue
                                 success:^(DSAPIResource *newReply) {
                                     if (success) {
                                         success((DSAPIInteraction *)newReply);
                                     }
                                 }
                                 failure:failure];
}


- (NSURLSessionDataTask *)createDraft:(NSDictionary *)draftDict
                                queue:(NSOperationQueue *)queue
                              success:(void (^)(DSAPIInteraction *newDraft))success
                              failure:(DSAPIFailureBlock)failure
{
    DSAPILink *linkToReplies = [self linkForRelation:kDraftKey];
    return [DSAPIResource createResource:draftDict
                                    link:linkToReplies
                                  client:self.client
                                   queue:queue
                                 success:^(DSAPIResource *newDraft) {
                                     if (success) {
                                         success((DSAPIInteraction *)newDraft);
                                     }
                                 }
                                 failure:failure];
}


- (NSURLSessionDataTask *)showDraftWithParameters:(NSDictionary *)parameters
                                            queue:(NSOperationQueue *)queue
                                          success:(void (^)(DSAPIInteraction *draft))success
                                          failure:(DSAPIFailureBlock)failure
{
    DSAPIResource *draft = [[self linkForRelation:kDraftKey] resourceWithClient:self.client];
    return [draft showWithParameters:parameters
                               queue:queue
                             success:^(DSAPIResource *draft) {
                                 if (success) {
                                     success((DSAPIInteraction *)draft);
                                 }
                             }
                             failure:failure];
}


#pragma mark - Notes

- (NSURLSessionDataTask *)listNotesWithParameters:(NSDictionary *)parameters
                                            queue:(NSOperationQueue *)queue
                                          success:(DSAPIPageSuccessBlock)succes
                                          failure:(DSAPIFailureBlock)failure
{
    return [self listNotesWithParameters:parameters
                                   queue:queue
                                 success:succes
                             notModified:nil
                                 failure:failure];
}

- (NSURLSessionDataTask *)listNotesWithParameters:(NSDictionary *)parameters
                                            queue:(NSOperationQueue *)queue
                                          success:(DSAPIPageSuccessBlock)success
                                      notModified:(DSAPIPageSuccessBlock)notModified
                                          failure:(DSAPIFailureBlock)failure
{
    return [self listResourcesForRelation:[DSAPINote classNamePlural]
                               parameters:parameters
                                    queue:queue
                                  success:success
                              notModified:(DSAPIPageSuccessBlock)notModified
                                  failure:failure];
}

- (NSURLSessionDataTask *)createNote:(NSDictionary *)noteDict
                               queue:(NSOperationQueue *)queue
                             success:(void (^)(DSAPINote *))success
                             failure:(DSAPIFailureBlock)failure
{
    DSAPILink *linkToNotes = [self linkForRelation:[DSAPINote classNamePlural]];
    return [DSAPIResource createResource:noteDict
                                    link:linkToNotes
                                  client:self.client
                                   queue:queue
                                 success:^(DSAPIResource *resource) {
                                     if (success) {
                                         success((DSAPINote *)resource);
                                     }
                                 }
                                 failure:failure];
}

#pragma mark - Attachments

- (NSURLSessionDataTask *)listAttachmentsWithParameters:(NSDictionary *)parameters
                                                  queue:(NSOperationQueue *)queue
                                                success:(DSAPIPageSuccessBlock)success
                                                failure:(DSAPIFailureBlock)failure
{
    return [self listAttachmentsWithParameters:parameters
                                         queue:queue
                                       success:success
                                   notModified:nil
                                       failure:failure];
}

- (NSURLSessionDataTask *)listAttachmentsWithParameters:(NSDictionary *)parameters
                                                  queue:(NSOperationQueue *)queue
                                                success:(DSAPIPageSuccessBlock)success
                                            notModified:(DSAPIPageSuccessBlock)notModified
                                                failure:(DSAPIFailureBlock)failure
{
    return [self listResourcesForRelation:[DSAPIAttachment classNamePlural]
                               parameters:parameters
                                    queue:queue
                                  success:success
                              notModified:notModified
                                  failure:failure];
}

- (NSURLSessionDataTask *)createAttachment:(NSDictionary *)attachmentDict
                                     queue:(NSOperationQueue *)queue
                                   success:(void (^)(DSAPIAttachment *newAttachment))success
                                   failure:(DSAPIFailureBlock)failure
{
    DSAPILink *linkToAttachments = [self linkForRelation:[DSAPIAttachment classNamePlural]];
    if (!linkToAttachments) {
        linkToAttachments = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:[NSString stringWithFormat:@"%@/%@", self.linkToSelf.href, [DSAPIAttachment classNamePlural]], kClassKey:[DSAPIAttachment className]}
                                                          baseURL:self.client.baseURL];
    }
    return [DSAPIResource createResource:attachmentDict
                                    link:linkToAttachments
                                  client:self.client
                                   queue:queue
                                 success:^(DSAPIResource *resource) {
                                     if (success) {
                                         success((DSAPIAttachment *)resource);
                                     }
                                 }
                                 failure:failure];
}

- (NSURLSessionDataTask *)historyWithQueue:(NSOperationQueue *)queue
                                   success:(DSAPIPageSuccessBlock)success
                                   failure:(DSAPIFailureBlock)failure
{
    return [self historyWithQueue:queue
                          success:success
                      notModified:nil
                          failure:failure];
}


- (NSURLSessionDataTask *)historyWithQueue:(NSOperationQueue *)queue
                                   success:(DSAPIPageSuccessBlock)success
                               notModified:(DSAPIPageSuccessBlock)notModified
                                   failure:(DSAPIFailureBlock)failure
{
    DSAPILink *linkToHistory = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:[NSString stringWithFormat:@"%@/%@", self.linkToSelf.href, kHistoryKey], kClassKey:kHistoryKey} baseURL:self.client.baseURL];
    return [DSAPIResource listResourcesAt:linkToHistory
                               parameters:nil
                                   client:self.client
                                    queue:queue
                                  success:success
                              notModified:notModified
                                  failure:failure];
}

- (NSURLSessionDataTask *)previewMacros:(NSArray *)macros
                                  queue:(NSOperationQueue *)queue
                                success:(DSAPIPageSuccessBlock)success
                                failure:(DSAPIFailureBlock)failure
{
    NSArray *macroLinks = [macros valueForKeyPath:@"@distinctUnionOfObjects.linkToSelf.dictionary"];
    DSAPIResource *macrosPreviewResource = [[DSAPIResource alloc] initWithDictionary:@{kLinksKey: @{[DSAPIMacro classNamePlural]:macroLinks}}
                                                                              client:self.client];
    
    DSAPILink *linkToMacros = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:[NSString stringWithFormat:@"%@/%@/%@", self.linkToSelf.href, [DSAPIMacro classNamePlural], kPreviewKey], kClassKey:[DSAPIMacro className]}
                                                            baseURL:self.client.baseURL];
    
    return [self.client POST:linkToMacros.href
                  parameters:macrosPreviewResource.dictionary
                       queue:queue
                     success:^(NSHTTPURLResponse *response, id responseObject) {
                         if (success) {
                             success((DSAPIPage *)[responseObject DSAPIResourceWithClient:self.client]);
                         }
                     }
                     failure:^(NSHTTPURLResponse *response, NSError *error) {
                         [self.client postRateLimitingNotificationIfNecessary:response];
                         if (failure) {
                             failure(response, error);
                         }
                     }];
}

@end
