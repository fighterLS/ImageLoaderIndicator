//
//  CircularLoaderView.h
//  ImageLoaderIndicator
//
//  Created by 李赛 on 15/10/15.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularLoaderView : UIView
{
    CAShapeLayer *circlePathLayer;
    CGFloat circleRadius;
}
@property (nonatomic, assign) CGFloat progress;
-(void)reveal;
@end
