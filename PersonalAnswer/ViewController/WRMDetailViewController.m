//
//  WRMDetailViewController.m
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/19.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMDetailViewController.h"
#import "WRMQuestionItem.h"
#import "WRMDBHellper+Update.h"

@interface WRMDetailViewController ()

@end

@implementation WRMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"questionName is %@",self.item.questionName);
    _comitBtn.backgroundColor = [UIColor redColor];
    _comitBtn.layer.cornerRadius = 8;
    self.questionField.text = self.item.questionName;
    self.answerFiled.text = self.item.answer;
}


- (IBAction)comitItem:(id)sender {
    
    WRMQuestionItem *item = self.item;
    item.questionName = self.questionField.text;
    item.answer = self.answerFiled.text;
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yy-MM-dd HH:mm:ss";
    item.updateTime = [formatter stringFromDate:date];
    
    WRMDBHellper *helper = [WRMDBHellper sharedDBHelper];
    BOOL result = [helper updateItem:item];
    if (result) {
        if (self.editItem) {
            self.editItem(item);
        }
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
