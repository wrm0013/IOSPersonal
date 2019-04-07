//
//  WRMQuestionItem.m
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/18.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMQuestionItem.h"
#import "WRMDBHellper.h"

@implementation WRMQuestionItem
+ (instancetype)initWithQuestion:(NSString *)question andAnswer:(NSString *)answer andLanguage:(NSString *)language
{
    WRMQuestionItem *item = [[WRMQuestionItem alloc]init];
    //获取当前时间
    NSDate *date = [NSDate date];
    //日期格式化
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yy-MM-dd HH:mm:ss";
    NSString *dateStr = [formatter stringFromDate:date];
    item.createTime = dateStr;
    item.updateTime = dateStr;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    item.userID = [[WRMDBHellper sharedDBHelper] selectUserID:[user objectForKey:@"userName"]];
    item.answer = answer;
    item.questionName = question;
    item.language = language;
    return item;
}
@end
