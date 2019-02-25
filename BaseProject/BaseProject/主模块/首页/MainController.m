//
//  MainController.m
//  BaseProject
//
//  Created by 曹老师 on 2019/2/25.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import "MainController.h"
#import "ShowController.h"

@interface MainController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageCtrl;   // 翻页控制器
@property (strong, nonatomic) NSMutableArray *dataArray;        // 数据源
@property (assign, nonatomic) NSInteger currentPage;            // 当前页

@end

@implementation MainController


#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
//    self.navigationController.navigationBar.hidden = YES;
    
    _dataArray = [NSMutableArray array];
    

    
    // 加载数据
    [self loadListAction:NO];
    
}

- (UIPageViewController *)pageCtrl {
    
    if (!_pageCtrl) {
        _pageCtrl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageCtrl.dataSource = self;
        [self.view addSubview:_pageCtrl.view];
        [self addChildViewController:_pageCtrl];
        [self didMoveToParentViewController:_pageCtrl];
    }
    return _pageCtrl;
    
}


#pragma mark ========================================动作响应=============================================


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
        
        // 重新加载数据
        [self loadListAction:NO];
        
        return nil;
    } else {
        ShowController *lastVC = [ShowController new];
        lastVC.model = [_dataArray objectAtIndex:index - 1];
        return lastVC;
    }
    
}
































@end
