//
//  BBubbleView.m
//  Bubble
//
//  Created by Don Huff on 10/29/14.
//  Copyright (c) 2014 15 by 10, LLC. All rights reserved.
//

#import "BBubbleView.h"


@implementation BBubbleView

- (void)setNormalizedBubblePoint:(CGPoint)normalizedBubblePoint
{
    _normalizedBubblePoint = normalizedBubblePoint;
    [self setNeedsDisplay];
}

#pragma mark - UIView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, self.bounds);

    CGRect bounds = self.bounds;
    CGFloat side = MIN(CGRectGetHeight(bounds), CGRectGetWidth(bounds));
    CGRect centerSquare = CGRectMake((CGRectGetWidth(bounds) - side) / 2, (CGRectGetHeight(bounds) - side) / 2, side, side);

    CGContextSetFillColorWithColor(context, UIColor.yellowColor.CGColor);
    CGContextFillEllipseInRect(context, centerSquare);
    
    const CGFloat BubbleRadius = 10;

    CGPoint centerPoint = CGPointMake(CGRectGetMidX(centerSquare), CGRectGetMidY(centerSquare));

    CGPoint nbp = self.normalizedBubblePoint;
    CGRect bubbleRect = CGRectMake(centerPoint.x + nbp.x * side / 2 - BubbleRadius,
                                   centerPoint.y + nbp.y * side / 2 - BubbleRadius,
                                   BubbleRadius * 2,
                                   BubbleRadius * 2);
    
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillEllipseInRect(context, bubbleRect);
    
    const CGFloat TargetStrokeWidth = 3.0;
    const CGFloat TargetRadius = BubbleRadius + TargetStrokeWidth;
    
    CGRect centerTargetRect = CGRectMake(centerPoint.x - TargetRadius,
                                         centerPoint.y - TargetRadius,
                                         TargetRadius * 2,
                                         TargetRadius * 2);
    CGContextSetStrokeColorWithColor(context, self.backgroundColor.CGColor);
    CGContextSetLineWidth(context, TargetStrokeWidth);
    CGContextSetShouldAntialias(context, NO);
    CGContextStrokeEllipseInRect(context, centerTargetRect);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

@end
