//
//  WRMAddQuestionViewController.h
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/18.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WRMQuestionItem;
NS_ASSUME_NONNULL_BEGIN

typedef void (^AddNewItem) ();

@interface WRMAddQuestionViewController : UIViewController

@property(nonatomic, copy) AddNewItem addNewItem;

@property (weak, nonatomic) IBOutlet UITextField *questionField;
@property (weak, nonatomic) IBOutlet UITextField *answerField;
@property (weak, nonatomic) IBOutlet UIButton *languageBtn;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)add:(id)sender;
- (IBAction)selectLanguage:(id)sender;

@end

NS_ASSUME_NONNULL_END
