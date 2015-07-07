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


+ (void)listCasesWithParameters:(NSDictionary *)parameters
                          queue:(NSOperationQueue *)queue
                        success:(DSAPIPageSuccessBlock)success
                        failure:(DSAPIFailureBlock)failure
{
    [self listCasesWithParameters:parameters
                            queue:queue
                          success:success
                      notModified:nil
                          failure:failure];
}


+ (void)listCasesWithParameters:(NSDictionary *)parameters
                          queue:(NSOperationQueue *)queue
                        success:(DSAPIPageSuccessBlock)success
                    notModified:(DSAPIPageSuccessBlock)notModified
                        failure:(DSAPIFailureBlock)failure
{
    [super listResourcesAt:[DSAPICase classLink]
                parameters:parameters
                     queue:queue
                   success:success
               notModified:notModified
                   failure:failure];
}


+ (void)searchCasesWithParameters:(NSDictionary *)parameters
                            queue:(NSOperationQueue *)queue
                          success:(DSAPIPageSuccessBlock)success
                          failure:(DSAPIFailureBlock)failure
{
    [super searchResourcesAt:[DSAPICase classLink] parameters:parameters queue:queue success:success failure:failure];
}

+ (void)searchCasesWithParameters:(NSDictionary *)parameters
                            queue:(NSOperationQueue *)queue
                          success:(DSAPIPageSuccessBlock)success
                      notModified:(DSAPIPageSuccessBlock)notModified
                          failure:(DSAPIFailureBlock)failure
{
    [super searchResourcesAt:[DSAPICase classLink]
                  parameters:parameters
                       queue:queue
                     success:success
                 notModified:notModified
                     failure:failure];
}


+ (void)createCase:(NSDictionary *)caseDict
             queue:(NSOperationQueue *)queue
           success:(void (^)(DSAPICase *newCase))success
           failure:(DSAPIFailureBlock)failure
{
    [super createResource:caseDict
                   atLink:[DSAPICase classLink]
                    queue:queue
                  success:^(DSAPIResource *resource) {
                      if (success) {
                          success((DSAPICase *)resource);
                      }
                  }
                  failure:failure];
}


+ (void)showById:(NSNumber *)caseId
      parameters:(NSDictionary *)parameters
           queue:(NSOperationQueue *)queue
         success:(void (^)(DSAPICase *))success
         failure:(DSAPIFailureBlock)failure
{
    NSString *href = [NSString stringWithFormat:@"%@/%@", [DSAPICase classLink], caseId];
    DSAPILink *linkToCase = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:href,
                                                                    kClassKey:[DSAPICase className]}];
    DSAPICase *theCase = (DSAPICase *)[linkToCase resourceWithSelf];
    
    [theCase showWithParameters:parameters
                          queue:queue
                        success:success
                        failure:failure];
}


#pragma mark - Instance Methods

- (void)showWithParameters:(NSDictionary *)parameters
                     queue:(NSOperationQueue *)queue
                   success:(void (^)(DSAPICase *theCase))success
                   failure:(DSAPIFailureBlock)failure
{
    [super showWithParameters:parameters
                        queue:queue
                      success:^(DSAPIResource *resource) {
                          if (success) {
                              success((DSAPICase *)resource);
                          }
                      }
                      failure:failure];
}


- (void)updateWithDictionary:(NSDictionary *)dictionary
                       queue:(NSOperationQueue *)queue
                     success:(void (^)(DSAPICase *theCase))success
                     failure:(DSAPIFailureBlock)failure
{
    [super updateWithDictionary:dictionary
                          queue:queue
                        success:^(DSAPIResource *resource) {
                            if (success) {
                                success((DSAPICase *)resource);
                            }
                        }
                        failure:failure];
}


#pragma mark - Message, Replies, and Draft
- (void)showMessageWithParameters:(NSDictionary *)parameters
                            queue:(NSOperationQueue *)queue
                          success:(void (^)(DSAPIInteraction *message))success
                          failure:(DSAPIFailureBlock)failure
{
    DSAPIResource *message = [[self linkForRelation:kMessageKey] resourceWithSelf];
    [message showWithParameters:parameters
                          queue:queue
                        success:^(DSAPIResource *message) {
                            if (success) {
                                success((DSAPIInteraction *)message);
                            }
                        }
                        failure:failure];
}


