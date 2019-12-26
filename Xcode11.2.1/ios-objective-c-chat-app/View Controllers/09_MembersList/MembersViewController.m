//
//  MembersViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 27/05/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "MembersViewController.h"

@interface MembersViewController ()<UITableViewDelegate ,UITableViewDataSource >
@property (strong , nonatomic) UITableView *listTableView;
@property (strong , nonatomic) NSMutableArray<User *> *members;
@property (nonatomic) BOOL isMoreDataLoading;
@property (nonatomic ,strong) UIView *loadingMoreView;
@property (nonatomic ,strong) ActivityIndicatorView *footerLoader;
@property (nonatomic ,retain) GroupMembersRequest *activeMemberRequest;
@property (nonatomic ,retain) BannedGroupMembersRequest *bannedMemberRequest;
@property (nonatomic ,retain) BlockedUserRequest *blockedRequest;
@property (nonatomic ,retain) UILabel *backgroundLabel;

@end

@implementation MembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _members = [NSMutableArray new];
    
    GroupMembersRequestBuilder *builder = [[[GroupMembersRequestBuilder alloc]initWithGuid:[_group guid]] setWithLimit:30.0f];
    BannedGroupMembersRequestBuilder *bannedBuider = [[[BannedGroupMembersRequestBuilder alloc]initWithGuid:[_group guid]]setWithLimit:30.0f];
    BlockedUserRequestBuilder *blockedbuilder = [[[BlockedUserRequestBuilder alloc]init] setWithLimit:30.0f];
    
    [self configureTable:(UITableViewStylePlain)];
    
    if (_isLoadBanned) {
        _bannedMemberRequest = [[BannedGroupMembersRequest alloc]initWithBuilder:bannedBuider];
        self.title = @"Banned Members";
        
    }
    if (_isLoadActive) {
        _activeMemberRequest = [[GroupMembersRequest alloc]initWithBuilder:builder];
        self.title = @"Members";
        
    }
    if (_isLoadBlocked) {
        _blockedRequest = [[BlockedUserRequest alloc]initWithBuilder: blockedbuilder];
        self.title = @"Blocked Users";
        
    }
    
    
    [self configureFooterView];
    [self fetchNext];
}

