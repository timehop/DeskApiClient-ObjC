//
//  DSAPILink.h
//  DeskAPIClient
//
//  Created by Desk.com on 9/19/13.
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

#import <Foundation/Foundation.h>

#define kHrefKey @"href"
#define kClassKey @"class"
#define kEmbedKey @"embed"
#define kPageKey @"page"
#define kPerPageKey @"per_page"

@class DSAPIResource;
@class DSAPIClient;

@interface DSAPILink : NSObject

@property (nonatomic, copy, readonly) NSString *href;
@property (nonatomic, copy, readonly) NSString *className;
@property (nonatomic, strong, readonly) NSURL *URL;
@property (nonatomic, strong, readonly) NSDictionary *parameters;
@property (nonatomic, readonly) NSDictionary *dictionary;

/**
 Creates a `DSAPILink` given a relative href, a class name from the API, and a base URL
 
 @param href The href of the link, relative to the base URL
 @param className The class name of the resource at the link, per the API
 @param baseURL The baseURL of the link
 
 @return The `DSAPILink`
 */
+ (instancetype)linkWithHref:(NSString *)href className:(NSString *)className baseURL:(NSURL *)baseURL;

/**
 Initializes a `DSAPILink` given a dictionary and baseURL.
 
 @param dictionary The dictionary that describes the link
 @param baseURL The baseURL of the link
 
 @return The `DSAPILink`
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary baseURL:(NSURL *)baseURL;


/**
 Returns a new `DSAPILink` for a given relation and class. This is used in cases where the DSAPIResource does not already contain a link to the relation.
 
 @param relation A string stating the relation (e.g., @"self", @"message", @"replies")
 @param class A Class stating the DSAPIResource subclass for the relation (DSAPIUser, DSAPICase, etc.)
 
 @return The array of `DSAPILink` for the relation.
 */
- (DSAPILink *)linkFromRelationWithClass:(Class)relatedClass;


/**
 Allocates and initializes a `DSAPIResource` from the link, treating the link as the resource's link @"self".
 
 @param client The client to use for making network requests.
 
 @return The `DSAPIResource`
 */
- (DSAPIResource *)resourceWithClient:(DSAPIClient *)client;

@end
