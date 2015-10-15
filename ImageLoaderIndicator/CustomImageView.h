//
//  CustomImageView.h
//  ImageLoaderIndicator
//
//  Created by 李赛 on 15/10/15.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularLoaderView.h"
@interface CustomImageView : UIImageView
@property (nonatomic, strong)CircularLoaderView *progressIndicatorView;

- (void)sd_CustomImageViewWithImageURL:(NSURL *)url  placeholderImage:(UIImage *)placeholderImage;
@end
