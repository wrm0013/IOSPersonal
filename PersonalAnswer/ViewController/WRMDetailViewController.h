//
//  WRMDetailViewController.h
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/19.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WRMQuestionItem;

NS_ASSUME_NONNULL_BEGIN

typedef void (^EditItem) (WRMQuestionItem *item);

@interface WRMDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *questionField;
@property (weak, nonatomic) IBOutlet UITextField *answerFiled;

@property(nonatomic,copy) EditItem editItem;

@property(nonatomic, strong) WRMQuestionItem *item;
@property (weak, nonatomic) IBOutlet UIButton *comitBtn;
- (IBAction)comitItem:(id)sender;

@end

NS_ASSUME_NONNULL_END
