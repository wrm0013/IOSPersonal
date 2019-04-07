//
//  WRMLoginViewController.m
//  PersonalAnswerSystem
//
//  Created by ruisi on 2019/3/15.
//  Copyright © 2019 ruisi. All rights reserved.
//

/*
 登录页面
 */

#import "WRMLoginViewController.h"
#import "WRMRegisterViewController.h"
#import "WRMDBHellper.h"
#import "UserModel.h"

@interface WRMLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *signin;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)lgoin:(id)sender;
- (IBAction)signIn:(id)sender;

@end

@implementation WRMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _login.layer.cornerRadius = 8;
    _signin.layer.cornerRadius = 8;
    _signin.backgroundColor = [UIColor redColor];
    _passwordField.secureTextEntry = YES;
    [self setButtonNormal];
    [self.userNameField addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setButtonNormal
{
    _login.backgroundColor = [UIColor lightGrayColor];
    _login.enabled = NO;
}

- (void)setButtonEditable
{
    _login.backgroundColor = [UIColor redColor];
    _login.enabled = YES;
}

- (void)textValueChanged
{
    if (self.userNameField.text.length>0&&self.passwordField.text.length>0) {
        [self setButtonEditable];
    }else{
        [self setButtonNormal];
    }
}

- (IBAction)lgoin:(id)sender {
    //保存用户名
    WRMDBHellper *helper = [WRMDBHellper sharedDBHelper];
    NSString *result = [helper selectUserWhithUserName:self.userNameField.text andPwd:self.passwordField.text];
    NSLog(@"select result is %@",result);
    [self showAlert:result];

}
//注册
- (IBAction)signIn:(id)sender {
    WRMRegisterViewController *registerController = [[WRMRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerController animated:YES];
}

- (void)showAlert:(NSString *)message
{
    UIAlertController *alertController = nil;
    if (!message) {
        message = @"登录成功！";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.userNameField.text forKey:@"userName"];
    }
    alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if ([message isEqualToString:@"登录成功！"]) {
                if (self.returnLoginResult) {
                    self.returnLoginResult([[UserModel alloc] init]);
                }
                [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
