//
//  WRMAddQuestionViewController.m
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/18.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMAddQuestionViewController.h"
#import "WRMQuestionItem.h"
#import "WRMItemStore.h"

@interface WRMAddQuestionViewController ()

@end

@implementation WRMAddQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _addBtn.layer.cornerRadius = 8;
    _addBtn.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBarHidden = NO;
    
}

- (IBAction)add:(id)sender {
    if (self.questionField.text.length == 0) {
        return;
    }
    if (self.answerField.text.length == 0) {
        return;
    }
    //添加数据到数据库中
   BOOL result = [[WRMItemStore sharedStore] insertQuestion:self.questionField.text answer:self.answerField.text language:self.languageBtn.titleLabel.text];
    if (result) {
        if (self.addNewItem) {
            self.addNewItem();
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



- (IBAction)selectLanguage:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *javaAction = [UIAlertAction actionWithTitle:@"JAVA" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        self.languageBtn.titleLabel.text = @"JAVA";
    }];
    UIAlertAction *OCAction = [UIAlertAction actionWithTitle:@"Objective-C" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        self.languageBtn.titleLabel.text = @"Objective-C";
    }];
    UIAlertAction *PythonAction = [UIAlertAction actionWithTitle:@"Python" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        self.languageBtn.titleLabel.text = @"Python";
    }];
    UIAlertAction *ReactAction = [UIAlertAction actionWithTitle:@"React" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        self.languageBtn.titleLabel.text = @"React";
    }];
    [alertController addAction:javaAction];
    [alertController addAction:OCAction];
    [alertController addAction:PythonAction];
    [alertController addAction:ReactAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
