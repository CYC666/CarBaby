//
//  AppDelegate.m
//  BaseProject
//
//  Created by 曹老师 on 2018/5/15.
//  Copyright © 2018年 众利创投. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking.h>
#import "SOAPUrlSession.h"
#import "Reachability.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "EncryptForInterface.h"
#import "UserInformation.h"
#import "NSDictionary+Unicode.h"
#import "JRSwizzle.h"

//-----------------------------12346------ 极光推送相关 -----------------------------------
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h> // 这里是iOS10需要用到的框架
#endif

static NSString * const JPUSHAPPKEY = @"dc32d352f5fca46d891ee5455"; // 极光appKey
static NSString * const channel = @"Publish channel"; // 固定的

#ifdef DEBUG // 开发
static BOOL const isProduction = FALSE; // 极光FALSE为开发环境
#else // 生产
static BOOL const isProduction = TRUE; // 极光TRUE为生产环境
#endif

//----------------------------------- end：极光推送相关 -----------------------------------

//----------------------------------- 融云IM即时通讯 -----------------------------------
#import <RongIMKit/RongIMKit.h>

//记得要换成正式环境的值
#define RCIM_App_Key @"qf3d5gbjq6knh"
#define RCIM_App_Secret @"BkKjf1dvaWl9"

//----------------------------------- end：融云IM即时通讯 -----------------------------------


//----------------------------------- ShareSDK的分享功能 -----------------------------------

/* mod ShareSDK的分享功能 */
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

//----------------------------------- end：ShareSDK的分享功能 -----------------------------------



@interface AppDelegate () <JPUSHRegisterDelegate,RCIMUserInfoDataSource,RCIMGroupInfoDataSource,RCIMReceiveMessageDelegate>
{
    //指定域名的可达性
    Reachability *hostReach;
    
    //用户信息单例
    UserInformation *userInfo;
    
    
}
@end

@implementation AppDelegate


