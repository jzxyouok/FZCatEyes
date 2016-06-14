//
//  BackView.h
//  两个滚动视图
//
//  Created by 李忠 on 6/13/16.
//  Copyright © 2016 李忠. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FZNavTitleView;

@protocol FZNavTitleViewDelegate <NSObject>

- (void)beginScroll:(CGFloat)offset;

@end

@interface FZNavTitleView : UIView

@property (weak, nonatomic) id<FZNavTitleViewDelegate> delegate;

- (void)scrollCoverView:(CGFloat)contstant;
- (void)scrollEndCoverView:(CGPoint)point;

+ (instancetype)navTitleView;

@end
