//
//  WRMQuestionTableViewController.m
//  PersonalAnswer
//
//  Created by ruisi on 2019/3/18.
//  Copyright © 2019 ruisi. All rights reserved.
//

#import "WRMQuestionTableViewController.h"
#import "WRMAddQuestionViewController.h"
#import "WRMDetailViewController.h"
#import "WRMLoginViewController.h"
#import "WRMDBHellper+Delete.h"
#import "WRMItemStore.h"
#import "WRMQuestionItem.h"

@interface WRMQuestionTableViewController ()<UITableViewDataSource>

@property(nonatomic, copy) NSArray *items;

@end

@implementation WRMQuestionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (instancetype)init
{
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tabBarItem.title = @"Question";
        UIImage *icon = [UIImage imageNamed:@"Time.png"];
        self.tabBarItem.image = icon;
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Question";
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
        navItem.leftBarButtonItem = self.editButtonItem;
        navItem.rightBarButtonItem = barItem;
    }
    _items = [[WRMItemStore sharedStore] allItems];
    return self;
}

- (IBAction)addItem:(id)sender
{
    //判断是否已经登录
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"userName"];
    NSLog(@"userName:%@",userName);
    if (userName) {
        WRMAddQuestionViewController *addController = [[WRMAddQuestionViewController alloc]init];
        addController.addNewItem = ^{
            self.items = [[WRMItemStore sharedStore] allItems];
            [self.tableView reloadData];
        };
        [self.navigationController presentViewController:addController animated:YES completion:nil];
    }else{
        WRMLoginViewController *loginController = [[WRMLoginViewController alloc]init];
        loginController.returnLoginResult = ^(UserModel *result){
            NSLog(@"从登录页面返回的结果%@",result);
        };
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
        [self.navigationController presentViewController:navController animated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
//    [self.tableView reloadData];
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
//    NSArray *items = [[WRMItemStore sharedStore]allItems];
    WRMQuestionItem *item = _items[indexPath.row];
    cell.textLabel.text = [item questionName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WRMDetailViewController *detailController = [[WRMDetailViewController alloc]init];
    detailController.editItem = ^(WRMQuestionItem *item){
        self.items = [[WRMItemStore sharedStore] allItems];
        [self.tableView reloadData];
    };
    detailController.item = _items[indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