//APP被杀死后，打开APP应用最开始会执行这个方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [NSDictionary jr_swizzleMethod:@selector(description) withMethod:@selector(my_description) error:nil];
    
    
    
    //融云IM即时通讯
    //    {
    //        //初始化SDK，执行一次即可
    //        [[RCIM sharedRCIM] initWithAppKey:RCIM_App_Key];
    //
    //        //设置会话列表中显示的头像形状（RC_USER_AVATAR_RECTANGLE--矩形；RC_USER_AVATAR_CYCLE--圆形）
    //        [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
    //        //设置聊天界面中显示的头像形状
    //        [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    //
    //
    //        //正在输入的状态提示
    //        [RCIM sharedRCIM].enableTypingStatus = YES;
    //
    //
    //        //-----------------------------------IM本地通知-----------------------------------
    //
    //        //对于App处在后台活动状态时，需要注册本地通知一遍执行-didReceiveLocalNotification:方法
    //        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    //        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    //
    //
    //        //点击通知栏的本地通知时，如果此时 App 已经被系统冻结（应用已经被杀死了），
    //        //那么-application:didReceiveLocalNotification:方法不会被调用，只能在这里获取
    //        UILocalNotification *localNotificationIM = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    //        if (localNotificationIM != nil && [[localNotificationIM.userInfo allKeys] containsObject:@"rc"]) {
    //            //有本地通知，这个项目的本地通知只在IM中用到，默认跳转到IM界面
    //            _isShowIMListView = YES;
    //        } else {
    //            _isShowIMListView = NO;
    //        }
    //
    //
    //        //-----------------------------------IM远程推送-----------------------------------
    //        //下面的代码是IM给的文档中的内容，但是没有兼容IOS10的情况，而且当有了极光的注册代码的话，根本不需要再这里注册了
    //        //        /**
    //        //         * 推送处理1
    //        //         */
    //        //        if ([application
    //        //             respondsToSelector:@selector(registerUserNotificationSettings:)]) {
    //        //            //注册推送, 用于iOS8以及iOS8之后的系统
    //        //            UIUserNotificationSettings *settings = [UIUserNotificationSettings
    //        //                                                    settingsForTypes:(UIUserNotificationTypeBadge |
    //        //                                                                      UIUserNotificationTypeSound |
    //        //                                                                      UIUserNotificationTypeAlert)
    //        //                                                    categories:nil];
    //        //            [application registerUserNotificationSettings:settings];
    //        //        } else {
    //        //            //注册推送，用于iOS8之前的系统
    //        //            UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
    //        //            UIRemoteNotificationTypeAlert |
    //        //            UIRemoteNotificationTypeSound;
    //        //            [application registerForRemoteNotificationTypes:myTypes];
    //        //        }
    //
    //    }
    
    
    //极光推送相关
    //    {
    //        // 注册apns通知；创建连接，弹出是否允许通知的提示
    //        if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) // iOS10
    //        {
    //            #ifdef NSFoundationVersionNumber_iOS_9_x_Max
    //            JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    //            entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
    //            [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //            #endif
    //        }
    //        else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) // iOS8, iOS9
    //        {
    //            //可以添加自定义categories
    //            [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    //
    //        }
    //        else // iOS7
    //        {
    //            //            //categories 必须为nil
    //            //            [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    //        }
    //
    //        /*
    //         *  注册极光推送：
    //         *  launchingOption 启动参数.
    //         *  appKey 一个JPush 应用必须的,唯一的标识.
    //         *  channel 发布渠道. 可选，可以写上面的channel静态对象
    //         *  isProduction 是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
    //         *  advertisingIdentifier 广告标识符（IDFA） 如果不需要使用IDFA，传nil.
    //         * 此接口必须在 App 启动时调用, 否则 JPush SDK 将无法正常工作.
    //         */
    //        //        // 广告标识符
    //        //        NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //
    //        // 如不需要使用IDFA，advertisingIdentifier 可为nil
    //        // 注册极光推送
    //        [JPUSHService setupWithOption:launchOptions appKey:JPUSHAPPKEY channel:nil apsForProduction:isProduction advertisingIdentifier:nil];
    //
    //        //判断是否是点击apns进入的应用，（应用关闭了，通过点击通知信息进入应用）
    //        //由于IM的远程和极光推送的远程公用下面的方法，所以不得不判断一下
    //        NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    //
    //        if (remoteNotification != nil) {
    //            //根据通知类的对象中是否包含“rc”关键字，来判断是否是融云的本地通知
    //            if ([[remoteNotification allKeys] containsObject:@"rc"]) {
    //                //是IM的远程推送
    //                _isShowIMListView = YES;
    //            } else {
    //                //是机关的远程推送，进行通知相关的操作，跳转到通知页面
    //                _isShowJPushView = YES;
    //                _isShowIMListView = NO;
    //            }
    //
    //        } else {
    //            _isShowJPushView = NO;
    //        }
    //
    //    }
    
    
    //mod ShareSDK的分享功能 ，1c62e14938a28 iosv1101
    //    {
    //        [ShareSDK registerApp:@"1f38926695c20"
    //
    //              activePlatforms:@[
    //                                /*@(SSDKPlatformTypeSinaWeibo),*/
    //                                @(SSDKPlatformTypeWechat),
    //                                @(SSDKPlatformTypeQQ)]
    //                     onImport:^(SSDKPlatformType platformType)
    //         {
    //             switch (platformType)
    //             {
    //                 case SSDKPlatformTypeWechat:
    //                     [ShareSDKConnector connectWeChat:[WXApi class]];
    //                     break;
    //                 case SSDKPlatformTypeQQ:
    //                     [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
    //                     break;
    //                 case SSDKPlatformTypeSinaWeibo:
    //                     [ShareSDKConnector connectWeibo:[WeiboSDK class]];
    //                     break;
    //                 default:
    //                     break;
    //             }
    //         }
    //              onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
    //         {
    //
    //             switch (platformType)
    //             {
    ////                 case SSDKPlatformTypeSinaWeibo:
    ////                     //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权  暂时没有用到微博
    ////                     [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
    ////                                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
    ////                                             redirectUri:@"http://www.sharesdk.cn"
    ////                                                authType:SSDKAuthTypeBoth];
    ////                     break;
    //                 case SSDKPlatformTypeWechat:
    //                     //设置微信wxc70978c2fcbe8ed7
    //                     [appInfo SSDKSetupWeChatByAppId:@"wx74425f5021cc397b"
    //                                           appSecret:@"e5c4f7be493ff773a91f577109562d50"];
    //                     break;
    //                 case SSDKPlatformTypeQQ:
    //                     //设置QQ 1105927296 S1zd5QW05Zzu3pKJ  QQ41EB1C80
    //                     [appInfo SSDKSetupQQByAppId:@"1106242768"
    //                                          appKey:@"PRvfysFm8p4sB1a7"
    //                                        authType:SSDKAuthTypeBoth];
    //                     break;
    //                 default:
    //                     break;
    //             }
    //         }];
    //    }
    
    
    
    
    //初始化数据库单例对象
    userInfo = [UserInformation sharedInstance];
    
    //使用NSUserDefaults来持久化应用的打开次数
    //1.获得NSUserDefaults文件
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //2.读取文件
    NSInteger loginTimes;  //登录次数
    if ([userDefaults objectForKey:@"LoginTimes"] == nil || [userDefaults integerForKey:@"LoginTimes"] == 0) {
        loginTimes = 2; //客户不需要引导页，直接给2
    } else {
        loginTimes = [userDefaults integerForKey:@"LoginTimes"] + 1;
    }
    //3.向文件中写入内容
    [userDefaults setInteger:loginTimes forKey:@"LoginTimes"];
    //3.1立即同步
    [userDefaults synchronize];
    
    
    
    
    
    
    //    //获取支付判断方式，用来shangjia时切换
    //    {
    //        [SOAPUrlSession SOAPDataWithMethod:@"GetAppPayWay" parameter:nil success:^(id responseObject) {
    //            NSDictionary *responseDic = responseObject;
    //
    //            //获取支付方式版本号
    //            NSString *payWay_Version = responseDic[@"PayWay"];
    //
    //            //当前App的系统版本号
    //            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //            NSString *app_Version = [NSString stringWithFormat:@"V%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    //
    //            if ([payWay_Version isEqualToString:app_Version]) {
    //                //使用应用外支付
    //                _isPayWayVersion = YES;
    //            } else {
    //                _isPayWayVersion = NO;
    //            }
    //
    //            //允许开始首页的标志位加1，计数1
    //            _permitFlag++;
    //        } failure:^(NSError *error) {
    //            //后台连接直接不成功
    //            NSLog(@"网络异常：连接服务器失败");
    //
    //            //网络环境差引起的没返回值，则还是做审核的
    //            _isPayWayVersion = YES;
    //
    //            //允许开始首页的标志位加1，计数1
    //            _permitFlag++;
    //        }];
    //    }
    
    
    
    
    
    
    
    
    
    
    //}
    
    
    return YES;
}



