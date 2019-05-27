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
@property (strong , nonatomic) NSMutableArray<GroupMember *> *members;
@property (nonatomic) BOOL isMoreDataLoading;
@property (nonatomic ,strong) UIView *loadingMoreView;
@property (nonatomic ,strong) ActivityIndicatorView *footerLoader;
@property (nonatomic ,retain) GroupMembersRequest *activeMemberRequest;
@property (nonatomic ,retain) BannedGroupMembersRequest *bannedMemberRequest;
@end

@implementation MembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _members = [NSMutableArray new];
    
    GroupMembersRequestBuilder *builder = [[[GroupMembersRequestBuilder alloc]initWithGuid:[_group guid]] setWithLimit:30.0f];
    BannedGroupMembersRequestBuilder *bannedBuider = [[[BannedGroupMembersRequestBuilder alloc]initWithGuid:[_group guid]]setWithLimit:30.0f];
    
    if (_isLoadBanned) {
        _bannedMemberRequest = [[BannedGroupMembersRequest alloc]initWithBuilder:bannedBuider];
        self.title = @"Members";
    } else {
        _activeMemberRequest = [[GroupMembersRequest alloc]initWithBuilder:builder];
         self.title = @"Banned Members";
    }
    
    [self configureTable:(UITableViewStylePlain)];
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
    }
    return _listTableView;
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
            
            if (_bannedMembers) {
                
                [_members addObjectsFromArray:_bannedMembers];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_listTableView reloadData];
                    [self refreshContactsList];

                });
            }
            
        } onError:^(CometChatException * _Nullable _error) {
            
            NSLog(@"%@",[_error errorDescription]);
            [self refreshContactsList];

        }];
        
    }else{
        
        [_activeMemberRequest fetchNextOnSuccess:^(NSArray<GroupMember *> * _Nonnull members) {
            
            [_members addObjectsFromArray:members];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_listTableView reloadData];
                [self refreshContactsList];

            });
        } onError:^(CometChatException * _Nullable error) {
            
            NSLog(@"Error %@",[error errorDescription]);
            [self refreshContactsList];

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
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
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
@end
