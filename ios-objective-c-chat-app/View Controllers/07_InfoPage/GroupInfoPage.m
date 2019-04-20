//
//  GroupInfoPage.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 27/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "GroupInfoPage.h"

@interface GroupInfoPage ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *_tableView;
@property (nonatomic ,retain) GroupMembersRequest *activeMemberRequest;
@property (nonatomic ,retain) BannedGroupMembersRequest *bannedMemberRequest;
@property (strong, nonatomic)  NSMutableArray<GroupMember *> * activeMembersList;
@property (strong, nonatomic)  NSMutableArray<GroupMember *> * inActiveMembersList;
@property (strong , nonatomic) UISegmentedControl *segmentedControl;

@end

@implementation GroupInfoPage
{
    NSUInteger selectedIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self._tableView];
    
    GroupMembersRequestBuilder *builder = [[[GroupMembersRequestBuilder alloc]initWithGuid:[_group guid]] setWithLimit:30.0f];
    
    //[[[GroupMembersRequestBuilder alloc]initWithGuid:[_group guid]] setLimitWithLimit:30.0f];
    _activeMemberRequest = [[GroupMembersRequest alloc]initWithBuilder:builder];
    
    BannedGroupMembersRequestBuilder *bannedBuider = [[[BannedGroupMembersRequestBuilder alloc]initWithGuid:[_group guid]]setWithLimit:30.0f];
    
    //[[[BannedGroupMembersRequestBuilder alloc]initWithGuid:[_group guid]]setLimitWithLimit:30.0f];
    _bannedMemberRequest = [[BannedGroupMembersRequest alloc]initWithBuilder:bannedBuider];
    
    _activeMembersList = [NSMutableArray new];
    _inActiveMembersList = [NSMutableArray new];
    
    selectedIndex = 0;
    
    [self fetchNextActiveMembers];
    [self fetchNextInActiveMembers];
    
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"Active",@"Banned"]];
    _segmentedControl.selectedSegmentIndex = selectedIndex ;
    [_segmentedControl addTarget:self action:@selector(SegmentChangeViewValueChanged:) forControlEvents:UIControlEventValueChanged];
    
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
        __tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return __tableView;
}
-(void)fetchNextActiveMembers{
    
    [_activeMemberRequest fetchNextOnSuccess:^(NSArray<GroupMember *> * _Nonnull members) {
        
        [_activeMembersList addObjectsFromArray:members];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSIndexSet *section = [NSIndexSet indexSetWithIndex:5];
            [__tableView reloadSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
            
        });
    } onError:^(CometChatException * _Nullable error) {
        
        NSLog(@"Error %@",[error errorDescription]);
        
    }];
}
-(void)fetchNextInActiveMembers
{
    
    [_bannedMemberRequest fetchNextOnSuccess:^(NSArray<GroupMember *> * _Nonnull _bannedMembers) {
        
        if (_bannedMembers) {
            
            [_inActiveMembersList addObjectsFromArray:_bannedMembers];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSIndexSet *section = [NSIndexSet indexSetWithIndex:5];
                [__tableView reloadSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
                
            });
        }
        
    } onError:^(CometChatException * _Nullable _error) {
        
        NSLog(@"%@",[_error errorDescription]);
    }];
    
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"reuseIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier];
    }
    
    switch ([indexPath section]) {
            
        case 0:
        {
            
            EntityDetailsTableViewCell *entityCell = (EntityDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[EntityDetailsTableViewCell cellIdentifier]];
            
            if (!entityCell) {
                
                entityCell = [[EntityDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityDetailsTableViewCell cellIdentifier]];
            }
            entityCell.tag = indexPath.row;
            
            entityCell.titleLbl.text = _group.name;
            
            switch ([_group groupType]) {
                    
                case groupTypePublic:
                    entityCell.statusLbl.text = @"Public Group";
                    break;
                case groupTypePrivate:
                    entityCell.statusLbl.text = @"Private Group";
                    break;
                case groupTypePassword:
                    entityCell.statusLbl.text = @"Password Protected Group";
                    break;
            }
            
            
            
            NSString *firstLettr = [entityCell.titleLbl.text substringToIndex:1];
            Avatar *avatar = [[Avatar alloc]initWithRect:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f) fullName:firstLettr];
            [avatar setBackgroundColor:[UIColor grayColor]];
            entityCell.icon.image = [avatar imageRepresentation];
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^(void) {
                
                [DownloadManager link:[self->_group icon] completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    
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
            if ([_group groupDescription]) {
                cell.textLabel.text = [_group groupDescription];
            } else {
                cell.textLabel.text = [NSString stringWithFormat:@"--"];
            }
            return cell;
            
        }
            break;
        case 2:
        {
            if ([_group owner]) {
                cell.textLabel.text = [_group owner];
            } else {
                cell.textLabel.text = [NSString stringWithFormat:@"--"];
            }
            return cell;
        }
            break;
        case 3:
        {
            if ([_group metadata]) {
                cell.textLabel.text = [_group metadata];
            } else {
                cell.textLabel.text = [NSString stringWithFormat:@"--"];
            }
            return cell;
        }
            break;
        case 4:
        {
            switch ([indexPath row]) {
                case 0:
                    if ([_group createdAt]) {
                        cell.textLabel.text = [NSString stringWithFormat:@"createdAt:%@",[[NSString stringWithFormat:@"%ld",(long)[_group createdAt]] sentAtToTime]];
                    } else {
                        cell.textLabel.text = [NSString stringWithFormat:@"--"];
                    }
                    return cell;
                    break;
                case 1:
                    if ([_group updatedAt]) {
                        cell.textLabel.text = [NSString stringWithFormat:@"updatedAt:%@",[[NSString stringWithFormat:@"%ld",(long)[_group updatedAt]] sentAtToTime]];
                    } else {
                        cell.textLabel.text = [NSString stringWithFormat:@"--"];
                    }
                    return cell;
                    break;
                case 2:
                    if ([_group joinedAt]) {
                        cell.textLabel.text = [NSString stringWithFormat:@"joinedAt:%@",[[NSString stringWithFormat:@"%ld",(long)[_group joinedAt]] sentAtToTime]];
                    } else {
                        cell.textLabel.text = [NSString stringWithFormat:@"--"];
                    }
                    return cell;
                    break;
                default:
                    break;
            }
        }
            break;
        case 5:
        {
            CustomTableViewCell *cell = (CustomTableViewCell *) [tableView dequeueReusableCellWithIdentifier:[CustomTableViewCell reuseIdentifier]];
            
            if (cell == nil) {
                cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CustomTableViewCell reuseIdentifier]];
            }
            switch (selectedIndex) {
                case 0:
                    [cell bind:(User *)[_activeMembersList objectAtIndex:[indexPath row]] withIndexPath:indexPath];
                    break;
                case 1:
                    [cell bind:(User *)[_inActiveMembersList objectAtIndex:[indexPath row]] withIndexPath:indexPath];
                    break;
                default:
                    break;
            }
            return cell;
        }
            break;
        default:
            break;
    }
    
    return [UITableViewCell new];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 7;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 4:
            return 3.0f;
            break;
        case 5:
            switch (selectedIndex) {
                case 0:
                    return [_activeMembersList count];
                    break;
                case 1:
                    return [_inActiveMembersList count];
                    break;
                default:
                    break;
            }
            
            break;
        default:
            break;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch ([indexPath section]) {
        case 0:
            return self.view.frame.size.height * 30/100;
            break;
        case 5:
            return UITableViewAutomaticDimension;
            break;
        default:
            return 44.0f;
            break;
    }
    return 0.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 5:
            return 60.0f;
            break;
        default:
            return 44.0f;
            break;
    }
    return 0.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 60.0f)];
    [view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 8.0f, 250.0, 20.0f)];
    [label setFont:[UIFont systemFontOfSize:14.0f]];
    [label setTextColor:[UIColor grayColor]];
    [view addSubview:label];
    
    switch (section) {
        case 0: { label.text = [NSString stringWithFormat:@"details:"]; }           break;
        case 1: { label.text = [NSString stringWithFormat:@"description:"]; }       break;
        case 2: { label.text = [NSString stringWithFormat:@"owner:"];}              break;
        case 3: { label.text = [NSString stringWithFormat:@"metadata:"]; }          break;
        case 4: { label.text = [NSString stringWithFormat:@"createdAt:"]; }         break;
        case 5:
        {
            label.text = [NSString stringWithFormat:@"Members:"];
            _segmentedControl.frame = CGRectMake(20.0f, label.frame.size.height + 8.0f, view.frame.size.width - 40.0f, 30.0f);
            [view addSubview:_segmentedControl];
        }
            break;
        default:
            break;
    }
    return view;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch ([indexPath section]) {
        case 5:
            if (selectedIndex == 0) {
                [self PushToNext:[_activeMembersList objectAtIndex:[indexPath row]]];
            } else {
                [self PushToNext:[_inActiveMembersList objectAtIndex:[indexPath row]]];
            }
            break;
        default:
            break;
    }
}
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *ban_member = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Ban" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self banMemberAtIndexpath:indexPath];
    }];
    ;
    
    UITableViewRowAction *kick_member = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"kick" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self kickMemberAtIndexPath:indexPath];
    }];
    [kick_member setBackgroundColor:[UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f]];
    
    UITableViewRowAction *unBan_member = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"un Ban" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self unBanMemberAtIndexPath:indexPath];
    }];
    
    switch ([indexPath section]) {
        case 5:
            switch (selectedIndex) {
                case 0:
                    return @[ban_member,kick_member];
                    break;
                case 1:
                    return @[unBan_member];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    return @[[UITableViewRowAction new]];
}

-(void)SegmentChangeViewValueChanged:(UISegmentedControl *)SControl
{
    switch (SControl.selectedSegmentIndex) {
        case 0:
            selectedIndex = 0 ;
            break;
        case 1:
            selectedIndex = 1;
            break;
        default:
            break;
    }
    NSIndexSet *section = [NSIndexSet indexSetWithIndex:5];
    [__tableView reloadSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)kickMemberAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *uid = [_activeMembersList objectAtIndex:[indexPath row]].uid;
    
    [CometChat kickGroupMemberWithUID:uid GUID:[_group guid] onSuccess:^(NSString * _Nonnull success) {
        
        
        [_activeMembersList removeObject:[_activeMembersList objectAtIndex:[indexPath row]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [__tableView deselectRowAtIndexPath:indexPath animated:YES];
            [__tableView reloadData];
        });
        
    } onError:^(CometChatException * _Nullable error) {
        
    }];
}
-(void)banMemberAtIndexpath:(NSIndexPath *)indexPath
{
    NSString *uid = [_activeMembersList objectAtIndex:[indexPath row]].uid;
    
    [CometChat banGroupMemberWithUID:uid GUID:[_group guid] onSuccess:^(NSString * _Nonnull success) {
        
        [_inActiveMembersList addObject:[_activeMembersList objectAtIndex:[indexPath row]]];
        [_activeMembersList removeObject:[_activeMembersList objectAtIndex:[indexPath row]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [__tableView deselectRowAtIndexPath:indexPath animated:YES];
            [__tableView reloadData];
        });
        
    } onError:^(CometChatException * _Nullable error ) {
        
    }];
}
-(void)unBanMemberAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *uid = [_inActiveMembersList objectAtIndex:[indexPath row]].uid;
    [CometChat unbanGroupMemberWithUID:uid GUID:[_group guid] onSuccess:^(NSString * _Nonnull success) {
        
        [_activeMembersList addObject:[_inActiveMembersList objectAtIndex:[indexPath row]]];
        [_inActiveMembersList removeObject:[_inActiveMembersList objectAtIndex:[indexPath row]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [__tableView deselectRowAtIndexPath:indexPath animated:YES];
            [__tableView reloadData];
        });
    } onError:^(CometChatException * _Nullable error) {
        
    }];
}
-(void)PushToNext:(AppEntity *)user{
    
    User *_user = (User *)user;
    
    if ([[[[NSUserDefaults standardUserDefaults]objectForKey:@LOGGED_IN_USER_ID] lowercaseString] isEqualToString:[_user uid]]) {
        return ;
    }
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ChatViewController *chatviewcontroller = [main instantiateViewControllerWithIdentifier:@"ChatViewController"];
    chatviewcontroller.hidesBottomBarWhenPushed = YES;
    [chatviewcontroller setAppEntity:user];
    [self.navigationController pushViewController:chatviewcontroller animated:YES];
    
}
@end