#pragma mark - 极光推送相关回调方法


// ----------------------------- 极光推送注册（后面加了融云的）-------------------------------
#pragma mark - 注册推送回调获取 DeviceToken
#pragma mark -- 成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 注册成功
    // 极光: Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    
    //IM远程推送 注册DeviceToken
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
}

#pragma mark -- 失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    // 注册失败
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


// ----------------------------极光推送点击消息后的操作（后面加了融云的）---------------------------------


#pragma mark - iOS7~ios9: 收到推送消息调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)usersInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // iOS7~ios9之后调用这个
    [JPUSHService handleRemoteNotification:usersInfo];
    NSLog(@"iOS7~ios9系统，收到通知");
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0 || application.applicationState > 0)
    {
        if (application.applicationState == UIApplicationStateActive) { //前台状态
            
        } else { //后台状态
            //在此处处理一般推送，（是在应用打开而且切入后台状态时，点击推送后进入了应用）
            if ((!_isShowJPushView) && (!_isShowIMListView)) { //和程序kill时点击会冲突
                
                if ([[usersInfo allKeys] containsObject:@"rc"]) {
                    //是IM的推送，跳转到个人中心
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"跳转到个人中心");
                        //                        //获取根目录视图
                        //                        UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                        //                        //出现：Whose view is not in the window hierarchy错误的解决办法
                        //                        while (topRootViewController.presentedViewController) {
                        //                            topRootViewController = topRootViewController.presentedViewController;
                        //                        }
                        //
                        //                        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                        //                        UITabBarController *mainTabBarView = [story instantiateViewControllerWithIdentifier:@"MainTabBarController"];
                        //                        mainTabBarView.selectedIndex = 4;
                        //                        mainTabBarView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                        //                        [topRootViewController presentViewController:mainTabBarView animated:YES completion:nil];
                    });
                    
                } else {
                    //是极光的推送，跳转到通知/私信界面
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"跳转到通知界面");
                        
                        //获取根目录视图
                        UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                        //出现：Whose view is not in the window hierarchy错误的解决办法
                        while (topRootViewController.presentedViewController) {
                            topRootViewController = topRootViewController.presentedViewController;
                        }
                        //获取故事板对象
                        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                        
                        
                        //判断是否登录，没登录直接跳转到登录界面
                        if (! [userInfo isLoginWithUserId]) {
//                            //创建登录导航控制器
//                            LFNavigationController *loginNaviView = (LFNavigationController *)[story instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
//                            LoginViewController *loginView = (LoginViewController *)loginNaviView.topViewController;
//
//                            //设置返回按钮点击后返回的界面的类名，（返回首页传“MainPage”）
//                            loginView.backToClassName = @"MainPage";
//                            loginView.goToClassName = @"MainPage";
//
//                            loginNaviView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//                            [topRootViewController presentViewController:loginNaviView animated:YES completion:nil];
                            
                        } else {
                            //push消息界面
                            //                            UINavigationController *messagePrivateNV = (UINavigationController *)[story instantiateViewControllerWithIdentifier:@"MessageInfoNavigationController"];
                            
                            //私信视图控制器
                            //                            MessageTableViewController *messageVC = (MessageTableViewController *)messagePrivateNV.topViewController;
                            //                            messageVC.isPresent = YES;
                            
                            //                            messagePrivateNV.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                            //                            [topRootViewController presentViewController:messagePrivateNV animated:YES completion:nil];
                        }
                        
                    });
                    
                }
                
            }
        }
        
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