- (void)listRepliesWithParameters:(NSDictionary *)parameters
                            queue:(NSOperationQueue *)queue
                          success:(DSAPIPageSuccessBlock)success
                          failure:(DSAPIFailureBlock)failure
{
    [self listRepliesWithParameters:parameters
                              queue:queue
                            success:success
                        notModified:nil
                            failure:failure];
}


- (void)listRepliesWithParameters:(NSDictionary *)parameters
                            queue:(NSOperationQueue *)queue
                          success:(DSAPIPageSuccessBlock)success
                      notModified:(DSAPIPageSuccessBlock)notModified
                          failure:(DSAPIFailureBlock)failure
{
    [self listResourcesForRelation:kRepliesKey
                        parameters:parameters
                             queue:queue
                           success:success
                       notModified:notModified
                           failure:failure];
}


- (void)listFeedWithParameters:(NSDictionary *)parameters
                         queue:(NSOperationQueue *)queue
                       success:(DSAPIPageSuccessBlock)success
                       failure:(DSAPIFailureBlock)failure
{
    [self listFeedWithParameters:parameters
                           queue:queue
                         success:success
                     notModified:nil
                         failure:failure];
}


- (void)listFeedWithParameters:(NSDictionary *)parameters
                         queue:(NSOperationQueue *)queue
                       success:(DSAPIPageSuccessBlock)success
                   notModified:(DSAPIPageSuccessBlock)notModified
                       failure:(DSAPIFailureBlock)failure
{
    NSString *feedHref = [NSString stringWithFormat:@"%@/%@", self.linkToSelf.href, kFeedKey];
    DSAPILink *feedLink = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:feedHref}];
    [DSAPIResource listResourcesAt:feedLink
                        parameters:parameters
                             queue:queue
                           success:success
                           failure:failure];
}


- (void)createReply:(NSDictionary *)replyDict
              queue:(NSOperationQueue *)queue
            success:(void (^)(DSAPIInteraction *newReply))success
            failure:(DSAPIFailureBlock)failure
{
    DSAPILink *linkToReplies = [self linkForRelation:kRepliesKey];
    [DSAPIResource createResource:replyDict
                           atLink:linkToReplies
                            queue:queue
                          success:^(DSAPIResource *newReply) {
                              if (success) {
                                  success((DSAPIInteraction *)newReply);
                              }
                          }
                          failure:failure];
}


- (void)createDraft:(NSDictionary *)draftDict
              queue:(NSOperationQueue *)queue
            success:(void (^)(DSAPIInteraction *newDraft))success
            failure:(DSAPIFailureBlock)failure
{
    DSAPILink *linkToReplies = [self linkForRelation:kDraftKey];
    [DSAPIResource createResource:draftDict
                           atLink:linkToReplies
                            queue:queue
                          success:^(DSAPIResource *newDraft) {
                              if (success) {
                                  success((DSAPIInteraction *)newDraft);
                              }
                          }
                          failure:failure];
}


- (void)showDraftWithParameters:(NSDictionary *)parameters
                          queue:(NSOperationQueue *)queue
                        success:(void (^)(DSAPIInteraction *draft))success
                        failure:(DSAPIFailureBlock)failure
{
    DSAPIResource *draft = [[self linkForRelation:kDraftKey] resourceWithSelf];
    [draft showWithParameters:parameters
                        queue:queue
                      success:^(DSAPIResource *draft) {
                          if (success) {
                              success((DSAPIInteraction *)draft);
                          }
                      }
                      failure:failure];
}


#pragma mark - Notes

- (void)listNotesWithParameters:(NSDictionary *)parameters
                          queue:(NSOperationQueue *)queue
                        success:(DSAPIPageSuccessBlock)succes
                        failure:(DSAPIFailureBlock)failure
{
    [self listNotesWithParameters:parameters
                            queue:queue
                          success:succes
                      notModified:nil
                          failure:failure];
}

- (void)listNotesWithParameters:(NSDictionary *)parameters
                          queue:(NSOperationQueue *)queue
                        success:(DSAPIPageSuccessBlock)success
                    notModified:(DSAPIPageSuccessBlock)notModified
                        failure:(DSAPIFailureBlock)failure
{
    [self listResourcesForRelation:[DSAPINote classNamePlural]
                        parameters:parameters
                             queue:queue
                           success:success
                       notModified:(DSAPIPageSuccessBlock)notModified
                           failure:failure];
}

