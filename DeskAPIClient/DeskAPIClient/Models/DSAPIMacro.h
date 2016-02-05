//
//  DSAPIMacro.h
//  DeskAPIClient
//
//  Created by Desk.com on 1/27/14.
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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Woverriding-method-mismatch"

@interface DSAPIMacro : DSAPIResource

#pragma mark - Class Methods

/**
 Lists macros by calling a GET to the /api/v2/macros endpoint of the Desk.com API.
 
 @param parameters The querystring parameters to be sent with the GET request (including 'page' and 'per_page' for pagination).
 @param client The client to use for making the network request.
 @param queue The queue on which to execute the success and failure blocks.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the page (`DSAPIPage`) of resources returned by the GET request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
 @return A resumed NSURLSessionDataTask. If an error occurred this return value is nil and the failure block is executed.
 */

+ (NSURLSessionDataTask *)listMacrosWithParameters:(NSDictionary *)parameters
                                            client:(DSAPIClient *)client
                                             queue:(NSOperationQueue *)queue
                                           success:(DSAPIPageSuccessBlock)success
                                           failure:(DSAPIFailureBlock)failure;


/**
 Lists macros by calling a GET to the /api/v2/macros endpoint of the Desk.com API. Supports ETag caching.
 
 @param parameters The querystring parameters to be sent with the GET request (including 'page' and 'per_page' for pagination).
 @param client The client to use for making the network request.
 @param queue The queue on which to execute the success, failure and notModified blocks.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the page (`DSAPIPage`) of resources returned by the GET request.
 @param notModified A block object to be executed if the web service returns a response of not modified (HTTP status code 304). This is called when the response at this endpoint hasn't changed since the last request (via ETags). This block has no return value and takes one argument: a page (`DSAPIPage`) whose notModified property is set to YES.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
 @return A resumed NSURLSessionDataTask. If an error occurred this return value is nil and the failure block is executed.
 */

+ (NSURLSessionDataTask *)listMacrosWithParameters:(NSDictionary *)parameters
                                            client:(DSAPIClient *)client
                                             queue:(NSOperationQueue *)queue
                                           success:(DSAPIPageSuccessBlock)success
                                       notModified:(DSAPIPageSuccessBlock)notModified
                                           failure:(DSAPIFailureBlock)failure;


/**
 Creates a macro by calling a POST to the /api/v2/macros endpoint of the Desk.com API.
 
 @param macroDict A dictionary defining the new macro.
 @param client The client to use for making the network request.
 @param queue The queue on which to execute the success and failure blocks.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the new macro (`DSAPIMacro`) created and returned by the POST request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
 @return A resumed NSURLSessionDataTask. If an error occurred this return value is nil and the failure block is executed.
 */

+ (NSURLSessionDataTask *)createMacro:(NSDictionary *)macroDict
                               client:(DSAPIClient *)client
                                queue:(NSOperationQueue *)queue
                              success:(void (^)(DSAPIMacro *newMacro))success
                              failure:(DSAPIFailureBlock)failure;


#pragma mark - Instance Methods

/**
 Shows an individual macro by calling a GET to the macro's "self" link.
 
 @param parameters The querystring parameters to be sent with the GET request (including 'embed' to embed a resource in the response)
 @param queue The queue on which to execute the success and failure blocks.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the macro (`DSAPIMacro`) returned by the GET request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
 @return A resumed NSURLSessionDataTask. If an error occurred this return value is nil and the failure block is executed.
 */

- (NSURLSessionDataTask *)showWithParameters:(NSDictionary *)parameters
                                       queue:(NSOperationQueue *)queue
                                     success:(void (^)(DSAPIMacro *macro))success
                                     failure:(DSAPIFailureBlock)failure;


/**
 Updates a macro by calling a PATCH to the macro's "self" link.
 
 @param dictionary A dictionary defining the updates to the macro.
 @param queue The queue on which to execute the success and failure blocks.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the updated macro (`DSAPIMacro`) returned by the PATCH request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
 @return A resumed NSURLSessionDataTask. If an error occurred this return value is nil and the failure block is executed.
 */
- (NSURLSessionDataTask *)updateWithDictionary:(NSDictionary *)dictionary
                                         queue:(NSOperationQueue *)queue
                                       success:(void (^)(DSAPIMacro *macro))success
                                       failure:(DSAPIFailureBlock)failure;


/**
 Lists the actions for an individual macro by calling a GET to the macro's "actions" link.
 
 @param parameters The querystring parameters to be sent with the GET request
 @param queue The queue on which to execute the success and failure blocks.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the page (`DSAPIPage`) of resources returned by the GET request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
 @return A resumed NSURLSessionDataTask. If an error occurred this return value is nil and the failure block is executed.
 */
- (NSURLSessionDataTask *)listActionsWithParameters:(NSDictionary *)parameters
                                              queue:(NSOperationQueue *)queue
                                            success:(DSAPIPageSuccessBlock)success
                                            failure:(DSAPIFailureBlock)failure;


/**
 Lists the actions for an individual macro by calling a GET to the macro's "actions" link. Supports ETag caching.
 
 @param parameters The querystring parameters to be sent with the GET request
 @param queue The queue on which to execute the success, failure and notModified blocks.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes one argument: the page (`DSAPIPage`) of resources returned by the GET request.
 @param notModified A block object to be executed if the web service returns a response of not modified (HTTP status code 304). This is called when the response at this endpoint hasn't changed since the last request (via ETags). This block has no return value and takes one argument: a page (`DSAPIPage`) whose notModified property is set to YES.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the `NSHTTPURLResponse` from the server, and an `NSError` describing the network or parsing error that occurred.
 @return A resumed NSURLSessionDataTask. If an error occurred this return value is nil and the failure block is executed.
 */
- (NSURLSessionDataTask *)listActionsWithParameters:(NSDictionary *)parameters
                                              queue:(NSOperationQueue *)queue
                                            success:(DSAPIPageSuccessBlock)success
                                        notModified:(DSAPIPageSuccessBlock)notModified
                                            failure:(DSAPIFailureBlock)failure;


@end

#pragma clang diagnostic pop
