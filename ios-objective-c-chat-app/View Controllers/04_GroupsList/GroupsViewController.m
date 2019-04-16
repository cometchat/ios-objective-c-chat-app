//
//  GroupsViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "GroupsViewController.h"

@interface GroupsViewController ()<UITableViewDataSource,UITableViewDelegate,ResultViewDelegate,UISearchResultsUpdating,UISearchBarDelegate>
@property (nonatomic, strong) ResultsTableController *resultTableViewController;
@property (nonatomic) NSInteger selectedScope;
@property (nonatomic) BOOL isMoreDataLoading;
@property (nonatomic ,strong) UIView *loadingMoreView;
@property (nonatomic ,strong) ActivityIndicatorView *footerActivityIndicatorView;
@property (nonatomic ,strong) ActivityIndicatorView *backGroundActivityIndicatorView;
@end

@implementation GroupsViewController

@synthesize groupRequest;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger limit = 30 ;
    _selectedScope = 0 ;
    groupRequest = [[[GroupsRequestBuilder alloc]initWithLimit:limit] build];
    _resultTableViewController = [ResultsTableController new];
    [_resultTableViewController setDelegate:self];
    
    self.joinedgroupListArray = [NSMutableArray new];
    self.unjoinedgroupListArray = [NSMutableArray new];
   
    [self setUpActivityIndicatorView];
    [self configureTable:UITableViewStylePlain];
    [self viewWillSetNavigationBar];
    [self initializeSearchController];
    [self configureFooterView];
    [self fetchNext];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)configureTable:(UITableViewStyle)style{
    
    // the tableview
    __tableView.delegate = self;
    __tableView.dataSource = self;
    __tableView.estimatedRowHeight = 60;
    __tableView.rowHeight = UITableViewAutomaticDimension;
    __tableView.estimatedSectionFooterHeight = 0.0f;
    __tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    __tableView.backgroundView = _backGroundActivityIndicatorView;
    [_backGroundActivityIndicatorView startAnimating];
}
- (void)initializeSearchController {
    
    //instantiate a search results controller for presenting the search/filter results (will be presented on top of the parent table view)
    
    //instantiate a UISearchController - passing in the search results controller table
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:_resultTableViewController];
    [self.searchController.searchBar setBarStyle:UIBarStyleDefault];
    //this view controller can be covered by theUISearchController's view (i.e. search/filter table)
    self.definesPresentationContext = YES;
    [self.searchController.searchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"Active",@"Inactive",nil]];

    
    //define the frame for the UISearchController's search bar and tint
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    //    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    self.searchController.obscuresBackgroundDuringPresentation = YES;
    
    //this ViewController will be responsible for implementing UISearchResultsDialog protocol method(s) - so handling what happens when user types into the search bar
    self.searchController.searchResultsUpdater = self;
    
    
    //this ViewController will be responsisble for implementing UISearchBarDelegate protocol methods(s)
    self.searchController.searchBar.delegate = self;
    
    //add the UISearchController's search bar to the header of this table
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchController;
    } else {
        // Fallback on earlier versions
        self._tableView.tableHeaderView = self.searchController.searchBar;
    }
}
-(void)configureFooterView
{
    CGRect frame = CGRectMake(0.0f, __tableView.contentSize.height, __tableView.bounds.size.width, __tableView.estimatedRowHeight);
    _loadingMoreView = [[UIView alloc]initWithFrame:frame];
    [_loadingMoreView addSubview:_footerActivityIndicatorView];
    _footerActivityIndicatorView.center = CGPointMake(_loadingMoreView.bounds.size.width/2, _loadingMoreView.bounds.size.height/2);
    
    _loadingMoreView.hidden = true;
    [__tableView addSubview:_loadingMoreView];
    
    UIEdgeInsets insets = __tableView.contentInset;
    insets.bottom += ActivityIndicatorView.defaultHeight;
    __tableView.contentInset = insets;
}
-(void)setUpActivityIndicatorView
{
    _footerActivityIndicatorView = [[ActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    _backGroundActivityIndicatorView = [[ActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
}
-(void)fetchNext{
    
    [groupRequest fetchNextOnSuccess:^(NSArray<Group *> * groups) {
        
        if (groups) {
            for (Group *object in groups) {
                
                if ([object hasJoined]) {
                    [_joinedgroupListArray addObject:object];
                } else {
                    [_unjoinedgroupListArray addObject:object];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [__tableView reloadData];
                _isMoreDataLoading = NO;
                [_footerActivityIndicatorView stopAnimating];
                [_loadingMoreView setHidden:YES];
                [_backGroundActivityIndicatorView stopAnimating];
            });
        }
        
    } onError:^(CometChatException * error) {
        
        NSLog(@"Error %@",[error errorDescription]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _isMoreDataLoading = NO;
            [_footerActivityIndicatorView stopAnimating];
            [_backGroundActivityIndicatorView stopAnimating];
            [_loadingMoreView setHidden:YES];
        });
    }];
}

-(void)showAlertSheet:(id)sender{
    
    CreateGroupViewController *creategroupviewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateGroupViewController"];
    creategroupviewcontroller.hidesBottomBarWhenPushed = YES;
    [self pushNextTo:creategroupviewcontroller];
}
-(void)viewWillSetNavigationBar{
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
        
    } else {
        // Fallback on earlier versions
    }
    
    self.navigationItem.title = @"Groups";
    UIBarButtonItem *creategroupBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"group_create"] style:UIBarButtonItemStylePlain target:self action:@selector(showAlertSheet:)];
    
    
    [self.navigationItem setRightBarButtonItems:@[creategroupBtn]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setTranslucent:YES];
    
}
-(void)pushNextTo:(UIViewController *)viewcontroller{
    
    [self.navigationController pushViewController:viewcontroller animated:YES];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_unjoinedgroupListArray.count != 0) {
        return 2;
    } else {
        return 1;
    }
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    switch (section) {
        case 0:
            return _joinedgroupListArray.count;
            break;
        case 1:
            return _unjoinedgroupListArray.count;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = (CustomTableViewCell *) [tableView dequeueReusableCellWithIdentifier:[CustomTableViewCell reuseIdentifier]];
    
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CustomTableViewCell reuseIdentifier]];
    }
    
    Group *group;
    
    switch (indexPath.section) {
        case 0:
            group = (Group *)[_joinedgroupListArray objectAtIndex:[indexPath row]];
            break;
        case 1:
            group = (Group *)[_unjoinedgroupListArray objectAtIndex:[indexPath row]];
            break;
        default:
            break;
    }
    [cell bind:group withIndexPath:indexPath];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view;
    
    switch (section) {
        case 0:{
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 44.0)];
            [view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0, view.frame.size.height - 30.0, 250.0, 25.0)];
            label.text = [NSString stringWithFormat:@"Joined"];
            [label setFont:[UIFont systemFontOfSize:14.0f]];
            [label setTextColor:[UIColor grayColor]];
            [view addSubview:label];
            
            break;
        }
        case 1:{
            view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 44.0)];
            [view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0, view.frame.size.height - 30.0, 250.0, 25.0)];
            label.text = [NSString stringWithFormat:@"Other"];
            [label setFont:[UIFont systemFontOfSize:14.0f]];
            [label setTextColor:[UIColor grayColor]];
            [view addSubview:label];
            break;
        }
        default:
            break;
    }
    
    
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            [self showNextWithGroup:(Group*)[_joinedgroupListArray objectAtIndex:[indexPath row]]];
            break;
        case 1:
            [self showAlertForToJoinGroupForIndexPath:indexPath];
            break;
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            
            if (_joinedgroupListArray.count != 0) {
                return 44.0f;
            }
            
            break;
        case 1:
            if (_unjoinedgroupListArray.count != 0) {
                return 44.0f;
            }
            break;
        default:
            break;
    }
    return 0.0f;
}
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *join_group = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"JOIN" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self showAlertForToJoinGroupForIndexPath:indexPath];
        
    }];
    [join_group setBackgroundColor:[UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f]];
    
    UITableViewRowAction *leave_group = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"LEAVE" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self showAlertForToLeaveGroupAtIndexPath:indexPath];
        
    }];
    
    switch ([indexPath section]) {
        case 0:
            return @[leave_group];
            break;
            case 1:
            return @[join_group];
            break;
        default:
            break;
    }
    return @[[UITableViewRowAction new]];
}


