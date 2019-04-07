//
//  WRMPersionalViewController.m
//  PersonalAnswerSystem
//
//  Created by ruisi on 2019/3/15.
//  Copyright © 2019 ruisi. All rights reserved.
//

/*
 个人信息
 */

#import "WRMPersionalViewController.h"
#import "WRMDBHellper.h"
#import "UserModel.h"

@interface WRMPersionalViewController ()
/*
 这里面定义的变量和方法只能在本类中访问，外部不能访问
 */

@property(nonatomic, weak)UserModel *user;

@end

@implementation WRMPersionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Personal";
//    [[WRMDBHellper sharedDBHelper] selectUserBlock:^(NSString *userName){
//
//    }];
//    _user = [[WRMDBHellper sharedDBHelper] selectUser:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]];
//    self.userNameField.text = _user.userName;
//    NSLog(@"姓名：%@年龄：%@学历：%@性别：%@生日：%@",_user.userName,_user.age,_user.education,_user.sex,_user.dateOfBirth);
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Personal";
        UIImage *icon = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = icon;
    }
    return self;
}

- (IBAction)choiceSex:(id)sender {
}
- (IBAction)choiceBirth:(id)sender {
}
- (IBAction)choiceEduction:(id)sender {
}
@end
