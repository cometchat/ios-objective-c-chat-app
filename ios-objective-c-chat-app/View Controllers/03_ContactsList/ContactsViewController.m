//
//  ContactsViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "ContactsViewController.h"


@interface ContactsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate ,ResultViewDelegate ,UserEventDelegate>
@property (nonatomic, strong) ResultsTableController *resultTableViewController;
@property (nonatomic) BOOL moreLoading;
@property (nonatomic ,strong) UIView *loadingMoreView;
@property (nonatomic ,strong) ActivityIndicatorView *footerLoader;
@property (nonatomic ,strong) ActivityIndicatorView *backgroundLoader;
@end

@implementation ContactsViewController
{
    User *LOGGED_IN_USER;
    HexToRGBConvertor *hexToRGB;
}
@synthesize contactListArray,userRequest;
- (void)viewDidLoad {
    [super viewDidLoad];
 
    _resultTableViewController = [ResultsTableController new];
    hexToRGB = [HexToRGBConvertor new];
    [self.view setBackgroundColor:[hexToRGB colorWithHexString:@"#2636BE"]];
    [self.navigationController.navigationBar setBarTintColor:[hexToRGB colorWithHexString:@"#2636BE"]];
    
    [_resultTableViewController setDelegate:self];
    
    [self setUpActivityIndicatorView];
    [self configureTable:UITableViewStylePlain];
    [self configureFooterView];
    LOGGED_IN_USER = [CometChat getLoggedInUser];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //    [self initializeSearchController];
    [self viewWillSetupNavigationBar];
    [self delegate].usereventdelegate = self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSInteger limit = 30 ;
    userRequest = [[[[UsersRequestBuilder alloc]initWithLimit:limit] hideBlockedUsers:YES]build];
    self.contactListArray = [NSMutableArray new];
    [self fetchNext];
    
}
- (AppDelegate *)delegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
-(void)configureTable:(UITableViewStyle)style{
    
    // the tableview
    [__tableView setDelegate:self];
    [__tableView setDataSource:self];
    [__tableView setEstimatedRowHeight:60.0f];
    [__tableView setRowHeight:UITableViewAutomaticDimension];
    [__tableView setSectionFooterHeight:0.0f];
    [__tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [__tableView setBackgroundView:[self backgroundLoader]];
    [__tableView.layer setCornerRadius:10.0f];
    [__tableView registerClass:[EntityListTableViewCell class] forCellReuseIdentifier:[EntityListTableViewCell reuseIdentifier]];
    [[self backgroundLoader] startAnimating];
    
}
//- (void)initializeSearchController {
//
//
//    self.searchController = [[UISearchController alloc] initWithSearchResultsController:_resultTableViewController];
//    [self.searchController.searchBar setBarStyle:UIBarStyleDefault];
//    self.definesPresentationContext = YES;
//
//    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
//
//        self.searchController.searchBar.tintColor = [UIColor whiteColor];
//    self.searchController.obscuresBackgroundDuringPresentation = YES;
//
//    self.searchController.searchResultsUpdater = self;
//
//
//    self.searchController.searchBar.delegate = self;
//
//    if (@available(iOS 11.0, *)) {
//        self.navigationItem.searchController = self.searchController;
//    } else {
//        self._tableView.tableHeaderView = self.searchController.searchBar;
//    }
//}
-(void)configureFooterView
{
    CGRect frame = CGRectMake(0.0f, __tableView.contentSize.height, __tableView.bounds.size.width, __tableView.estimatedRowHeight);
    _loadingMoreView = [[UIView alloc]initWithFrame:frame];
    [_loadingMoreView addSubview:_footerLoader];
    _footerLoader.center = CGPointMake(_loadingMoreView.bounds.size.width/2, _loadingMoreView.bounds.size.height/2);
    
    _loadingMoreView.hidden = true;
    [__tableView addSubview:_loadingMoreView];
    
    UIEdgeInsets insets = __tableView.contentInset;
    insets.bottom += ActivityIndicatorView.defaultHeight;
    __tableView.contentInset = insets;
}
-(void)setUpActivityIndicatorView
{
    _footerLoader = [[ActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    _backgroundLoader = [[ActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
}
-(void)fetchNext
{
    [[NSOperationQueue new] addOperationWithBlock:^{
        [self fetchUsers];
    }];
}
-(void)fetchUsers
{
    
    _moreLoading = YES ;
    
    [userRequest fetchNextOnSuccess:^(NSArray<User *> * contacts) {
        
        if ([contacts count] != 0) {
            [self.contactListArray addObjectsFromArray:contacts];
            [self refreshContactsList];
        }else{
            [self refreshContactsList];
        }
        
    } onError:^(CometChatException * error) {
        
        [self refreshContactsList];
        [Alert showAlertForError:error in:self];
        
    }];
}
-(void)refreshContactsList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self._tableView reloadData];
        self.moreLoading = NO;
        [self.footerLoader stopAnimating];
        [self.backgroundLoader stopAnimating];
        [self.loadingMoreView setHidden:YES];
    });
}
-(void)viewWillSetupNavigationBar{
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    }
    self.navigationItem.title = NSLocalizedString(@"Contacts", @"");
    
    UIBarButtonItem *user_details = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"outline_more_vert_black_24pt"] style:UIBarButtonItemStylePlain target:self action:@selector(showUserDetails)];
    [user_details setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItems:@[user_details]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:YES];
    
}
-(void)showUserDetails
{
    
    __weak typeof(self) weakSelf = self;
    MoreViewController *morePage = [self.storyboard instantiateViewControllerWithIdentifier:@"MoreViewController"];
    morePage.hidesBottomBarWhenPushed = YES;
    [weakSelf.navigationController pushViewController:morePage animated:YES];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return contactListArray.count;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EntityListTableViewCell *cell = (EntityListTableViewCell *) [tableView dequeueReusableCellWithIdentifier:[EntityListTableViewCell reuseIdentifier]];
    
    if (!cell) {
        cell = [[EntityListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EntityListTableViewCell reuseIdentifier]];
    }
    [cell bind:[contactListArray objectAtIndex:[indexPath row]] withIndexPath:indexPath];
    return cell;
}
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction * blockUser = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"Block" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self blockUser:(User*)[self->contactListArray objectAtIndex:[indexPath row]]];
    }];
    
    return @[blockUser];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self PushToNext:[contactListArray objectAtIndex:[indexPath row]]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0f;
}
-(void)PushToNext:(AppEntity *)user{
    
    ChatViewController *chatviewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
    chatviewcontroller.hidesBottomBarWhenPushed = YES;
    [chatviewcontroller setAppEntity:user];
    __weak typeof(self) weakSelf = self;
    [weakSelf.navigationController pushViewController:chatviewcontroller animated:YES];
    
}
#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *searchText = searchController.searchBar.text;
    if (![searchText isEqualToString:@""]) {
        
        _filteredUsers = [contactListArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(User *user, NSDictionary *bindings){
            
            NSString *name = [user name];
            
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
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSLog(@"searching %@",searchText);
}
- (void)RowAtIndexPath:(nonnull AppEntity *)appEntity {
    
    [self PushToNext:appEntity];
}


/**
 
 Update User Online Offline Status

 @param user for which status to be update
 */
-(void)applicationDidReceiveUserEvent:(User *)user{
    
    for (User *object in contactListArray) {
        
        if ([[user uid]isEqualToString:[object uid]]) {
            
            [__tableView beginUpdates];
            [contactListArray replaceObjectAtIndex:[contactListArray indexOfObject:object] withObject:user];
            NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:[contactListArray indexOfObject:user] inSection:0];
            NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
            [__tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
            [__tableView endUpdates];
            break;
        }
    }
}
-(void)blockUser:(User *)user
{
    
    [CometChatProRequests block:user in:self onSuccess:^(bool isBlocked) {
        
        if (isBlocked) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [__tableView beginUpdates];
                NSIndexPath* rowToDelete = [NSIndexPath indexPathForRow:[self->contactListArray indexOfObject:user] inSection:0];
                NSArray* rowsToReload = [NSArray arrayWithObjects:rowToDelete, nil];
                [self->__tableView deleteRowsAtIndexPaths:rowsToReload withRowAnimation:(UITableViewRowAnimationFade)];
                [self->contactListArray removeObject:user];
                [self->__tableView endUpdates];
                
            });
        }
        
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(!_moreLoading){
        
        int scrollViewContentHeight = __tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - __tableView.bounds.size.height;
        
        if(scrollView.contentOffset.y > scrollOffsetThreshold && __tableView.isDragging) {
            
            _moreLoading = YES;
            CGRect frame = CGRectMake(0.0f, __tableView.contentSize.height, __tableView.bounds.size.width, __tableView.estimatedRowHeight);
            _loadingMoreView.frame = frame;
            [_footerLoader startAnimating];
            [_loadingMoreView setHidden:NO];
            [self fetchNext];
        }
    }
}

@end
