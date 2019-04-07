//
//  WRMDBHellper+Update.h
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/19.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMDBHellper.h"
@class WRMQuestionItem;

NS_ASSUME_NONNULL_BEGIN

@interface WRMDBHellper (Update)

- (BOOL)updateItem:(WRMQuestionItem *)item ;

@end

NS_ASSUME_NONNULL_END
