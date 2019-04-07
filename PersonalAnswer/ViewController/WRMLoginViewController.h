//
//  WRMLoginViewController.h
//  PersonalAnswerSystem
//
//  Created by ruisi on 2019/3/15.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;

NS_ASSUME_NONNULL_BEGIN

typedef void (^ReturnLoginResult) (UserModel *result);

@interface WRMLoginViewController : UIViewController

@property(nonatomic, copy) ReturnLoginResult returnLoginResult;

@end

NS_ASSUME_NONNULL_END
