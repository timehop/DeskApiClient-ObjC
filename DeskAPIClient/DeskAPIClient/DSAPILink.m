//
//  DSAPILink.m
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

#import "DSAPILink.h"
#import "DSAPIClient.h"
#import "DSAPIResource.h"

@interface DSAPILink()
@property (nonatomic, copy) NSURL *baseURL;
@end

@implementation DSAPILink {
    NSDictionary *_parameters;
}

+ (instancetype)linkWithHref:(NSString *)href className:(NSString *)className baseURL:(NSURL *)baseURL
{
    return [[self alloc] initWithDictionary:@{kHrefKey:href, kClassKey:className} baseURL:baseURL];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary baseURL:(NSURL *)baseURL
{
    self = [super init];
    if (self) {
        [self extractFieldsFromDictionary:dictionary];
        _baseURL = baseURL;
        _dictionary = dictionary;
        if (!_href) return nil;
    }
    return self;
}

- (DSAPIResource *)resourceWithClient:(DSAPIClient *)client
{
    return [DSAPIResource resourceWithHref:self.href client:client className:self.className];
}


- (DSAPILink *)linkFromRelationWithClass:(Class)relatedClass
{
    NSString *linkHref = [NSString stringWithFormat:@"%@/%@", self.href, [relatedClass classNamePlural]];
    NSDictionary *linkDictionary = @{kHrefKey:linkHref,
                                     kClassKey:[relatedClass className]};
    
    return [[DSAPILink alloc] initWithDictionary:linkDictionary baseURL:self.baseURL];
}

- (NSString *)description
{
    return [self.URL description];
}

- (void)extractFieldsFromDictionary:(NSDictionary *)dictionary
{
    _href = dictionary[kHrefKey];
    _className = dictionary[kClassKey];
}

- (NSURL *)URL
{
    NSURL *url = [NSURL URLWithString:self.href relativeToURL:self.baseURL];
    return [NSURL URLWithString:[url absoluteString]];
}

- (NSDictionary *)parameters
{
    if (!_parameters) {
        NSArray *urlComponents = [self.href componentsSeparatedByString:@"?"];
        if (urlComponents.count > 1) {
            NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
            NSArray *parameterPairs = [urlComponents[1] componentsSeparatedByString:@"&"];
            
            for (NSString *keyValuePair in parameterPairs)
            {
                NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
                if (pairComponents.count > 1) {
                    NSString *key = [pairComponents objectAtIndex:0];
                    NSString *value = [pairComponents objectAtIndex:1];
                    
                    [queryStringDictionary setObject:value forKey:key];
                }
            }
            _parameters = queryStringDictionary;
        } else {
            return nil;
        }
    }
    
    return _parameters;
}


@end
