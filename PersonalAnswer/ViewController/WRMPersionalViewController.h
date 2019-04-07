//
//  WRMPersionalViewController.h
//  PersonalAnswerSystem
//
//  Created by ruisi on 2019/3/15.
//  Copyright © 2019 ruisi. All rights reserved.
//

/*
 个人信息
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WRMPersionalViewController : UIViewController
/*
 这里面定义外部可以访问的变量和方法
 */
@property (weak, nonatomic) IBOutlet UIButton *sexField;
- (IBAction)choiceSex:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *userNameField;
@property (weak, nonatomic) IBOutlet UIButton *birthField;
- (IBAction)choiceBirth:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *eduction;
- (IBAction)choiceEduction:(id)sender;

@end

NS_ASSUME_NONNULL_END
