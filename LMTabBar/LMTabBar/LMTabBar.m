//
//  LMTabBar.m
//  LMTabBar
//
//  Created by 刘明 on 16/9/27.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "LMTabBar.h"
#import "LMPublishButton.h"

#define kCount 5
#define kItemSelectedColor [UIColor colorWithRed:113/255.0f green:109/255.0f blue:104/255.0f alpha:1]
#define kItemNomalColor [UIColor colorWithRed:51/255.0f green:153/255.0f blue:255/255.0f alpha:1]

@interface LMTabBar ()<UITabBarDelegate>

@property (nonatomic, strong) LMPublishButton *publishButton;


@end


@implementation LMTabBar


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        LMPublishButton *button = [LMPublishButton lm_publishButton];
        [self addSubview:button];
        self.publishButton = button;
        
        self.delegate = self;
    }
    
    return self;
}



- (void)layoutSubviews{
    
    
    NSLog(@"%s",__func__);
    
    [super layoutSubviews];
    
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    
    CGFloat buttonW = barWidth / kCount;
    CGFloat buttonH = barHeight - 2;
    CGFloat buttonY = 1;
    
    NSInteger buttonIndex = 0;
    
    self.publishButton.center = CGPointMake(barWidth * 0.5, barHeight * 0.3);
    
    for (UIView *view in self.subviews) {
        
        NSString *viewClass = NSStringFromClass([view class]);
        
        if (![viewClass isEqualToString:@"UITabBarButton"]) continue;
        
        CGFloat buttonX = buttonIndex * buttonW;

        if (buttonIndex >= 2) { // 右边2个按钮
            buttonX += buttonW;
        }
        
        view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        buttonIndex ++;
        
    }
}




- (void)addAnimationToView:(UIView *)view{
    
    CAKeyframeAnimation *bounceAnimation = [[CAKeyframeAnimation alloc] init];
    
    bounceAnimation.keyPath = @"transform.scale";
    
    bounceAnimation.values = @[@1.0 ,@1.4, @0.9, @1.15, @0.95, @1.02, @1.0];
    
    bounceAnimation.duration = 0.6;
    
    bounceAnimation.calculationMode = kCAAnimationCubic;
    
    [view.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
//    UIImage *renderImage = [iconView.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    iconView.image = renderImage;
//    
//    iconView.tintColor = self.iconSelctexColor;

}


@end