-(void)showNextWithGroup:(Group*)group{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        ChatViewController *chatviewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
        chatviewcontroller.hidesBottomBarWhenPushed = YES;
        [chatviewcontroller setAppEntity:group];
        [self pushNextTo:chatviewcontroller];
        
    });
}
-(void)showAlertForToJoinGroupForIndexPath:(NSIndexPath *)indexPath{
    
    Group *group = (Group *)[_unjoinedgroupListArray objectAtIndex:[indexPath row]];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[group name] message:[group name] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *join = [UIAlertAction actionWithTitle:@"Join" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
        [self checkGroupAvailablity:group];
        
    }];
    
    [alert addAction:join];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)showAlertForToLeaveGroupAtIndexPath:(NSIndexPath *)indexPath
{
    
    Group *group = (Group*)[_joinedgroupListArray objectAtIndex:[indexPath row]];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[group name] message:[group name] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleCancel) handler:nil];
    
    UIAlertAction *join = [UIAlertAction actionWithTitle:@"Leave" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
        [self leaveGroup:(Group *)[self.joinedgroupListArray objectAtIndex:[indexPath row]]];
        
    }];
    
    [alert addAction:join];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)reloadTableData{
    
    GroupsRequest *groupRequest = [[[GroupsRequestBuilder alloc]initWithLimit:30] build];
    
    [groupRequest fetchNextOnSuccess:^(NSArray<Group *> * groups) {
        
        if (groups) {
            for (Group *object in groups) {
                
                if ([object hasJoined]) {
                    [_joinedgroupListArray addObject:object];
                } else {
                    [_unjoinedgroupListArray addObject:object];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [__tableView reloadData];
            });
        }
        
    } onError:^(CometChatException * error) {
        NSLog(@"Error %@",[error errorDescription]);
    }];
}


