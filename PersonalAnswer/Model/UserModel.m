//
//  UserModel.m
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/16.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithName:(NSString *)userName
{
    self = [super init];
    if (self) {
        //获取当前时间
        NSDate *date = [NSDate date];
        //日期格式化
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yy-MM-dd HH:mm:ss";
        NSString *dateStr = [formatter stringFromDate:date];
        NSLog(@"dateStr is %@",dateStr);
        NSString *timeStamp = [self getTimestamp:date];
        NSLog(@"timeStamp is %@",timeStamp);
        _userName = userName;
        _token = timeStamp;
        _userID = [timeStamp substringFromIndex:5];
        _createDate = dateStr;
        _sex = @" ";
        _age = @" ";
        _education = @" ";
        _dateOfBirth = @" ";
        
    }
    return self;
}

//获取时间戳
- (NSString *)getTimestamp:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yy-MM-dd HH:mm:ss";
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    return [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]*1000];
}

@end
