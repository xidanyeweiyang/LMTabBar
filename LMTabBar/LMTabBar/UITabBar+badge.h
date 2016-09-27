//
//  UITabBar+badge.h
//  Zhongliang
//
//  Created by 刘明 on 16/7/13.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index;   //隐藏小红点

- (void)showBadgeOnItemIndex:(int)index andWithNum:(NSString *)num;//带数量的

@end
