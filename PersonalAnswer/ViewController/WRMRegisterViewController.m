//
//  WRMRegisterViewController.m
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/18.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMRegisterViewController.h"
#import "UserModel.h"
#import "WRMDBHellper.h"

@interface WRMRegisterViewController ()

@end

@implementation WRMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signBtn.layer.cornerRadius = 8;
    self.signBtn.backgroundColor = [UIColor redColor];
    _passwordField.secureTextEntry = YES;
}


- (IBAction)signIn:(id)sender {
    if (self.userNameField.text.length == 0) {
        [self showAlert:@"请输入用户名" isSucess:NO];
        return;
    }
    if (self.passwordField.text.length == 0) {
        [self showAlert:@"请输入密码" isSucess:NO];
        return;
    }
    if (self.userNameField.text.length > 0 && self.passwordField.text.length > 0) {
        [self registerUser];
    }
}

- (void)registerUser{
    UserModel *userModel = [[UserModel alloc] initWithName:self.userNameField.text];
    BOOL isExist = [[WRMDBHellper sharedDBHelper] isExist:self.userNameField.text];
    if (!isExist) {
        BOOL restlt = [[WRMDBHellper sharedDBHelper] insertUser:userModel withPassword:self.passwordField.text];
        NSString *message;
        if (restlt) {
            message = @"注册成功！";
        }else{
            message = @"注册失败！";
        }
            [self showAlert:message isSucess:restlt];
    }else{
        [self showAlert:@"用户名已存在！" isSucess:NO];
    }
}


- (void)showAlert:(NSString *)message isSucess:(BOOL)success
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
