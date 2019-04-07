//
//  WRMDBHellper.h
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/15.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "WRMQuestionItem.h"
#import "FMDatabase.h"

NS_ASSUME_NONNULL_BEGIN

@interface WRMDBHellper : NSObject

+ (instancetype)sharedDBHelper;

- (UserModel *)selectUser:(NSString *)userName;

- (NSString *)selectUserWhithUserName:(NSString *)userName andPwd:(NSString *)password;

- (BOOL)insertUser:(UserModel *)user withPassword:(NSString *)password;

- (BOOL)isExist:(NSString *)userName;

- (NSString *)selectUserID:(NSString *)userName;

- (BOOL)insertQuestion:(WRMQuestionItem *)item;

- (NSArray *)selectAllFromQuestion;

- (FMDatabase *)getDb;

@end

NS_ASSUME_NONNULL_END
