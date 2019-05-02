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
@property (nonatomic) BOOL isMoreDataLoading;
@property (nonatomic ,strong) UIView *loadingMoreView;
@property (nonatomic ,strong) ActivityIndicatorView *footerActivityIndicatorView;
@property (nonatomic ,strong) ActivityIndicatorView *backgroundActivityIndicatorView;
@end

@implementation ContactsViewController
{
    User *LOGGED_IN_USER;
    HexToRGBConvertor *hexToRGB;
}
@synthesize contactListArray,userRequest;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger limit = 30 ;
    
    userRequest = [[[UsersRequestBuilder alloc]initWithLimit:limit] build];
    _resultTableViewController = [ResultsTableController new];
    hexToRGB = [HexToRGBConvertor new];
    [self.view setBackgroundColor:[hexToRGB colorWithHexString:@"#2636BE"]];
    [self.navigationController.navigationBar setBarTintColor:[hexToRGB colorWithHexString:@"#2636BE"]];
    
    [_resultTableViewController setDelegate:self];
    
    [self setUpActivityIndicatorView];
    [self configureTable:UITableViewStylePlain];
    [self configureFooterView];
    self.contactListArray = [NSMutableArray new];
    [self fetchNext];
    LOGGED_IN_USER = [CometChat getLoggedInUser];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self initializeSearchController];
    [self viewWillSetupNavigationBar];
    [self delegate].usereventdelegate = self;
}
- (AppDelegate *)delegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
-(void)configureTable:(UITableViewStyle)style{
    
    // the tableview
    __tableView.delegate = self;
    __tableView.dataSource = self;
    __tableView.estimatedRowHeight = 60;
    __tableView.rowHeight = UITableViewAutomaticDimension;
    __tableView.estimatedSectionFooterHeight = 0.0f;
    __tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    __tableView.backgroundView = _backgroundActivityIndicatorView;
    [__tableView.layer setCornerRadius:10.0f];
    [__tableView registerClass:[EntityListTableViewCell class] forCellReuseIdentifier:[EntityListTableViewCell reuseIdentifier]];
    [_backgroundActivityIndicatorView startAnimating];

}
- (void)initializeSearchController {
    
    //instantiate a search results controller for presenting the search/filter results (will be presented on top of the parent table view)
    
    //instantiate a UISearchController - passing in the search results controller table
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:_resultTableViewController];
    [self.searchController.searchBar setBarStyle:UIBarStyleDefault];
    //this view controller can be covered by theUISearchController's view (i.e. search/filter table)
    self.definesPresentationContext = YES;
    
    
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
    _backgroundActivityIndicatorView = [[ActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
}
-(void)fetchNext
{
    [[NSOperationQueue new] addOperationWithBlock:^{
        [self fetchUsers];
    }];
}
-(void)fetchUsers
{
    
    [userRequest fetchNextOnSuccess:^(NSArray<User *> * contacts) {
        
        if ([contacts count] != 0) {
            [self.contactListArray addObjectsFromArray:contacts];
            [self refreshContactsList];
        }else{
            [self refreshContactsList];
        }
        
    } onError:^(CometChatException * error) {
        
        [self refreshContactsList];
        NSLog(@"Error %@",[error errorDescription]);
    }];
}
-(void)refreshContactsList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self._tableView reloadData];
        self.isMoreDataLoading = NO;
        [self.footerActivityIndicatorView stopAnimating];
        [self.backgroundActivityIndicatorView stopAnimating];
        [self.loadingMoreView setHidden:YES];
    });
}
-(void)viewWillSetupNavigationBar{
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    }
    self.navigationItem.title = NSLocalizedString(@"Contacts", @"");

    UIBarButtonItem *user_details = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"user_details"] style:UIBarButtonItemStylePlain target:self action:@selector(showUserDetails)];
    [user_details setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItems:@[user_details]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:YES];

}
-(void)showUserDetails
{
    if (LOGGED_IN_USER) {
        
        InfoPageViewController *infoPage = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoPageViewController"];
        infoPage.hidesBottomBarWhenPushed = YES;
        infoPage.appEntity = [[User alloc]initWithUid:[LOGGED_IN_USER uid] name:[LOGGED_IN_USER name]];
        [self.navigationController pushViewController:infoPage animated:YES];
    }
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
    [self.navigationController pushViewController:chatviewcontroller animated:YES];
    
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
-(void)applicationDidReceiveUserEvent:(User *)user{
    
    NSLog(@"USER %@",[user stringValue]);
    
    NSMutableArray *listArray = [NSMutableArray arrayWithArray:contactListArray];
    
    for (User *object in contactListArray) {
        
        if ([[user uid]isEqualToString:[object uid]]) {
            
            NSInteger index = [listArray indexOfObject:object];
            
            [listArray removeObjectAtIndex:index];
            
            [listArray insertObject:user atIndex:index];
            
            NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:[listArray indexOfObject:user] inSection:0];
            
            NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
            
            if (listArray.count > 0) {
                
                [__tableView beginUpdates];
                contactListArray = [NSMutableArray arrayWithArray:listArray];
                [__tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
                [__tableView endUpdates];
            }
        }
    }
}
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
