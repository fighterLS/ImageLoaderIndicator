//
//  CustomImageView.m
//  ImageLoaderIndicator
//
//  Created by 李赛 on 15/10/15.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "CustomImageView.h"
#import "UIImageView+WebCache.h"

@implementation CustomImageView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self) {
        self= [super initWithCoder:aDecoder];
        _progressIndicatorView=[CircularLoaderView new];
        [self addSubview:self.progressIndicatorView];
        self.progressIndicatorView.frame=self.bounds;
        self.progressIndicatorView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    }
    return self;
}
- (void)sd_CustomImageViewWithImageURL:(NSURL *)url  placeholderImage:(UIImage *)placeholderImage
{
    
    [self sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressIndicatorView.progress = (CGFloat)receivedSize/expectedSize;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.progressIndicatorView reveal];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
