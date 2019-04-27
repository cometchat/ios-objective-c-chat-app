//
//  UserInfoPage.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 27/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "UserInfoPage.h"

@interface UserInfoPage ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *_tableView;
@end

@implementation UserInfoPage

static NSString *cellIdentifier = @"reuseIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self._tableView];
}

-(UITableView *)_tableView {
    
    if (!__tableView) {
        
        // the tableview
        __tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        __tableView.delegate = self;
        __tableView.dataSource = self;
        __tableView.estimatedRowHeight = 60;
        __tableView.rowHeight = UITableViewAutomaticDimension;
        __tableView.estimatedSectionFooterHeight = 0.0f;
        __tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        __tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [__tableView registerClass:EntityDetailsTableViewCell.class forCellReuseIdentifier:EntityDetailsTableViewCell.cellIdentifier];
        [__tableView registerClass:EntityOtherDetailsTableViewCell.class forCellReuseIdentifier:EntityOtherDetailsTableViewCell.cellIdentifier];
    }
    return __tableView;
}
-(void)logOutUser
{
    [CometChat logoutOnSuccess:^(NSString * _Nonnull isSuccess) {
        
        NSLog(@"%@",isSuccess);
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        LoginViewController *lg = [sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:lg animated:YES completion:^{
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@LOGGED_IN_USER_ID];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@IS_LOGGED_IN];
        }];
        
    } onError:^(CometChatException * _Nonnull error) {
        
        NSLog(@"%@",[error errorDescription]);
    }];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch ([indexPath section]) {
            
        case 0:
        {
            
            EntityDetailsTableViewCell *entityCell = (EntityDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[EntityDetailsTableViewCell cellIdentifier]];
            
            if (!entityCell) {
                
                entityCell = [[EntityDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityDetailsTableViewCell cellIdentifier]];
            }
            entityCell.tag = indexPath.row;
            
            entityCell.titleLbl.text = _user.name;
            entityCell.statusLbl.text = [NSString stringWithFormat:@"last active at :%@",[[NSString stringWithFormat:@"%ld",(long)_user.lastActiveAt]sentAtToTime]];
                    
            NSString *firstLettr = [entityCell.titleLbl.text substringToIndex:1];
            Avatar *avatar = [[Avatar alloc]initWithRect:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f) fullName:firstLettr];
            [avatar setBackgroundColor:[UIColor grayColor]];
            entityCell.icon.image = [avatar imageRepresentation];
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^(void) {
                
                [DownloadManager link:[self->_user avatar] completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    
                    if (data) {
                        UIImage* image = [[UIImage alloc] initWithData:data];
                        if (image) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (entityCell.tag == indexPath.row) {
                                    entityCell.icon.image = image;
                                    [entityCell setNeedsLayout];
                                    [entityCell layoutIfNeeded];
                                }
                            });
                        }
                    }
                }];
            });
            
            [entityCell setNeedsLayout];
            [entityCell layoutIfNeeded];
            
            return entityCell;
        }
            
            break;
        case 1:
        {
            
            EntityOtherDetailsTableViewCell *otherCell = [[EntityOtherDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityOtherDetailsTableViewCell cellIdentifier]];
            
            if (_user.email) {
                otherCell.alabel.text = _user.email;
            } else {
                otherCell.alabel.text = [NSString stringWithFormat:@"--"];
            }
            return otherCell;
            
        }
            break;
        case 2:
        {
            EntityOtherDetailsTableViewCell *otherCell = [[EntityOtherDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityOtherDetailsTableViewCell cellIdentifier]];
            
            if (_user.statusMessage) {
                otherCell.alabel.text = _user.statusMessage;
            } else {
                otherCell.alabel.text= [NSString stringWithFormat:@"--"];
            }
            return otherCell;
        }
            break;
        case 3:
        {
            EntityOtherDetailsTableViewCell *otherCell = [[EntityOtherDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityOtherDetailsTableViewCell cellIdentifier]];
            
            if (_user.role) {
                otherCell.alabel.text = _user.role;
            } else {
                otherCell.alabel.text = [NSString stringWithFormat:@"--"];
            }
            return otherCell;
        }
            break;
        case 4:
        {
            EntityOtherDetailsTableViewCell *otherCell = [[EntityOtherDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityOtherDetailsTableViewCell cellIdentifier]];
            
            if (_user.link) {
                otherCell.alabel.text = _user.link;
            } else {
                otherCell.alabel.text = [NSString stringWithFormat:@"--"];
            }
            return otherCell;
        }
            break;
        case 5:
        {
            
            EntityOtherDetailsTableViewCell *otherCell = [[EntityOtherDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityOtherDetailsTableViewCell cellIdentifier]];
            
            if (_user.email) {
                otherCell.alabel.text = _user.email;
            } else {
                otherCell.alabel.text = [NSString stringWithFormat:@"--"];
            }
            return otherCell;
        }
            break;
        case 6:
        {
            
            EntityOtherDetailsTableViewCell *otherCell = [[EntityOtherDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityOtherDetailsTableViewCell cellIdentifier]];
            
            if (_user.credits) {
                otherCell.alabel.text = [NSString stringWithFormat:@"%ld",(long)_user.credits];
            } else {
                otherCell.alabel.text = [NSString stringWithFormat:@"--"];
            }
            return otherCell;
        }
            break;
        case 7:
        {
            
            EntityOtherDetailsTableViewCell *otherCell = [[EntityOtherDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityOtherDetailsTableViewCell cellIdentifier]];
            
            
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@LOGGED_IN_USER_ID]  isEqualToString:[_user uid]]) {
                
                otherCell.alabel.text = [NSString stringWithFormat:@"Logout"];
                otherCell.alabel.textColor = [UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f];
                otherCell.alabel.textAlignment = NSTextAlignmentCenter;
                [otherCell.alabel setFont:[UIFont systemFontOfSize:20]];
                return otherCell;
            }
            
        }
            break;
        default:
            break;
    }
    
    return [UITableViewCell new];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@LOGGED_IN_USER_ID]  isEqualToString:[_user uid]]) {
        return 9;
    }
    return 8;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch ([indexPath section]) {
        case 0:
            return self.view.frame.size.height * 30/100;
            break;
        default:
            return 44.0f;
            break;
    }
    return 0.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 44.0)];
    [view setBackgroundColor:[UIColor whiteColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0, view.frame.size.height - 30.0, 250.0, 25.0)];
    [label setFont:[UIFont systemFontOfSize:20.0f]];
    [view addSubview:label];
    
    switch (section) {
        case 0: { label.text = [NSString stringWithFormat:@""]; }       break;
        case 1: { label.text = [NSString stringWithFormat:@"email-id"]; }      break;
        case 2: { label.text = [NSString stringWithFormat:@"status"];}         break;
        case 3: { label.text = [NSString stringWithFormat:@"role"]; }          break;
        case 4: { label.text = [NSString stringWithFormat:@"link"]; }          break;
        case 5: { label.text = [NSString stringWithFormat:@"metadata"]; }      break;
        case 6: { label.text = [NSString stringWithFormat:@"credits"]; }       break;
        case 7:
        {
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@LOGGED_IN_USER_ID]  isEqualToString:[_user uid]]) {
                label.text = [NSString stringWithFormat:@"logout"];
            }
            
        }       break;
        default:
            break;
    }
    return view;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch ([indexPath section]) {
        case 7:
            switch ([indexPath row]) {
                case 0:
                    [self logOutUser];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

@end
