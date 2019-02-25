//
//  BaseRTNavigationController.m
//  BaseProject
//
//  Created by KOK on 2018/7/27.
//  Copyright © 2018年 众利创投. All rights reserved.
//

#import "BaseRTNavigationController.h"
//#import "UIImage+Common.h"
@interface BaseRTNavigationController ()

@end

@implementation BaseRTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    //去掉导航栏下面的黑线
    
    self.wcHideBottomBarWhenPush = YES;
    self.useSystemBackBarButtonItem = NO;
    self.transferNavigationBarAttributes = YES;
    
    self.navigationBar.tintColor = [UIColor blackColor];
    //self.navigationBar.barTintColor = Publie_Color;
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                               NSForegroundColorAttributeName:[UIColor blackColor]};
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    self.navigationBar.shadowImage = [self imageWithColor:Border_Color withFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.3)];
}


-(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame{
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}




@end