-(void)configureTable:(UITableViewStyle)style
{
    [self.view addSubview:self.listTableView];
    [_listTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_listTableView);
    
    NSArray *horizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_listTableView]|"  options:0 metrics:nil views:views];
    NSArray *verticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_listTableView]|"  options:0 metrics:nil views:views];
    
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
    
}
-(void)configureFooterView
{
    CGRect frame = CGRectMake(0.0f, _listTableView.contentSize.height, _listTableView.bounds.size.width, _listTableView.estimatedRowHeight);
    _loadingMoreView = [[UIView alloc]initWithFrame:frame];
    [_loadingMoreView addSubview:self.footerLoader];
    _footerLoader.center = CGPointMake(_loadingMoreView.bounds.size.width/2, _loadingMoreView.bounds.size.height/2);
    
    _loadingMoreView.hidden = true;
    [_listTableView addSubview:_loadingMoreView];
    
    UIEdgeInsets insets = _listTableView.contentInset;
    insets.bottom += ActivityIndicatorView.defaultHeight;
    _listTableView.contentInset = insets;
}
-(UITableView *)listTableView
{
    if (!_listTableView) {
        
        _listTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.estimatedSectionFooterHeight = 0.0f;
        _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_listTableView setBackgroundColor:[UIColor clearColor]];
        [_listTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_listTableView setBackgroundView:self.backgroundLabel];
        [_backgroundLabel setText:@"Loading..."];
    }
    return _listTableView;
}
-(UILabel *)backgroundLabel
{
    if (!_backgroundLabel) {
        
        _backgroundLabel = [UILabel new];
        [_backgroundLabel setUserInteractionEnabled:NO];
        [_backgroundLabel setFont:[UIFont systemFontOfSize:14.0f weight:(UIFontWeightSemibold)]];
        [_backgroundLabel setAdjustsFontSizeToFitWidth:YES];
        [_backgroundLabel setTextAlignment:(NSTextAlignmentCenter)];
    }
    return _backgroundLabel;
}
-(ActivityIndicatorView *)footerLoader
{
    if (!_footerLoader) {
        _footerLoader = [[ActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    }
    return _footerLoader;
}
-(void)fetchNext
{
    
    _isMoreDataLoading = YES;
    
    if (_isLoadBanned) {
        
        [_bannedMemberRequest fetchNextOnSuccess:^(NSArray<GroupMember *> * _Nonnull _bannedMembers) {
            
            if ([_bannedMembers count] > 0) {
                
                [self->_members addObjectsFromArray:_bannedMembers];
                [self refreshContactsList];
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.backgroundLabel.text = @"No Banned Members found ";
                });
            }
        } onError:^(CometChatException * _Nullable _error) {
            
            [self refreshContactsList];
            dispatch_async(dispatch_get_main_queue(), ^{
                [Alert showAlertForError:_error in:self];
            });
        }];
        
    }
    if (_isLoadActive) {
        
        [_activeMemberRequest fetchNextOnSuccess:^(NSArray<GroupMember *> * _Nonnull members) {
            
            if ([members count] > 0) {
                
                [self->_members addObjectsFromArray:members];
                [self refreshContactsList];
                
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.backgroundLabel.text = @"No Members found ";
                });
            }
            
        } onError:^(CometChatException * _Nullable _error) {
            
            [self refreshContactsList];
            dispatch_async(dispatch_get_main_queue(), ^{
                [Alert showAlertForError:_error in:self];
            });
        }];
    }
    if (_isLoadBlocked) {
        
        [_blockedRequest fetchNextOnSuccess:^(NSArray<User *> * _Nullable blockedUsers) {
            
            
            if ([blockedUsers count] > 0) {
                
                [self->_members addObjectsFromArray:blockedUsers];
                [self refreshContactsList];
                
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.backgroundLabel.text = @"No Blocked User found ";
                });
            }
            
            
        } onError:^(CometChatException * _Nullable _error) {
            
            [self refreshContactsList];
            dispatch_async(dispatch_get_main_queue(), ^{
                [Alert showAlertForError:_error in:self];
            });
        }];
    }
}
-(void)refreshContactsList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.listTableView reloadData];
        self.isMoreDataLoading = NO;
        [self.footerLoader stopAnimating];
        [self.loadingMoreView setHidden:YES];
        [self.backgroundLabel setHidden:YES];
    });
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _members.count;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EntityListTableViewCell *cell = (EntityListTableViewCell *) [tableView dequeueReusableCellWithIdentifier:[EntityListTableViewCell reuseIdentifier]];
    
    if (cell == nil) {
        cell = [[EntityListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EntityListTableViewCell reuseIdentifier]];
    }
    [cell bind:(User*)[_members objectAtIndex:[indexPath row]] withIndexPath:indexPath];
    return cell;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self PushToNext:[_members objectAtIndex:[indexPath row]]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *ban_member = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Ban" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self banMemberAtIndexpath:indexPath];
    }];
    
    UITableViewRowAction *kick_member = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"kick" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self kickMemberAtIndexPath:indexPath];
        
    }];
    [kick_member setBackgroundColor:[UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f]];
    
    UITableViewRowAction *unBan_member = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"un Ban" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self unBanMemberAtIndexPath:indexPath];
        
    }];
    
    UITableViewRowAction *unBlock_user = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Un Block" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self unBlockUserAtIndexPath:indexPath];
    }];
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@LOGGED_IN_USER_ID]  isEqualToString:[_group owner]]) {
        
        if (_isLoadBanned) {
            return @[unBan_member];
        }
        if (_isLoadActive){
            return @[ban_member,kick_member];
        }
    }
    
    if (_isLoadBlocked) {
        return  @[unBlock_user];
    }
    
    return @[];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if(!_isMoreDataLoading){
        
        int scrollViewContentHeight = _listTableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - _listTableView.bounds.size.height;
        
        if(scrollView.contentOffset.y > scrollOffsetThreshold && _listTableView.isDragging) {
            
            _isMoreDataLoading = YES;
            CGRect frame = CGRectMake(0.0f, _listTableView.contentSize.height, _listTableView.bounds.size.width, _listTableView.estimatedRowHeight);
            _loadingMoreView.frame = frame;
            [_footerLoader startAnimating];
            [_loadingMoreView setHidden:NO];
            [self fetchNext];
        }
    }
}
-(void)kickMemberAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    [CometChatProRequests kick:[_members objectAtIndex:[indexPath row]] fromGroup:_group in:self onSuccess:^(bool kicked) {
        
        if (kicked) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                __typeof__(self) strongSelf = weakSelf;
                [strongSelf->_listTableView beginUpdates];
                NSIndexPath* rowToDelete = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                NSArray* rowsToReload = [NSArray arrayWithObjects:rowToDelete, nil];
                [strongSelf->_listTableView deleteRowsAtIndexPaths:rowsToReload withRowAnimation:(UITableViewRowAnimationFade)];
                [strongSelf->_members removeObject:[strongSelf->_members objectAtIndex:indexPath.row]];
                [strongSelf->_listTableView endUpdates];
            });
        }
    }];
}
-(void)banMemberAtIndexpath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    [CometChatProRequests banMember:[_members objectAtIndex:[indexPath row]] fromGroup:_group in:self onSuccess:^(bool banned) {
        
        if (banned) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                __typeof__(self) strongSelf = weakSelf;
                [strongSelf->_listTableView beginUpdates];
                NSIndexPath* rowToDelete = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                NSArray* rowsToReload = [NSArray arrayWithObjects:rowToDelete, nil];
                [strongSelf->_listTableView deleteRowsAtIndexPaths:rowsToReload withRowAnimation:(UITableViewRowAnimationFade)];
                [strongSelf->_members removeObject:[strongSelf->_members objectAtIndex:indexPath.row]];
                [strongSelf->_listTableView endUpdates];
                
            });
        }
    }];
    
}
-(void)unBanMemberAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    [CometChatProRequests unBanMember:[_members objectAtIndex:[indexPath row]] fromGroup:_group in:self onSuccess:^(bool unBanned) {
        
        if (unBanned) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                __typeof__(self) strongSelf = weakSelf;
                [strongSelf->_listTableView beginUpdates];
                NSIndexPath* rowToDelete = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                NSArray* rowsToReload = [NSArray arrayWithObjects:rowToDelete, nil];
                [strongSelf->_listTableView deleteRowsAtIndexPaths:rowsToReload withRowAnimation:(UITableViewRowAnimationFade)];
                [strongSelf->_members removeObject:[strongSelf->_members objectAtIndex:indexPath.row]];
                [strongSelf->_listTableView endUpdates];
                
                
            });
        }
        
    }];
}
-(void)unBlockUserAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    [CometChatProRequests unBlock:[_members objectAtIndex:[indexPath row]] in:self onSuccess:^(bool isUnBlocked) {
        
        if (isUnBlocked) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                __typeof__(self) strongSelf = weakSelf;
                [strongSelf->_listTableView beginUpdates];
                NSIndexPath* rowToDelete = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                NSArray* rowsToReload = [NSArray arrayWithObjects:rowToDelete, nil];
                [strongSelf->_listTableView deleteRowsAtIndexPaths:rowsToReload withRowAnimation:(UITableViewRowAnimationFade)];
                [strongSelf->_members removeObject:[strongSelf->_members objectAtIndex:indexPath.row]];
                [strongSelf->_listTableView endUpdates];
            });
            
        }
        
    }];
}
-(void)PushToNext:(AppEntity *)user{
    
    User *_user = (User *)user;
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@LOGGED_IN_USER_ID]  isEqualToString:[_user uid]]) {
        return ;
    }
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ChatViewController *chatviewcontroller = [main instantiateViewControllerWithIdentifier:@"ChatViewController"];
    chatviewcontroller.hidesBottomBarWhenPushed = YES;
    [chatviewcontroller setAppEntity:user];
    [self.navigationController pushViewController:chatviewcontroller animated:YES];
    
}

@end