- (void)createNote:(NSDictionary *)noteDict
             queue:(NSOperationQueue *)queue
           success:(void (^)(DSAPINote *))success
           failure:(DSAPIFailureBlock)failure
{
    DSAPILink *linkToNotes = [self linkForRelation:[DSAPINote classNamePlural]];
    [DSAPIResource createResource:noteDict
                           atLink:linkToNotes
                            queue:queue
                          success:^(DSAPIResource *resource) {
                              if (success) {
                                  success((DSAPINote *)resource);
                              }
                          }
                          failure:failure];
}

#pragma mark - Attachments

- (void)listAttachmentsWithParameters:(NSDictionary *)parameters
                                queue:(NSOperationQueue *)queue
                              success:(DSAPIPageSuccessBlock)success
                              failure:(DSAPIFailureBlock)failure
{
    [self listAttachmentsWithParameters:parameters
                                  queue:queue
                                success:success
                            notModified:nil
                                failure:failure];
}

- (void)listAttachmentsWithParameters:(NSDictionary *)parameters
                                queue:(NSOperationQueue *)queue
                              success:(DSAPIPageSuccessBlock)success
                          notModified:(DSAPIPageSuccessBlock)notModified
                              failure:(DSAPIFailureBlock)failure
{
    [self listResourcesForRelation:[DSAPIAttachment classNamePlural]
                        parameters:parameters
                             queue:queue
                           success:success
                       notModified:notModified
                           failure:failure];
}

- (void)createAttachment:(NSDictionary *)attachmentDict
                   queue:(NSOperationQueue *)queue
                 success:(void (^)(DSAPIAttachment *newAttachment))success
                 failure:(DSAPIFailureBlock)failure
{
    DSAPILink *linkToAttachments = [self linkForRelation:[DSAPIAttachment classNamePlural]];
    if (!linkToAttachments) {
        linkToAttachments = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:[NSString stringWithFormat:@"%@/%@", self.linkToSelf.href, [DSAPIAttachment classNamePlural]], kClassKey:[DSAPIAttachment className]}];
    }
    [DSAPIResource createResource:attachmentDict
                           atLink:linkToAttachments
                            queue:queue
                          success:^(DSAPIResource *resource) {
                              if (success) {
                                  success((DSAPIAttachment *)resource);
                              }
                          }
                          failure:failure];
}

- (void)historyWithQueue:(NSOperationQueue *)queue
                 success:(DSAPIPageSuccessBlock)success
                 failure:(DSAPIFailureBlock)failure;
{
    [self historyWithQueue:queue
                   success:success
               notModified:nil
                   failure:failure];
}


- (void)historyWithQueue:(NSOperationQueue *)queue
                 success:(DSAPIPageSuccessBlock)success
             notModified:(DSAPIPageSuccessBlock)notModified
                 failure:(DSAPIFailureBlock)failure;
{
    DSAPILink *linkToHistory = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:[NSString stringWithFormat:@"%@/%@", self.linkToSelf.href, kHistoryKey], kClassKey:kHistoryKey}];
    [DSAPIResource listResourcesAt:linkToHistory
                        parameters:nil
                             queue:queue
                           success:success
                       notModified:notModified
                           failure:failure];
}

- (void)previewMacros:(NSArray *)macros
                queue:(NSOperationQueue *)queue
              success:(DSAPIPageSuccessBlock)success
              failure:(DSAPIFailureBlock)failure
{
    NSArray *macroLinks = [macros valueForKeyPath:@"@distinctUnionOfObjects.linkToSelf.dictionary"];
    DSAPIResource *macrosPreviewResource = [[DSAPIResource alloc] initWithDictionary:@{kLinksKey: @{[DSAPIMacro classNamePlural]:macroLinks}}];
    
    DSAPILink *linkToMacros = [[DSAPILink alloc] initWithDictionary:@{kHrefKey:[NSString stringWithFormat:@"%@/%@/%@", self.linkToSelf.href, [DSAPIMacro classNamePlural], kPreviewKey], kClassKey:[DSAPIMacro className]}];
    
    DSAPIClient *client = [DSAPIClient sharedManager];
    [client POST:linkToMacros.href parameters:macrosPreviewResource.dictionary success:^(NSHTTPURLResponse *response, id responseObject) {
        if (success) {
            success((DSAPIPage *)[responseObject DSAPIResourceWithSelf]);
        }
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        [client postRateLimitingNotificationIfNecessary:response];
        if (failure) {
            failure(response, error);
        }
    }];
}

@end
