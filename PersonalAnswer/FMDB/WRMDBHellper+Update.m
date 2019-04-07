//
//  WRMDBHellper+Update.m
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/19.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMDBHellper+Update.h"
#import "WRMDBHellper.h"
#import "FMDatabase.h"

@implementation WRMDBHellper (Update)
- (BOOL)updateItem:(WRMQuestionItem *)item
{
    
    FMDatabase *db = [[WRMDBHellper sharedDBHelper] getDb];
    if ([db open]) {
        NSString *sql = @"select * from db_question where questionID = ?";
        FMResultSet *querySet = [db executeQuery:sql,item.questionID];
        if ([querySet next]) {
            NSString *str = @"update db_question set questionName=?, answer=?, updateTime=? where questionID=?";
            BOOL result = [db executeUpdate:str,item.questionName,item.answer,item.updateTime,item.questionID];
            if (result) {
                NSLog(@"数据库更新成功");
            }else{
                NSLog(@"数据库更新失败");
            }
            [db close];
            return result;
        }
        [db close];
        return NO;
    }
    return NO;
}

@end
