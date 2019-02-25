//
//  AppDelegate.h
//  BaseProject
//
//  Created by 曹老师 on 2018/5/15.
//  Copyright © 2018年 众利创投. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;



//是否显示正常的界面，还是显示应用外的界面，yes-应用外
@property (nonatomic) BOOL isPayWayVersion;


//----------------------------------- 极光推送相关 -----------------------------------

//打开应用时，是否跳转到极光推送的指定页面
@property (nonatomic) BOOL isShowJPushView;

//----------------------------------- end：极光推送相关 -----------------------------------

//----------------------------------- 融云IM即时通讯 -----------------------------------

//自己封装的连接IM的方法，以便不同的视图去调用
- (void)connectImWithToken:(NSString *)userToke;

//打开应用时是否是通知打开的，是-yes，否-no
@property (nonatomic) BOOL isShowIMListView;


//----------------------------------- end：融云IM即时通讯 -----------------------------------



@end

