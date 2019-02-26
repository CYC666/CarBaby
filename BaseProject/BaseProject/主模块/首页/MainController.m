//
//  MainController.m
//  BaseProject
//
//  Created by 曹老师 on 2019/2/25.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import "MainController.h"
#import "ShowController.h"
#import "MainBottomView.h"
#import "MessageController.h"
#import "EnumController.h"

@interface MainController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageCtrl;   // 翻页控制器
@property (strong, nonatomic) NSMutableArray *dataArray;        // 数据源
@property (assign, nonatomic) NSInteger currentPage;            // 当前页
@property (strong, nonatomic) MainBottomView *bottomView;       // 底部栏

@end

@implementation MainController


#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"好多钱币";

    
    
    _dataArray = [NSMutableArray array];
    

    // 布局
    self.pageCtrl.view.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, TabBar_Height);

    
    [self.bottomView.button1 addTarget:self action:@selector(messageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.button2 addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.button4 addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.button5 addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 加载数据
    [self loadListAction:NO];
    
}


- (UIPageViewController *)pageCtrl {
    
    if (!_pageCtrl) {
        _pageCtrl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageCtrl.dataSource = self;
        [self.view addSubview:_pageCtrl.view];
        _pageCtrl.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - TabBar_Height - Nav_Height);
        [self addChildViewController:_pageCtrl];
        [self didMoveToParentViewController:_pageCtrl];
    }
    return _pageCtrl;
    
}

- (MainBottomView *)bottomView {
    
    if (!_bottomView) {
        _bottomView = [[MainBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - Nav_Height - TabBar_Height, kScreenWidth, TabBar_Height)];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
    
}

#pragma mark ========================================动作响应=============================================

#pragma mark - 消息
- (void)messageButtonAction:(UIButton *)button {
    
    [self.navigationController pushViewController:[MessageController new] animated:YES];
    
}

#pragma mark - 目录
- (void)collectButtonAction:(UIButton *)button {
    
    [self.navigationController pushViewController:[EnumController new] animated:YES];
    
}

#pragma mark - 保存
- (void)saveButtonAction:(UIButton *)button {
    
    // 获取当前控制器
    ShowController *ctrl = self.pageCtrl.viewControllers.firstObject;
    
    //opaque 透明度，不透明设为YES；
    //scale  缩放因子，设0时系统自动设置缩放比例图片清晰；设1.0时模糊
    UIGraphicsBeginImageContextWithOptions(ctrl.scrollView.size, YES, 0.0);
    
    [ctrl.scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

#pragma mark - 分享
- (void)shareButtonAction:(UIButton *)button {
    
    // 获取当前控制器
    ShowController *ctrl = self.pageCtrl.viewControllers.firstObject;
    
    //opaque 透明度，不透明设为YES；
    //scale  缩放因子，设0时系统自动设置缩放比例图片清晰；设1.0时模糊
    UIGraphicsBeginImageContextWithOptions(ctrl.scrollView.size, YES, 0.0);
    
    [ctrl.scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[image] applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
    [self presentViewController: activityVC animated:YES completion:nil];
    
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        
        
        
    };
    
}

#pragma mark ========================================网络请求=============================================

#pragma mark - 获取钱币列表
- (void)loadListAction:(BOOL)isFooter {
    
    
    if (isFooter) {
        _currentPage ++;
    } else {
        _currentPage = 1;
        [_dataArray removeAllObjects];
    }
    
    [NetTool loadCoinList:_currentPage List:^(id object) {
        
        
        NSArray *list = object;
        [_dataArray addObjectsFromArray:list];
        
        if (!isFooter) {
            
            // 初次，设置控制器
            ShowController *ctrl = [ShowController new];
            ctrl.model = _dataArray.firstObject;
            [self.pageCtrl setViewControllers:@[ctrl]
                                    direction:UIPageViewControllerNavigationDirectionForward
                                     animated:YES
                                   completion:nil];
            
        }
        
        
    }];
    
}

#pragma mark ========================================代理方法=============================================

#pragma mark - 下一个
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    ShowController *vc = (ShowController *)viewController;
    NSInteger index = [_dataArray indexOfObject:vc.model];
    
    if (index == _dataArray.count - 1) {
        
        // 加载新的数据
        [self loadListAction:YES];
        
        return nil;
    } else {
        ShowController *nextVC = [ShowController new];
        nextVC.model = [_dataArray objectAtIndex:index + 1];
        return nextVC;
    }
    
    
    
}

#pragma mark - 上一个
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    ShowController *vc = (ShowController *)viewController;
    NSInteger index = [_dataArray indexOfObject:vc.model];
    
    if (index == 0) {
        
        return nil;
    } else {
        ShowController *lastVC = [ShowController new];
        lastVC.model = [_dataArray objectAtIndex:index - 1];
        return lastVC;
    }
    
}

#pragma mark - 保存图片
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error) {
        SVP_ERROR(@"保存失败")
    } else {
        SVP_SUCCESS(@"已保存到相册中")
    }
    
    
}






























@end
