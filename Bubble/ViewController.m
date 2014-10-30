//
//  ViewController.m
//  Bubble
//
//  Created by Don Huff on 10/29/14.
//  Copyright (c) 2014 15 by 10, LLC. All rights reserved.
//

#import "ViewController.h"
#import "BBubbleView.h"
@import CoreMotion;

@interface ViewController ()

@property (nonatomic) CMMotionManager *motionManager;

// outlets
@property (weak, nonatomic) IBOutlet BBubbleView *bubbleView;

@end


@implementation ViewController

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.motionManager) {
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.deviceMotionUpdateInterval = 1.0 / 30.0;
        
        [self.motionManager startDeviceMotionUpdatesToQueue:NSOperationQueue.mainQueue
                                                withHandler:^ (CMDeviceMotion *motion, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"Device motion error: %@", error);
                                                        return;
                                                    }
                                                    
                                                    // normalize the XY components
                                                    double length = sqrt(motion.gravity.x * motion.gravity.x + motion.gravity.y * motion.gravity.y + motion.gravity.z * motion.gravity.z);
                                                    CGPoint normalizedXY = CGPointMake(-motion.gravity.x / length, motion.gravity.y / length);
                                                    self.bubbleView.normalizedBubblePoint = normalizedXY;
                                                }];
    }
}

@end
