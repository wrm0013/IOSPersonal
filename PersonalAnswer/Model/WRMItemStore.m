//
//  WRMItemStore.m
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/18.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMItemStore.h"
#import "WRMQuestionItem.h"
#import "WRMDBHellper.h"

@interface WRMItemStore()


@end

@implementation WRMItemStore

+ (instancetype)sharedStore
{
    static WRMItemStore *store;
    if (!store) {
        store = [[WRMItemStore alloc] initPrivate];
    }
    return store;
}

- (instancetype)initPrivate
{
    self = [super init];
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [WRMItemStore sharedStore]" userInfo:nil];
    return nil;
}

//根据问题、答案、所属语言创建item，并插入数据库
- (BOOL)insertQuestion:(NSString *)question answer:(NSString *)ans language:(NSString *)lang
{
    WRMQuestionItem *item = [WRMQuestionItem initWithQuestion:question andAnswer:ans andLanguage:lang];
    return [[WRMDBHellper sharedDBHelper] insertQuestion:item];
}

//获取所有的item，从数据库中获取
- (NSArray *)allItems
{
    return [[WRMDBHellper sharedDBHelper] selectAllFromQuestion];
}



//更新item，根据参数传入的item修改对应数据库中的数据
- (BOOL)updateQuestion:(WRMQuestionItem *)newItem
{
    return nil;
}

//从数据库中删除item
- (BOOL)deleteItem:(WRMQuestionItem *)item
{
    return nil;
}

@end
