//
//  MoreViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 29/05/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation MoreViewController
{
    NSMutableArray *dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary * views = NSDictionaryOfVariableBindings(_tableView);
    
    NSArray *constraintsH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:views];
    NSArray *constraintsH2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:views];
    
    [self.view addConstraints:constraintsH1];
    [self.view addConstraints:constraintsH2];
    
    dataSource = [NSMutableArray arrayWithObjects:@[@"View Profile",@"outline_person_outline_black_36pt"],
                  @[@"Chat Settings",@"outline_settings_black_36pt"] ,
                  @[@"Notifications",@"outline_notifications_active_black_36pt"] ,
                  @[@"Blocked User",@"outline_block_black_36pt"],
                  @[@"Logout",@"outline_power_settings_new_black_36pt"],nil];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        // the tableview
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionFooterHeight = 0.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuseIdentifier = @"cellReuseIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [dataSource objectAtIndex:indexPath.row][0];
    [cell.imageView setImage:[UIImage imageNamed:[dataSource objectAtIndex:indexPath.row][1]]];
    
    [cell.imageView setClipsToBounds:YES];
    [cell.imageView.layer setCornerRadius:cell.imageView.frame.size.height/2];
    
    HexToRGBConvertor *hexToRGB = [HexToRGBConvertor new];
    [cell.imageView setTintColor:[hexToRGB colorWithHexString:@"#2636BE"]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    __weak typeof(self) weakSelf = self;
    
    switch ([indexPath row]) {
        case 0:
        {
            
            InfoPageViewController *infoPage = [InfoPageViewController new];
            infoPage.hidesBottomBarWhenPushed = YES;
            infoPage.appEntity = (User *)[CometChat getLoggedInUser];
            [weakSelf.navigationController pushViewController:infoPage animated:YES];
        }
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
        {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MembersViewController *controller = [sb instantiateViewControllerWithIdentifier:@"MembersViewController"];
            [controller setIsLoadBlocked:YES];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 4:
        {
            // logout //
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            StartUpViewController *controller = [sb instantiateViewControllerWithIdentifier:@"StartUpViewController"];
            NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
            NSDictionary * dict = [defs dictionaryRepresentation];
            for (id key in dict) {
                [defs removeObjectForKey:key];
            }
            [defs synchronize];
            [self.navigationController pushViewController:controller animated:YES];
            
        }
            break;
        default:
            break;
    }
}
@end
