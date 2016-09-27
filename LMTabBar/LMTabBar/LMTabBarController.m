//
//  LMTabBarController.m
//  LMTabBar
//
//  Created by 刘明 on 16/9/27.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "LMTabBarController.h"
#import "UITabBar+badge.h"
#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"

#define kTextNormalColor [[UIColor alloc]initWithRed:113/255.0 green:109/255.0 blue:104/255.0 alpha:1]
#define kTextSelectedColor [[UIColor alloc]initWithRed:51/255.0 green:135/255.0 blue:255/255.0 alpha:1]

#define LMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0] //<<< 用10进制表示颜色，例如（255,255,255）白色
#define LMRandomColor LMColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface LMTabBarController ()<UINavigationControllerDelegate,UITabBarControllerDelegate,UITabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation LMTabBarController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    // 设置 TabBarItemTestAttributes 的颜色。
    [self setUpTabBarItemTextAttributes];
    
    // 设置子控制器
    [self setUpChildViewController];
    
    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
    [self setUpTabBar];
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //设置导航控制器颜色为黄色
    [[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:LMColor(253, 218, 68)] forBarMetrics:UIBarMetricsDefault];
    
    
    [self.tabBar showBadgeOnItemIndex:0];
    
    [self.tabBar showBadgeOnItemIndex:1 andWithNum:@"99"];
    
    
}

#pragma mark -
#pragma mark - Private Methods

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar{
    
    [self setValue:[[LMTabBar alloc] init] forKey:@"tabBar"];
    
}


/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes{
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateHighlighted];
    
}


/**
 *  添加子控制器，我这里值添加了4个，没有占位自控制器
 */
- (void)setUpChildViewController{
    
    [self addOneChildViewController:[[ViewController alloc]init]
                          WithTitle:@"首页"
                          imageName:@"home_normal"
                  selectedImageName:@"home_highlight"];
    
    [self addOneChildViewController:[[ViewController1 alloc] init]
                          WithTitle:@"同城"
                          imageName:@"mycity_normal"
                  selectedImageName:@"mycity_highlight"];
    
    
    [self addOneChildViewController:[[ViewController2 alloc]init]
                          WithTitle:@"消息"
                          imageName:@"message_normal"
                  selectedImageName:@"message_highlight"];
    
    
    [self addOneChildViewController:[[ViewController3 alloc]init]
                          WithTitle:@"我的"
                          imageName:@"account_normal"
                  selectedImageName:@"account_highlight"];
    
   
    
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */

- (void)addOneChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    viewController.view.backgroundColor     = LMRandomColor;
    viewController.tabBarItem.title         = title;
    viewController.tabBarItem.image         = [UIImage imageNamed:imageName];
    UIImage *image = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = image;
        
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
    
}


//这个方法可以抽取到 UIImage 的分类中
- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSLog(@"%s",__func__);
    
    NSInteger index = [tabBar.items indexOfObject:item];
    
    [self addAnimationToIndex:index];
    
}

- (void)addAnimationToIndex:(NSInteger)index{
    
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CAKeyframeAnimation *bounceAnimation = [[CAKeyframeAnimation alloc] init];
    
    bounceAnimation.keyPath = @"transform.scale";
    
    bounceAnimation.values = @[@1.0 ,@1.4, @0.9, @1.15, @0.95, @1.02, @1.0];
    
    bounceAnimation.duration = 0.6;
    
    bounceAnimation.calculationMode = kCAAnimationCubic;
    
    [[tabbarbuttonArray[index] layer] addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    //    UIImage *renderImage = [iconView.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //
    //    iconView.image = renderImage;
    //
    //    iconView.tintColor = self.iconSelctexColor;
    
}

@end
