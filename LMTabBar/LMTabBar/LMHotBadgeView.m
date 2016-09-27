//
//  LMHotBadgeView.m
//  LMTabBar
//
//  Created by 刘明 on 16/9/27.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "LMHotBadgeView.h"

@implementation LMHotBadgeView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = NO;
        
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImage *image = [UIImage imageNamed:@"main_badge"];
        
        UIImage *stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width topCapHeight:image.size.height];
        
        [self setBackgroundImage:stretchableImage forState:UIControlStateNormal];
        
        CGRect frame = self.frame;
        
        frame.size.height = stretchableImage.size.height;
        
        self.frame = frame;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    
    _badgeValue = badgeValue;
    
    self.hidden = NO;
    
    if ([badgeValue integerValue] > 99) {
        
        badgeValue = @"99+";
    }else if ([badgeValue integerValue] < 1){
        
        self.hidden = YES;
    }
    
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    CGSize size = [badgeValue sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    
    
    CGRect frame = self.frame;
    
    frame.size.width = size.width;
    
    self.frame = frame;

    
}

@end
