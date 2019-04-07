//
//  WRMQuestionItem.h
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/18.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WRMQuestionItem : NSObject

@property(nonatomic, copy) NSString *userID;

@property(nonatomic, copy) NSString *questionID;

@property(nonatomic, copy) NSString *questionName;

@property(nonatomic, copy) NSString *answer;

@property(nonatomic, copy) NSString *language;

@property(nonatomic, copy) NSString *createTime;

@property(nonatomic, copy) NSString *updateTime;

+ (instancetype)initWithQuestion:(NSString *)question andAnswer:(NSString *)answer andLanguage:(NSString *)language;

@end

NS_ASSUME_NONNULL_END