-(void)checkGroupAvailablity:(Group *)group{
    
    NSLog(@"GROUP %@",[group stringValue]);
    
    __block NSString *Password = nil;
    
    switch (group.groupType) {
            
        case groupTypePublic:
            
            [self joinGroup:group WithPassword:Password];
            
            break;
        case groupTypePrivate:
            
            [self joinGroup:group WithPassword:Password];
            
            break;
        case groupTypePassword:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter Password" message:@"Please Enter Password To Join This Group" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
                textField.placeholder = @"Password";
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                textField.borderStyle = UITextBorderStyleNone;
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleCancel) handler:nil];
            UIAlertAction *join = [UIAlertAction actionWithTitle:@"Join" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
                NSArray *textField = alert.textFields;
                Password = [NSString stringWithFormat:@"%@",[[textField objectAtIndex:0] text]];
                [self joinGroup:group WithPassword:Password];
                
            }];
            
            [alert addAction:join];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
            break;
    }
}

#pragma Group Actions

-(void)joinGroup:(Group *)group WithPassword:(NSString*)password{
    
    [CometChat joinGroupWithGUID:[group guid] groupType:[group groupType] password:password onSuccess:^(Group * groupJoined) {
        
        [self showNextWithGroup:group];
        
    } onError:^(CometChatException * error) {
        
        NSLog(@"Error %@",[error errorDescription]);
        
    }];
    
    
}
-(void)leaveGroup:(Group *)group {
    
    [CometChat leaveGroupWithGUID:[group guid] onSuccess:^(NSString * isSuccess) {
        
        NSLog(@"LEFT");
        [self reloadTableData];
        
    } onError:^(CometChatException * error) {
        
        NSLog(@"Error %@",[error errorDescription]);
        
    }];
    
}
#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    [self filterUSingScope:_selectedScope ForSearchController:searchController];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSLog(@"searching %@",searchText);
}
- (void)RowAtIndexPath:(nonnull AppEntity *)appEntity {
    
    NSLog(@"Tapped");
}
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    
    NSLog(@"selectedScope %ld",(long)selectedScope);
    _selectedScope = selectedScope;
}
-(void)filterUSingScope:(NSInteger)selectedScope ForSearchController:(UISearchController *)searchController{
    
    
    switch (selectedScope) {
        case 0:
        {
            NSString *searchText = searchController.searchBar.text;
            if (![searchText isEqualToString:@""]) {
                
                _filteredUsers = [_joinedgroupListArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Group *group, NSDictionary *bindings){
                    
                    NSString *name = [group name];
                    
                    if([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound){
                        return  YES;
                    }
                    return NO;
                }]];
            }
            if (_filteredUsers) {
                
                _resultTableViewController.SectionOneListItems  = _filteredUsers;
                [_resultTableViewController.tableView reloadData];
            }
        }
            break;
        case 1:
        {
            NSString *searchText = searchController.searchBar.text;
            if (![searchText isEqualToString:@""]) {
                
                _filteredUsers = [_unjoinedgroupListArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Group *group, NSDictionary *bindings){
                    
                    NSString *name = [group name];
                    
                    if([name rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound){
                        return  YES;
                    }
                    return NO;
                }]];
            }
            if (_filteredUsers) {
                
                _resultTableViewController.SectionOneListItems  = _filteredUsers;
                [_resultTableViewController.tableView reloadData];
            }
        }
            break;
        default:
            break;
    }
    
}
//FIXME: - fix scroll to bottom fetch next
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(!_isMoreDataLoading){
        
        int scrollViewContentHeight = __tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - __tableView.bounds.size.height;
        
        if(scrollView.contentOffset.y > scrollOffsetThreshold && __tableView.isDragging) {
            
            _isMoreDataLoading = YES;
            
            CGRect frame = CGRectMake(0.0f, __tableView.contentSize.height, __tableView.bounds.size.width, __tableView.estimatedRowHeight);
            _loadingMoreView.frame = frame;
            [_footerActivityIndicatorView startAnimating];
            [_loadingMoreView setHidden:NO];
            [self fetchNext];
        }
    }
}

@end



