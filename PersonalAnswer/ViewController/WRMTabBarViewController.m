//
//  WRMTabBarViewController.m
//  PersonalAnswerSystem
//
//  Created by ruisi on 2019/3/15.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMTabBarViewController.h"
#import "WRMQuestionViewController.h"
#import "WRMAnswerViewController.h"
#import "WRMPersionalViewController.h"
#import "WRMLoginViewController.h"

@interface WRMTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation WRMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //答题系统
    WRMQuestionViewController *questionController = [[WRMQuestionViewController alloc]init];
    //答题成绩
    WRMAnswerViewController *answerController = [[WRMAnswerViewController alloc]init];
    //个人信息
    WRMPersionalViewController *personalController = [[WRMPersionalViewController alloc]init];
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    tabBarController.viewControllers = @[questionController,answerController,personalController];
    tabBarController.delegate = self;
    self.view = tabBarController;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //判断当前点击的item是否需要登录
    if ([viewController.tabBarItem.title isEqualToString:@"Question"]) {
        //不需要登录
        return YES;
    }
    //判断是否已经登录
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"userName"];
    NSLog(@"userName:%@",userName);
    if (userName) {
        return YES;
    }
    
    //用户没有登录，弹框提示用户去登录
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有登录，是否马上去登录?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //跳转到登录页面
        WRMLoginViewController *loginController = [[WRMLoginViewController alloc]init];
        
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    [alertController addAction:OKAction];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
    return NO;
}

@end