// ---------------------------------------------------------------------------------

#pragma mark - iOS10: 收到推送消息调用(iOS10是通过Delegate实现的回调)
#pragma mark- JPUSHRegisterDelegate
#ifdef NSFoundationVersionNumber_iOS_9_x_Max

// 当程序在前台时, 收到推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    //除了一些特殊的通知可能需要跳转到指定页面，一般当程序在前台时不做处理的
    //因为只有ios10才开始支持当程序在前台时弹出远程通知消息
    
    //    NSDictionary * usersInfo = notification.request.content.userInfo;
    //    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    //    {
    //        [JPUSHService handleRemoteNotification:usersInfo];
    //        NSString *message = [NSString stringWithFormat:@"will%@", [usersInfo[@"aps"] objectForKey:@"alert"]];
    //        NSLog(@"iOS10程序在前台时收到的推送: %@", message);
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //        [alert show];
    //    }
    
    
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}


// 程序关闭后(后台状态), 通过点击推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    //判断是否是远程推送的消息
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        //        [JPUSHService handleRemoteNotification:userInfo];
        //        NSString *message = [NSString stringWithFormat:@"did%@", [userInfo[@"aps"] objectForKey:@"alert"]];
        //        NSLog(@"iOS10程序关闭后通过点击推送进入程序弹出的通知: %@", message);
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //        [alert show];
        
        UNNotificationRequest *notificationRequest = response.notification.request;
        UNNotificationContent *notificationContent = notificationRequest.content;
        
        //在此处处理一般推送，（是在应用打开而且切入后台状态时，点击推送后进入了应用）
        if ((!_isShowJPushView) && (!_isShowIMListView)) { //和程序kill时点击会冲突
            
            if ([[notificationContent.userInfo allKeys] containsObject:@"rc"]) {
                //是IM的推送，跳转到个人中心
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"跳转到个人中心");
                    //                    //获取根目录视图
                    //                    UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                    //                    //出现：Whose view is not in the window hierarchy错误的解决办法
                    //                    while (topRootViewController.presentedViewController) {
                    //                        topRootViewController = topRootViewController.presentedViewController;
                    //                    }
                    //
                    //                    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    //                    UITabBarController *mainTabBarView = [story instantiateViewControllerWithIdentifier:@"MainTabBarController"];
                    //                    mainTabBarView.selectedIndex = 4;
                    //                    mainTabBarView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    //                    [topRootViewController presentViewController:mainTabBarView animated:YES completion:nil];
                });
                
            } else {
                //是极光的推送，跳转到通知/私信界面
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"跳转到通知界面");
                    
                    //获取根目录视图
                    UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                    //出现：Whose view is not in the window hierarchy错误的解决办法
                    while (topRootViewController.presentedViewController) {
                        topRootViewController = topRootViewController.presentedViewController;
                    }
                    //获取故事板对象
                    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    //判断是否登录，没登录直接跳转到登录界面
                    if (! [userInfo isLoginWithUserId]) {
//                        //创建登录导航控制器
//                        LFNavigationController *loginNaviView = (LFNavigationController *)[story instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
//                        LoginViewController *loginView = (LoginViewController *)loginNaviView.topViewController;
//
//                        //设置返回按钮点击后返回的界面的类名，（返回首页传“MainPage”）
//                        loginView.backToClassName = @"MainPage";
//                        loginView.goToClassName = @"MainPage";
//
//                        loginNaviView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//                        [topRootViewController presentViewController:loginNaviView animated:YES completion:nil];
                        
                    } else {
                        //push消息界面
                        //                        UINavigationController *messagePrivateNV = (UINavigationController *)[story instantiateViewControllerWithIdentifier:@"MessageInfoNavigationController"];
                        //
                        //                        //私信视图控制器
                        //                        MessageTableViewController *messageVC = (MessageTableViewController *)messagePrivateNV.topViewController;
                        //                        messageVC.isPresent = YES;
                        //
                        //                        messagePrivateNV.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                        //                        [topRootViewController presentViewController:messagePrivateNV animated:YES completion:nil];
                    }
                    
                });
                
            }
        }
        
    } else if (response.notification.request.trigger == nil) {
        
        //是ios10的本地推送
        UNNotificationRequest *notificationRequest = response.notification.request;
        UNNotificationContent *notificationContent = notificationRequest.content;
        
        //IM本地通知方法didReceiveLocalNotification:一直不执行，只能在这里处理IM的本地通知了
        if ((!_isShowJPushView) && (!_isShowIMListView)) { //后台活动状态收到本地通知
            
            if ([[notificationContent.userInfo allKeys] containsObject:@"rc"]) {
                //是IM的推送，跳转到个人中心
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"跳转到个人中心");
                    //                    //获取根目录视图
                    //                    UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
                    //                    //出现：Whose view is not in the window hierarchy错误的解决办法
                    //                    while (topRootViewController.presentedViewController) {
                    //                        topRootViewController = topRootViewController.presentedViewController;
                    //                    }
                    //
                    //                    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    //                    UITabBarController *mainTabBarView = [story instantiateViewControllerWithIdentifier:@"MainTabBarController"];
                    //                    mainTabBarView.selectedIndex = 4;
                    //                    mainTabBarView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    //                    [topRootViewController presentViewController:mainTabBarView animated:YES completion:nil];
                });
            }
            
        }
        
    }
    
    //注意ios10中前台状态也可以获取通知，所以点击后需要清空icon的角标数字
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge]; //后台服务器重置角标数值为0
    
    completionHandler();  // 系统要求执行这个方法
}

