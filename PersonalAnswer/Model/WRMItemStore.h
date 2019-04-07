//
//  WRMItemStore.h
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/18.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WRMQuestionItem;
NS_ASSUME_NONNULL_BEGIN

@interface WRMItemStore : NSObject

+ (instancetype)sharedStore;

//根据问题、答案、所属语言创建item，并插入数据库
- (BOOL)insertQuestion:(NSString *)question answer:(NSString *)ans language:(NSString *)lang;
//获取所有的item，从数据库中获取
- (NSArray *)allItems;
//更新item，根据参数传入的item修改对应数据库中的数据
- (BOOL)updateQuestion:(WRMQuestionItem *)newItem;
//从数据库中删除item
- (BOOL)deleteItem:(WRMQuestionItem *)item;

@end

NS_ASSUME_NONNULL_END
