//
//  WRMDBHellper+Delete.m
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/19.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMDBHellper+Delete.h"
#import "WRMDBHellper.h"
#import "FMDatabase.h"

@implementation WRMDBHellper (Delete)

-(BOOL)deleteItem:(NSString *)questionID
{
    FMDatabase *db = [[WRMDBHellper sharedDBHelper] getDb];
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from db_question where questionID = %@",questionID];
       BOOL result = [db executeStatements:sql];
        if (result) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
        }
        [db close];
        return result;
    }
    return NO;
}


@end
