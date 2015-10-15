//
//  CircularLoaderView.m
//  ImageLoaderIndicator
//
//  Created by 李赛 on 15/10/15.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "CircularLoaderView.h"

@implementation CircularLoaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self) {
        self=[super initWithFrame:frame];
        [self configure];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self) {
        self=[super initWithCoder:aDecoder];
        [self configure];
    }
    return self;
}

-(void)configure
{
    
    circleRadius=20.0;
    circlePathLayer=[CAShapeLayer layer];
    circlePathLayer.frame = self.bounds;
    circlePathLayer.lineWidth = 2;
    circlePathLayer.strokeEnd =0;
    circlePathLayer.fillColor = [UIColor clearColor].CGColor;
    circlePathLayer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:circlePathLayer];
     self.progress = 0;
    self.backgroundColor = [UIColor clearColor];
   
}
-(void)reveal{
    self.backgroundColor = UIColor.clearColor;
    self.progress = 1;
    [circlePathLayer removeAnimationForKey:@"strokeEnd"];
    [circlePathLayer removeFromSuperlayer];
  
    self.superview.layer.mask = circlePathLayer;
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat finalRadius = sqrt((center.x*center.x) + (center.y*center.y));
    CGFloat radiusInset = finalRadius - circleRadius;
    
    CGRect outerRect =CGRectInset([self circleFrame], -radiusInset, -radiusInset);
    CGPathRef toPath =[UIBezierPath bezierPathWithOvalInRect:outerRect].CGPath;
   
    
    //2
    CGPathRef fromPath = circlePathLayer.path;
    CGFloat fromLineWidth = circlePathLayer.lineWidth;
    
    //3
    [CATransaction begin];
    [CATransaction setValue:[CATransaction valueForKey:kCATransactionDisableActions] forKey:kCATransactionDisableActions];
   
    circlePathLayer.lineWidth = 2*finalRadius;
    circlePathLayer.path = toPath;
    [CATransaction commit];
    
    //4
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath: @"lineWidth"];
    lineWidthAnimation.fromValue = [NSNumber numberWithFloat:fromLineWidth];
    lineWidthAnimation.toValue = [NSNumber numberWithFloat:2*finalRadius];
    
    
    CABasicAnimation *pathAnimation =[CABasicAnimation animationWithKeyPath: @"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(fromPath);
    pathAnimation.toValue = (__bridge id _Nullable)(toPath);
    
    //5
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 1;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAnimation.animations = @[pathAnimation, lineWidthAnimation];
    groupAnimation.delegate = self;
    [circlePathLayer addAnimation:groupAnimation forKey:@"strokeWidth"];
}

-(CGRect)circleFrame
{
    CGRect circleFrame = CGRectMake(0, 0, 2*circleRadius, 2*circleRadius);
    circleFrame.origin.x = CGRectGetMidX(circlePathLayer.bounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(circlePathLayer.bounds) - CGRectGetMidY(circleFrame);
    return circleFrame;
}
-(UIBezierPath *)circlePath
{
    return [UIBezierPath bezierPathWithOvalInRect:[self circleFrame]];
}
#pragma mark  --override func--
-(void)layoutSubviews
{
    [super layoutSubviews];
    circlePathLayer.frame=self.bounds;
    circlePathLayer.path=[self circlePath].CGPath;
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.superview.layer.mask=nil;
}
#pragma mark -setter  and getter--
-(CGFloat)progress
{
    return circlePathLayer.strokeEnd;
}
-(void)setProgress:(CGFloat)progress
{
    if (progress > 1) {
        circlePathLayer.strokeEnd = 1;
    } else if (progress < 0) {
        circlePathLayer.strokeEnd = 0;
    } else {
        circlePathLayer.strokeEnd = progress;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
