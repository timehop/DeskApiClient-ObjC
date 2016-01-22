//
//  DSAPIPage.m
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

#import "DSAPIPage.h"
#import "DSAPIClient.h"

#define kClassName @"page"

#define kEntriesKey @"entries"
#define kTotalEntriesKey @"total_entries"
#define kFirstPageKey @"first"
#define kLastPageKey @"last"
#define kPreviousPageKey @"previous"
#define kNextPageKey @"next"

@implementation DSAPIPage

#pragma mark - Class Methods

+ (NSString *)className
{
    return kClassName;
}


+ (DSAPIPage *)pageFromPageHref:(NSString *)currentPageHref
               withNextPageHref:(NSString *)nextPageHref
                         client:(DSAPIClient *)client
{
    return [[DSAPIPage alloc] initWithDictionary:@{
                                                   kLinksKey: @{
                                                           kSelfKey:@{
                                                                   kClassKey:[self className],
                                                                   kHrefKey: currentPageHref ? currentPageHref : [NSNull null]
                                                                   },
                                                           kNextKey: @{
                                                                   kClassKey: [self className],
                                                                   kHrefKey: nextPageHref ? nextPageHref : [NSNull null]
                                                                   }
                                                           }
                                                   }
                                          client:client];
}

- (NSArray *)entries
{
    return [self resourcesForRelation:kEntriesKey];
}

- (NSArray *)newEntries
{
    return [self resourcesForRelation:kNewEntriesKey];
}

- (NSArray *)changedEntries
{
    return [self resourcesForRelation:kChangedEntriesKey];
}

- (NSArray *)removedEntries
{
    return self[kRemovedEntriesKey];
}

- (NSArray *)positions
{
    return self[kPositionsKey];
}

- (NSNumber *)time
{
    return self[kTimeKey];
}

- (NSNumber *)totalEntries
{
    return self[kTotalEntriesKey];
}

- (NSUInteger)pageNumber
{
    NSString *queryString = [[self.linkToSelf.href componentsSeparatedByString:@"?"] lastObject];
    NSDictionary *parameters = DSAPIParametersFromQueryString(queryString);
    return [parameters[kPageKey] integerValue];
}

- (NSUInteger)perPage
{
    NSString *queryString = [[self.linkToSelf.href componentsSeparatedByString:@"?"] lastObject];
    NSDictionary *parameters = DSAPIParametersFromQueryString(queryString);
    return [parameters[kPerPageKey] integerValue];
}

- (DSAPILink *)linkToFirstPage
{
    return [self linkForRelation:kFirstPageKey];
}

- (DSAPILink *)linkToLastPage
{
    return [self linkForRelation:kLastPageKey];
}

- (DSAPILink *)linkToPreviousPage
{
    return [self linkForRelation:kPreviousPageKey];
}

- (DSAPILink *)linkToNextPage
{
    return [self linkForRelation:kNextPageKey];
}

- (BOOL)shouldLoadNextPage
{
    return self.linkToNextPage && self.linkToNextPage.href && ![self.linkToNextPage.href isEqual:[NSNull null]];
}

@end
