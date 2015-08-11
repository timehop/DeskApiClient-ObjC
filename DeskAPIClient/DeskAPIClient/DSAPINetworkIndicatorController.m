//
//  DSAPINetworkIndicatorController.m
//  DeskAPIClient
//
//  Created by Noel Artiles on 8/11/15.
//  Copyright (c) 2015 Desk.com. All rights reserved.
//

#import "DSAPINetworkIndicatorController.h"

@interface DSAPINetworkIndicatorController ()

@property NSUInteger activityCount;
@property (nonatomic) NSTimer *timer;

@end

@implementation DSAPINetworkIndicatorController

#pragma mark - Lifecycle

+ (DSAPINetworkIndicatorController *)sharedController {
    static DSAPINetworkIndicatorController *_sharedController = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _sharedController = [[self alloc] init];
    });
    
    return _sharedController;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _activityCount = 0;
    }
    return self;
}

#pragma mark - Public

- (void)networkActivityDidStart
{
    NSAssert([NSThread isMainThread], @"Altering network activity indicator state can only be done on the main thread.");
    self.activityCount++;
    [self updateIndicatorVisibility];
}

- (void)networkActivityDidEnd
{
    NSAssert([NSThread isMainThread], @"Altering network activity indicator state can only be done on the main thread.");
    self.activityCount--;
    [self updateIndicatorVisibility];
    
}

#pragma mark - Private

- (void)updateIndicatorVisibility
{
    if (self.activityCount > 0) {
        [self showIndicator];
    } else {
        /*
         To prevent the indicator from flickering on and off, we delay the
         hiding of the indicator by around one second. This provides the chance
         to come in and invalidate the timer before it fires.
         */
        [self createTimerToHideIndicator];
    }
}

- (void)createTimerToHideIndicator
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.75 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
    self.timer.tolerance = 0.5;
}

- (void)timerFireMethod:(NSTimer *)timer
{
    [self hideIndicator];
}

- (void)showIndicator
{
    [self.timer invalidate];
    self.timer = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)hideIndicator
{
    [self.timer invalidate];
    self.timer = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


@end
