//
//  UIView+MDRExtension.m
//
//  Created by  on 16/1/8.
//  Copyright © 2016年 李忠. All rights reserved.
//

#import "UIView+FZExtension.h"

@implementation UIView (FZExtension)


- (void)setFzX:(CGFloat)fzX {
    
    CGRect frame = self.frame;
    
    frame.origin.x = fzX;
    
    self.frame = frame;
    
}


- (CGFloat)fzX {

    return self.frame.origin.x;
}

- (void)setFzY:(CGFloat)fzY {
    
    CGRect frame = self.frame;
    
    frame.origin.y = fzY;
    
    self.frame = frame;
    
}


- (CGFloat)fzY {
    
    return self.frame.origin.y;
}


- (void)setFzWidth:(CGFloat)fzWidth {
    
    CGRect frame = self.frame;
    
    frame.size.width = fzWidth;
    
    self.frame = frame;
    
}


- (CGFloat)fzWidth {
    
    return self.frame.size.width;
}


- (void)setFzHeight:(CGFloat)fzHeight {
    
    CGRect frame = self.frame;
    
    frame.size.height = fzHeight;
    
    self.frame = frame;
    
}


- (CGFloat)fzHeight {
    
    return self.frame.size.height;
}












@end
