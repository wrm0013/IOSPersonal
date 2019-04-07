//
//  WRMDBHellper.m
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/15.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMDBHellper.h"
#import "FMDatabase.h"
#import "UserModel.h"
#import "WRMQuestionItem.h"

@interface WRMDBHellper()

@end

@implementation WRMDBHellper

FMDatabase *_db;

+ (instancetype)sharedDBHelper
{
    static WRMDBHellper *helper = nil;
    if (!helper) {
        helper = [[WRMDBHellper alloc]initPrivate];
    }
    return helper;
}

- (instancetype)init
{
    //如果调用了init函数，那么抛出异常
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        
        NSString *dbPath = [documentPath stringByAppendingString:@"question.splite"];
        
        NSLog(@"question.splite path is %@",dbPath);
        
        //初始化数据库
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        
        if ([db open]) {
            NSLog(@"question.splite open success!");
            //创建表(id,userId,问题，答案，所属语言，创建时间，修改时间)
            NSString *tableString = @"CREATE TABLE IF NOT EXISTS db_question (id integer PRIMARY KEY AUTOINCREMENT, questionID text NOT NULL, userID text NOT NULL, questionName text NOT NULL, answer text NOT NULL, language text NOT NULL,  createTime text NOT NULL, updateTime text NOT NULL)";
            //用户表
            NSString *userTable = @"CREATE TABLE IF NOT EXISTS db_user (id integer PRIMARY KEY AUTOINCREMENT, userID text NOT NULL, userName text NOT NULL, password text NOT NULL, token text NOT NULL, sex text, age text, education text,dateOfBirth text, createDate text NOT NULL)";
            BOOL result = [db executeUpdate:tableString];
            BOOL userResult = [db executeUpdate:userTable];
            if (result) {
                NSLog(@"table db_question is created success!%@",[NSString stringWithUTF8String:"创建表成功"]);
            }else{
                NSLog(@"table db_question is error!!!%@",[NSString stringWithUTF8String:"创建表失败"]);
            }
            if (userResult) {
                NSLog(@"table db_user is created success!%@",[NSString stringWithUTF8String:"创建成功"]);
            }else{
                NSLog(@"table db_user is error!!%@",[NSString stringWithUTF8String:"创建失败了！！！！"]);
            }
        }
        _db = db;
    }
    return self;
}

- (id)getDb
{
    return _db;
}

- (UserModel *)selectUser:(NSString *)userName
{
    UserModel *user = [[UserModel alloc]init];
    if ([_db open]) {
        NSString *sql= @"select * from db_user where userName = ?";
        FMResultSet *set = [_db executeQuery:sql,userName];
        if ([set next]) {
            user.userID = [set stringForColumn:@"userID"];
            user.userName = userName;
            user.token = [set stringForColumn:@"token"];
            user.education = [set stringForColumn:@"education"];
            user.sex = [set stringForColumn:@"sex"];
            user.age = [set stringForColumn:@"age"];
            user.dateOfBirth = [set stringForColumn:@"dateOfBirth"];
        }
    }
    [_db close];
    return user;
}

//根据用户名查询数据库-判断用户是否已经注册

- (NSString *)selectUserWhithUserName:(NSString *)userName andPwd:(NSString *)password
{
    if ([_db open]) {
        NSString *sql = @"select * from db_user where userName = ?";
        FMResultSet *userSet = [_db executeQuery:sql,userName];
        if ([userSet next]) {
            NSLog(@"userName is %@",[userSet stringForColumn:@"userName"]);
            NSLog(@"password is %@",[userSet stringForColumn:@"password"]);
            //已经注册，判断密码是否正确
            if ([password isEqualToString:[userSet stringForColumn:@"password"]]) {
                //密码正确
                [_db close];
                return nil;
            }
            [_db close];
            return @"用户名或密码错误，请重新输入！";
        }
        return @"用户名不存在,请先注册！";
    }
    return @"数据库异常！";
}

//根据用户名判断用户是否已经注册
- (FMResultSet *)userIsExist:(NSString *)userName
{
    NSString *sql = @"select * from db_user where userName = ?";
    if ([_db open]) {
        FMResultSet *set = [_db executeQuery:sql,userName];
        [_db close];
        return set;
    }
    return nil;
}

- (BOOL)isExist:(NSString *)userName
{
    BOOL exist = NO;
    NSString *sql = @"select * from db_user where userName = ?";
    if ([_db open]) {
        FMResultSet *set = [_db executeQuery:sql,userName];
        if ([set next]) {
            exist = YES;
        }
        [_db close];
    }
    return exist;
}

- (BOOL)insertUser:(UserModel *)user withPassword:(NSString *)password
{
    if ([_db open]) {
        NSString *sql = @"INSERT INTO db_user (userName,password,userID,token,createDate) VALUES(?, ?, ?, ?, ?)";
        NSLog(@"%@",sql);
        BOOL result = [_db executeUpdate:sql, user.userName, password, user.userID,user.token,user.createDate];
        if (result) {
            NSLog(@"添加用户成功");
        }else{
            NSLog(@"添加用户失败");
        }
        [_db close];
        return result;
    }
    return NO;
}

- (NSString *)selectUserID:(NSString *)userName
{
    NSString *userID = nil;
    NSString *sql = @"select * from db_user where userName = ?";
    if ([_db open]) {
        FMResultSet *set = [_db executeQuery:sql,userName];
        if ([set next]) {
            userID = [set stringForColumn:@"userID"];
        }
        [_db close];
    }
    return userID;
}

- (BOOL)questionIsExist:(NSString *)questionName
{
    if ([_db open]) {
        NSString *sql = @"select * from db_question where questionName = ?";
        FMResultSet *set = [_db executeQuery:sql, questionName];
        if ([set next]) {
            [_db close];
            NSLog(@"已经有这个问题了");
            return YES;
        }
        [_db close];
        NSLog(@"还没有这个问题了，可以创建");
        return NO;
    }
    return NO;
}

- (BOOL)insertQuestion:(WRMQuestionItem *)item
{
    if ([self questionIsExist:item.questionName]) {
        return NO;
    }
    
    if ([_db open]) {
        NSString *sql = @"INSERT INTO db_question (questionID,userID,questionName,answer,language,createTime,updateTime) VALUES(?,?, ?, ?, ?, ?, ?)";
        NSString *time = item.createTime;
        NSString *questionID = [time substringWithRange:NSMakeRange(time.length - 8, 8)];
        BOOL result = [_db executeUpdate:sql,questionID, item.userID,item.questionName,item.answer,item.language,item.createTime,item.updateTime];
        if (result) {
            NSLog(@"添加用户成功");
        }else{
            NSLog(@"添加用户失败");
        }
        [_db close];
        return result;
    }
    return NO;
}

- (NSArray *)selectAllFromQuestion
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    NSString *sql = @"select * from db_question";
    if ([_db open]) {
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            WRMQuestionItem *item = [[WRMQuestionItem alloc]init];
            item.questionName = [set stringForColumn:@"questionName"];
            item.questionID = [set stringForColumn:@"questionID"];
            item.answer = [set stringForColumn:@"answer"];
            item.userID = [set stringForColumn:@"userID"];
            item.language = [set stringForColumn:@"language"];
            item.createTime = [set stringForColumn:@"createTime"];
            item.updateTime = [set stringForColumn:@"updateTime"];
            [result addObject:item];
        }
        [_db close];
    }
    //排序
    NSSortDescriptor *sortDes = [[NSSortDescriptor alloc] initWithKey:@"questionName" ascending:YES];
    [result sortUsingDescriptors:@[sortDes]];
    return result;
}

@end
