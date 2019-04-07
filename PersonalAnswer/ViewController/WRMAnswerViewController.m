//
//  WRMAnswerViewController.m
//  PersonalAnswerSystem
//
//  Created by ruisi on 2019/3/15.
//  Copyright © 2019 ruisi. All rights reserved.
//

/*
 显示在线答题成绩
 */

#import "WRMAnswerViewController.h"

@interface WRMAnswerViewController ()
/*
 这里面定义的变量和方法只能在本类中访问，外部不能访问
 */
@end

@implementation WRMAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Answer";
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Answer";
        UIImage *icon = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = icon;
    }
    return self;
}

@end
