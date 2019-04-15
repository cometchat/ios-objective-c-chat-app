//
//  PopOverView.m
//  SparkChat
//
//  Created by Ins on 12/06/18.
//  Copyright © 2018 inscripts. All rights reserved.
//

#import "DemoUsersViewController.h"

@interface DemoUsersViewController ()
@property (strong, nonatomic) UISearchController *searchController;
@property(strong,nonatomic) NSMutableArray<DemoUser *> *displayedItems;
@property(strong,nonatomic) NSArray<DemoUser *> *allItems;
@property(strong,nonatomic) UITableView * tableView;

@end

@implementation DemoUsersViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    [self.searchController.searchBar setSearchBarStyle:(UISearchBarStyleMinimal)];
    [self.searchController setHidesNavigationBarDuringPresentation:NO];
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedSectionFooterHeight = 0.0f;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    self.searchController.active = YES;
    _tableView.tableHeaderView = self.searchController.searchBar;
    [_tableView setContentOffset:CGPointMake(0.0f, self.searchController.searchBar.frame.size.height)];
    [self.view insertSubview:_tableView atIndex:1];
    
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    /*get plist data*/
    
    DemoUser *SUPERHERO1 = [[DemoUser alloc]initDemoUserWithUserName:@"SUPERHERO1" userUID:@"SUPERHERO1" andImage:[UIImage imageNamed:@"captainamerica"]];
    DemoUser *SUPERHERO2 = [[DemoUser alloc]initDemoUserWithUserName:@"SUPERHERO2" userUID:@"SUPERHERO2" andImage:[UIImage imageNamed:@"cyclops"]];
    DemoUser *SUPERHERO3 = [[DemoUser alloc]initDemoUserWithUserName:@"SUPERHERO3" userUID:@"SUPERHERO3" andImage:[UIImage imageNamed:@"ironman"]];
    DemoUser *SUPERHERO4 = [[DemoUser alloc]initDemoUserWithUserName:@"SUPERHERO4" userUID:@"SUPERHERO4" andImage:[UIImage imageNamed:@"spiderman"]];
    DemoUser *SUPERHERO5 = [[DemoUser alloc]initDemoUserWithUserName:@"SUPERHERO5" userUID:@"SUPERHERO5" andImage:[UIImage imageNamed:@"wolverine"]];
    
    NSArray *demoUsersArray = [NSArray arrayWithObjects:SUPERHERO1,SUPERHERO2,SUPERHERO3,SUPERHERO4,SUPERHERO5,nil];
    _displayedItems = [NSMutableArray arrayWithArray:demoUsersArray];
    self.allItems = [_displayedItems mutableCopy];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    _displayedItems = [self.allItems mutableCopy];
    [_tableView reloadData];
}

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"SELECT DEMO USER TO LOGIN";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 65.0f;
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _displayedItems.count;
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [[_displayedItems objectAtIndex:indexPath.row] userName];
    
    [cell.imageView setImage:[[_displayedItems objectAtIndex:indexPath.row] profileImage]];
    
    [cell.imageView setClipsToBounds:YES];
    [cell.imageView.layer setCornerRadius:cell.imageView.frame.size.height/2];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)updateSearchResultsForSearchController:(UISearchController *)aSearchController {
    
    NSString *searchText = aSearchController.searchBar.text;
    NSArray *demoUsersArray;
    if (![searchText isEqualToString:@""]) {
        demoUsersArray = [_allItems filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DemoUser *user, NSDictionary *bindings){
            
            if([[user userName] rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound){
                return  YES;
            }
            return NO;
        }]];
    }
    if (demoUsersArray) {
        _displayedItems = [demoUsersArray mutableCopy];
    }else{
        _displayedItems = [self.allItems mutableCopy];
    }
    [_tableView reloadData];
}
@end
