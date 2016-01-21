//
//  DSAPIResource+Testing.m
//  DeskAPIClient
//
//  Created by Noel Artiles on 1/21/16.
//  Copyright © 2016 Desk.com. All rights reserved.
//

#import "DSAPIResource+Testing.h"

@implementation DSAPIResource (Testing)

- (instancetype)initWithTestDictionary:(NSDictionary *)dictionary
{
    DSAPIClient *dummyClient = [DSAPIClient new];
    dummyClient.baseURL = [NSURL URLWithString:@"http://google.com"];
    return [self initWithDictionary:dictionary client:dummyClient];
}


@end
