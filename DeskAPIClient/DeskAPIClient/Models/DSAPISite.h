//
//  DSAPISite.h
//  DeskAPIClient
//
//  Created by Desk.com on 11/10/14.
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

#import "DSAPIResource.h"
@class DSAPIBilling;

@interface DSAPISite : DSAPIResource

/**
 Shows the current site by calling a GET to the default site's show url.
 
 @param parameters The querystring parameters to be sent with the GET request (including 'embed' to embed a resource in the response)
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the site (`DSAPISite`) returned by the GET request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
 */
+ (void)showCurrentSiteWithSuccess:(void (^)(DSAPISite *site))success
                        andFailure:(DSAPIFailureBlock)failure;

+ (void)showCurrentSiteWithParameters:(NSDictionary *)parameters
                              success:(void (^)(DSAPISite *site))success
                              failure:(DSAPIFailureBlock)failure;

/**
 Shows the current site's billing information by calling a GET to the default site's "billing" url.
 
 @param parameters The querystring parameters to be sent with the GET request (including 'embed' to embed a resource in the response)
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the billing (`DSAPIBilling`) returned by the GET request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
 */
+ (void)showCurrentSiteBillingWithSuccess:(void (^)(DSAPIBilling *billing))success
                                  failure:(DSAPIFailureBlock)failure;

+ (void)showCurrentSiteBillingWithParameters:(NSDictionary *)parameters
                                     success:(void (^)(DSAPIBilling *billing))success
                                     failure:(DSAPIFailureBlock)failure;

/**
 Shows an individual site by calling a GET to the site's "self" link.

 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the note (`DSAPISite`) returned by the GET request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
 */
- (void)showWithSuccess:(void (^)(DSAPISite *site))success
                   andFailure:(DSAPIFailureBlock)failure;

/**
Shows an individual site by calling a GET to the site's "self" link.

@param parameters The querystring parameters to be sent with the GET request (including 'embed' to embed a resource in the response)
@param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the site (`DSAPISite`) returned by the GET request.
@param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
*/

- (void)showWithParameters:(NSDictionary *)parameters
                   success:(void (^)(DSAPISite *site))success
                   failure:(DSAPIFailureBlock)failure;

/**
 Shows an individual site's billing information by calling a GET to the site's "billing" url.
 
 @param parameters The querystring parameters to be sent with the GET request (including 'embed' to embed a resource in the response)
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the billing (`DSAPIBilling`) returned by the GET request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
 */

- (void)showBillingWithParameters:(NSDictionary *)parameters
                          success:(void (^)(DSAPIBilling *siteBilling))success
                          failure:(DSAPIFailureBlock)failure;

@end


