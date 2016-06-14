//
//  BackView.m
//  两个滚动视图
//
//  Created by 李忠 on 6/13/16.
//  Copyright © 2016 李忠. All rights reserved.
//

#import "FZNavTitleView.h"
#import "UIView+FZExtension.h"

@interface FZNavTitleView ()
@property (weak, nonatomic) IBOutlet UIView *coverView;

//coverView的leading 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingHot;

//遮照View上的文本标签
@property (weak, nonatomic) IBOutlet UILabel *coverLabel;

//点击View的位置坐标
@property (assign, nonatomic) CGPoint  clickPoint;

//是否进行了移动操作，并且这个移动的初始点不在coverView 上
@property (assign, nonatomic) BOOL isMove;

@end

@implementation FZNavTitleView


+(instancetype)navTitleView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"FZNavTitleView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    _coverView.layer.cornerRadius = 5;
    _coverView.layer.masksToBounds = YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UITouch *touch = touches.anyObject;
    _clickPoint = [touch locationInView:self];
    //MARK: 如果点击的坐标不在coverView，就做另外的操作
    CGPoint ziPoint = [self convertPoint:_clickPoint toView:_coverView];
    if ([_coverView pointInside:ziPoint withEvent:nil]){
        self.coverView.alpha = 0.8;
        
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    //MARK: - 取到坐标点
    UITouch *touch = touches.anyObject;
    CGPoint moveP = [touch locationInView:self];
    CGPoint preP = [touch precisePreviousLocationInView:self];

    //MARK: 得到偏移量并做操作，防止滑动超过backView
    CGFloat contstant = self.leadingHot.constant + moveP.x - preP.x;
    
    
    if (contstant <= 0) {
        contstant = 0;
    }
    if (contstant >= self.fzWidth - _coverView.fzWidth) {
        contstant = self.fzWidth - _coverView.fzWidth;
    }
    
    
    //MARK: 如果点击的坐标不在coverView，就做另外的操作
    CGPoint ziPoint = [self convertPoint:moveP toView:_coverView];
    if (![_coverView pointInside:ziPoint withEvent:nil]){
        
        if (moveP.x <= 0 ) {
            moveP.x = 0;
            
        }
        if (moveP.x >= self.fzWidth - _coverView.fzWidth) {
            moveP.x = self.fzWidth - _coverView.fzWidth;
        }
        
        _clickPoint.x = moveP.x;
        _isMove = YES;
        return;
    }

    CGFloat half = self.coverView.fzWidth * 0.5;
    
    CGFloat move = (contstant / self.fzWidth) * 3*[UIScreen mainScreen].bounds.size.width;
        [self.delegate beginScroll:move];
    
    _coverLabel.alpha = 0;
    //给coverView约束设置
    self.leadingHot.constant = contstant;
    
    //_clickPoint 记录着coverView的中心坐标，根据这个坐标会判断coverView会移动到那个label上面
    _clickPoint = CGPointMake(contstant + half, 0);

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.coverView.alpha = 0.8;
    _coverLabel.alpha = 0;
    //MARK: - 用于判断是否是没有点击到coverView，所做的滑动
    if (_isMove) {
        _isMove = NO;
        self.leadingHot.constant = _clickPoint.x;
    }
    
    for (UIView *ziView in self.subviews) {
        
        if([ziView isKindOfClass:[UILabel class]]){
            
            UILabel *label = (UILabel *)ziView;
            
            //求坐标用于求出滚动的位置
            NSUInteger index = [self.subviews indexOfObject:label];
            
            CGPoint ziPoint = [self convertPoint:_clickPoint toView:label];
            
            if ([label pointInside:ziPoint withEvent:nil]) {
                
                self.leadingHot.constant = label.fzX;
                
                [self.delegate beginScroll:index * [UIScreen mainScreen].bounds.size.width];
                
                _coverLabel.text = label.text;
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    [self layoutIfNeeded];
                    
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        self.coverView.alpha = 1;
                        _coverLabel.alpha = 1;
                    }];
                    
                }];
                break;
            }
            
        }
    }
    
}


- (void)scrollCoverView:(CGFloat)contstant{
    
    self.coverView.alpha = 0.8;
    _coverLabel.alpha = 0;
    
    if (contstant <= 0) {
        contstant = 0;
    }
    if (contstant >= self.fzWidth - _coverView.fzWidth) {
        contstant = self.fzWidth - _coverView.fzWidth;
    }
    //给coverView约束设置
    self.leadingHot.constant = contstant;
}


//移动结束
- (void)scrollEndCoverView:(CGPoint)point{
    
    //传过来的point 会少算一点点，只要在原先的基础上加上 0.9或以上的距离就可以了。
    point.x += 0.9;
    
    self.coverView.alpha = 0.8;
    
    for (UIView *ziView in self.subviews) {
        
        if([ziView isKindOfClass:[UILabel class]]){
            
            UILabel *label = (UILabel *)ziView;
            
            CGPoint ziPoint = [self convertPoint:point toView:label];
            
            if ([label pointInside:ziPoint withEvent:nil]) {
                
                _coverLabel.text = label.text;
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.coverView.alpha = 1;
                    _coverLabel.alpha = 1;
                }];
                break;
            }
            
        }
    }
}
@end