#endif


//-----------------------------------end:极光推送相关回调方法--------------------------------



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"进入前台");
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //后台服务器重置角标数值为0
    [JPUSHService resetBadge];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"进入前台");
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //后台服务器重置角标数值为0
    [JPUSHService resetBadge];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    NSLog(@"应用将被杀死");
    
    [self saveContext];
}



//--------------------------------------- CoreData 自动生成的代码 ---------------------------------------

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"BaseProject"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

//--------------------------------------- end：CoreData 自动生成的代码 ---------------------------------------





//------------------------------ 融云IM即时通讯 ------------------------------

//自己封装的连接IM的方法，以便不同的视图去调用
- (void)connectImWithToken:(NSString *)userToken {
    
    //连接IM
    [[RCIM sharedRCIM] connectWithToken:userToken success:^(NSString *userId) {
        //登录成功
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        
        //设置IM用户信息提供者(协议接口)
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        
        //设置IM群组信息提供者(协议接口)
        [[RCIM sharedRCIM] setGroupInfoDataSource:self];
        
        
        /*!
         * 消息接收监听(协议接口RCIMReceiveMessageDelegate)
         * 主要有三个接口：
         *  – onRCIMReceiveMessage:left:在前台和后台活动状态时收到任何消息都会执行。
         *  – onRCIMCustomLocalNotification:withSenderName:在后台活动状态时接收到消息弹出本地通知前触发，可自定义本地通知。
         *  – onRCIMCustomAlertSound:在前台状态收到消息时收到消息会执行，可以自定义消息提示音。
         */
        [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
        
    } error:^(RCConnectErrorCode status) {
        //登录失败
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    
}




//RCIMUserInfoDataSource代理方法，获取用户信息
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    
    /*
     * 使用后台接口获取对应的userid的“昵称”、“头像”、“商铺名称”、“商铺图片”
     * 注意用户和商户作为对象时昵称和头像会不同的
     */
    
    
    NSString *method = [NSString stringWithFormat:@"GetImEntity"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         userId,@"UserId",   //UserId
                         nil];
    [SOAPUrlSession SOAPDataWithMethod:method parameter:dic success:^(id responseObject) {
        
        //-------------------------------更新数据源-------------------------------
        NSDictionary *responseDic = responseObject;
        NSLog(@"%@ ----- %@",responseDic[@"Code"],responseDic[@"Message"]);
        
        //返回的Code字段：200-成功，300-失败，400-无数据，500-内部服务异常
        NSString *responseCode = [NSString stringWithFormat:@"%@",responseObject[@"Code"]];
        
        if ([responseCode isEqualToString:@"200"]) {
            //操作成功，接口封装返回的数据对象
            NSDictionary *dataDic = responseObject[@"Data"];
            
            //用userid来作为唯一的标示，来创建IM的用户信息
            RCUserInfo *userInfoIM;
//            if ([dataDic[@"Headortrait"] isEqualToString:@""] || dataDic[@"Headortrait"] == nil) {
//                userInfoIM = [[RCUserInfo alloc] initWithUserId:dataDic[@"UserId"] name:dataDic[@"Alias"] portrait:@""];
//            } else {
//                userInfoIM = [[RCUserInfo alloc] initWithUserId:dataDic[@"UserId"] name:dataDic[@"Alias"] portrait:[NSString stringWithFormat:@"%@%@",Java_URL,dataDic[@"Headortrait"]]];
//            }
//
            return completion(userInfoIM);
            
        } else {
            //根据后端定义的错误编码，返回不同的提示
            NSLog(@"获取用户基本信息出错");
            
            return completion(nil);
        }
    } failure:^(NSError *error) {
        //后台连接直接不成功，弹出“连接服务器失败”
        NSLog(@"网络异常：连接服务器失败");
        
        return completion(nil);
    }];
    
}


//RCIMGroupInfoDataSource代理方法，获取群组信息提供者
- (void)getGroupInfoWithGroupId:(NSString *)groupId
                     completion:(void (^)(RCGroup *groupInfo))completion {
    
    //只有单聊，不需要设置
    return completion(nil);
    
}
//RCIMGroupUserInfoDataSource代理方法，获取群组信息提供者
- (void)getUserInfoWithUserId:(NSString *)userId
                      inGroup:(NSString *)groupId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    
    //只有单聊，不需要设置
    return completion(nil);
    
}



//------------------------------IM本地通知相关------------------------------

//在前台和后台活动状态时收到任何消息都会执行这个方法
- (void)onRCIMReceiveMessage:(RCMessage *)message
                        left:(int)left {
    
}

//在后台活动状态时接收到消息会执行，自定义本地通知时的回调
-(BOOL)onRCIMCustomLocalNotification:(RCMessage*)message
                      withSenderName:(NSString *)senderName {
    
    //修改应用Logo上的角标值
    NSInteger nowNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [UIApplication sharedApplication].applicationIconBadgeNumber = nowNumber+1;
    
    //使用IM自带的本地通知
    return NO;
}


// 本地通知点击后触发的方法，项目中就IM用到了本地通知，所以写在这里
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    //接入了极光推送的SDK后，ios10的系统不执行这个方法
    //ios8和ios9可以正常进入这个方法
    if ((!_isShowIMListView) && [[notification.userInfo allKeys] containsObject:@"rc"]) { //后台活动状态收到本地通知
        //跳转到个人中心
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"跳转到个人中心");
            //            //获取根目录视图
            //            UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            //            //出现：Whose view is not in the window hierarchy错误的解决办法
            //            while (topRootViewController.presentedViewController) {
            //                topRootViewController = topRootViewController.presentedViewController;
            //            }
            //
            //            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            //            UITabBarController *mainTabBarView = [story instantiateViewControllerWithIdentifier:@"MainTabBarController"];
            //            mainTabBarView.selectedIndex = 4;
            //            mainTabBarView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            //            [topRootViewController presentViewController:mainTabBarView animated:YES completion:nil];
        });
        
    }
    
}

//------------------------------IM远程推送相关------------------------------

//注册用户通知设置
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
    
}


//------------------------------ end：融云IM即时通讯 ------------------------------





@end