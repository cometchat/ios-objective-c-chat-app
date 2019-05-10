//
//  PopOverView.m
//  SparkChat
//
//  Created by Ins on 12/06/18.
//  Copyright © 2018 inscripts. All rights reserved.
//

#import "DemoUsersViewController.h"

@interface DemoUsersViewController ()

@property   (strong, nonatomic)    UISearchController          *searchController;
@property   (strong,nonatomic)     NSMutableArray<DemoUser *>  *displayedItems;
@property   (strong,nonatomic)     NSArray<DemoUser *>         *allItems;
@property   (strong,nonatomic)     UITableView                 *listTableView;

@end

@implementation DemoUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view insertSubview:self.listTableView atIndex:1];
    self.definesPresentationContext = YES;
    
    NSDictionary *view = NSDictionaryOfVariableBindings(_listTableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_listTableView]|" options:0 metrics:nil views:view]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_listTableView]|" options:0 metrics:nil views:view]];
    
    DemoUser *SUPERHERO1 = [[DemoUser alloc]initDemoUserWithUserName:@"Iron Man" userUID:@"superhero1" andImage:[UIImage imageNamed:@"ironman"]];
    DemoUser *SUPERHERO2 = [[DemoUser alloc]initDemoUserWithUserName:@"Capitan America" userUID:@"superhero2" andImage:[UIImage imageNamed:@"captainamerica"]];
    DemoUser *SUPERHERO3 = [[DemoUser alloc]initDemoUserWithUserName:@"Spiderman" userUID:@"superhero3" andImage:[UIImage imageNamed:@"spiderman"]];
    DemoUser *SUPERHERO4 = [[DemoUser alloc]initDemoUserWithUserName:@"Wolverine" userUID:@"superhero4" andImage:[UIImage imageNamed:@"wolverine"]];
    DemoUser *SUPERHERO5 = [[DemoUser alloc]initDemoUserWithUserName:@"Cyclops" userUID:@"superhero5" andImage:[UIImage imageNamed:@"cyclops"]];
    
    NSArray *demoUsers = [NSArray arrayWithObjects:SUPERHERO1,SUPERHERO2,SUPERHERO3,SUPERHERO4,SUPERHERO5,nil];
    _displayedItems = [NSMutableArray arrayWithArray:demoUsers];
    self.allItems = [_displayedItems mutableCopy];
    
}

-(UISearchController *)searchController
{
    if (!_searchController) {
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.searchBar.delegate = self;
        [_searchController.searchBar sizeToFit];
        [_searchController.searchBar setSearchBarStyle:(UISearchBarStyleMinimal)];
        [_searchController setHidesNavigationBarDuringPresentation:NO];
        _searchController.active = YES;
    }
    return _searchController;
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
        _listTableView.tableHeaderView = self.searchController.searchBar;
        [_listTableView setContentOffset:CGPointMake(0.0f, self.searchController.searchBar.frame.size.height)];
        [_listTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _listTableView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    _displayedItems = [self.allItems mutableCopy];
}

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Demo Users";
}

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _displayedItems.count;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellReuseIdentifier = @"cellReuseIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [[[_displayedItems objectAtIndex:indexPath.row] userName] uppercaseString];
    
    [cell.imageView setImage:[[_displayedItems objectAtIndex:indexPath.row] profileImage]];
    
    [cell.imageView setClipsToBounds:YES];
    [cell.imageView.layer setCornerRadius:cell.imageView.frame.size.height/2];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedUser:)]) {
        [_delegate selectedUser:[_displayedItems objectAtIndex:indexPath.row]];
        self.searchController.active = NO;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)updateSearchResultsForSearchController:(UISearchController *)aSearchController {
    
    NSString *searchText = aSearchController.searchBar.text;
    NSArray *demoUsers;
    if (![searchText isEqualToString:@""]) {
        demoUsers = [_allItems filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DemoUser *user, NSDictionary *bindings){
            
            if([[user userName] rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound){
                return  YES;
            }
            return NO;
        }]];
    }
    if (demoUsers) {
        _displayedItems = [demoUsers mutableCopy];
    }else{
        _displayedItems = [self.allItems mutableCopy];
    }
    [self.listTableView reloadData];
}
@end
