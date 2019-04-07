//
//  WRMRootViewController.m
//  PersonalAnswerSystem
//
//  Created by ruisi on 2019/3/15.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMRootViewController.h"
#import "WRMQuestionTableViewController.h"
#import "WRMAnswerViewController.h"
#import "WRMPersionalViewController.h"
#import "WRMLoginViewController.h"

@interface WRMRootViewController ()<UITabBarControllerDelegate>
@property BOOL isToLogin;
@end

@implementation WRMRootViewController
NSInteger selectedIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    //答题系统
    UINavigationController *questionController = [[UINavigationController alloc]initWithRootViewController:[[WRMQuestionTableViewController alloc]init]];
    //答题成绩
    UINavigationController *answerController = [[UINavigationController alloc]initWithRootViewController:[[WRMAnswerViewController alloc]init]];
    //个人信息
    UINavigationController *personalController = [[UINavigationController alloc]initWithRootViewController:[[WRMPersionalViewController alloc]init]] ;
    self.viewControllers = @[questionController,personalController];
    self.delegate = self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //判断当前点击的item是否需要登录
    if ([viewController.tabBarItem.title isEqualToString:@"Question"]) {
        //不需要登录
        self.selectedIndex = 0;
        return YES;
    }
    //判断是否已经登录
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"userName"];
    NSLog(@"userName:%@",userName);
    if (userName) {
        return YES;
    }
    self.isToLogin = NO;
    //用户没有登录，弹框提示用户去登录
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有登录，是否马上去登录?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //跳转到登录页面
        WRMLoginViewController *loginController = [[WRMLoginViewController alloc]init];
        loginController.returnLoginResult = ^(UserModel *result){
            NSLog(@"从登录页面返回的结果%@",result);
        };
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
        if ([viewController.tabBarItem.title isEqualToString:@"Answer"]) {
            self.selectedIndex = 2;
        }else if([viewController.tabBarItem.title isEqualToString:@"Personal"]){
            self.selectedIndex = 1;
        }
        [(UINavigationController *)(tabBarController.selectedViewController)presentViewController:navController animated:YES completion:nil];
        
        self.isToLogin = YES;
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    [alertController addAction:OKAction];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
    return self.isToLogin;
}

@end
