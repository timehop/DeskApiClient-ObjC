//
//  DSAPINetworkIndicatorController.h
//  DeskAPIClient
//
//  Created by Noel Artiles on 8/11/15.
//  Copyright (c) 2015 Desk.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSAPINetworkIndicatorController : NSObject

+ (DSAPINetworkIndicatorController *)sharedController;

- (void)networkActivityDidStart;
- (void)networkActivityDidEnd;

@end
