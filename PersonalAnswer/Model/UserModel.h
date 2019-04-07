//
//  UserModel.h
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/16.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property(nonatomic, copy) NSString *userName;

@property(nonatomic, copy) NSString *token;
//用户id
@property(nonatomic, copy) NSString *userID;
//注册时间
@property(nonatomic, readonly, copy) NSString *createDate;
//性别
@property(nonatomic, copy) NSString *sex;
//年龄
@property(nonatomic, copy) NSString *age;
//学历
@property(nonatomic, copy) NSString *education;
//出生日期
@property(nonatomic, copy) NSString *dateOfBirth;

- (instancetype)initWithName:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END
