//
//  ListTableViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "ListTableViewController.h"
#import "EntityListTableViewCell.h"
@interface ListTableViewController ()
@end

@implementation ListTableViewController
@synthesize __tableView;

#pragma mark - Custom init

-(void)configureTable:(UITableViewStyle)style{
    
    // the tableview
    __tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:style];
    __tableView.delegate = self;
    __tableView.dataSource = self;
    __tableView.estimatedRowHeight = 60;
    __tableView.rowHeight = UITableViewAutomaticDimension;
    __tableView.estimatedSectionFooterHeight = 0.0f;
    [self.view addSubview:__tableView];
    
    [__tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *views = NSDictionaryOfVariableBindings(__tableView);
    
    NSArray *horizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[__tableView]|"  options:0 metrics:nil views:views];
    NSArray *verticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[__tableView]|"  options:0 metrics:nil views:views];
    
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTable:UITableViewStylePlain];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_SectionOneListItems count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EntityListTableViewCell *cell = (EntityListTableViewCell *) [tableView dequeueReusableCellWithIdentifier:[EntityListTableViewCell reuseIdentifier]];
    
    if (cell == nil) {
        cell = [[EntityListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EntityListTableViewCell reuseIdentifier]];
    }
    
    AppEntity *appEntity = [_SectionOneListItems objectAtIndex:[indexPath row]];
   
    if ([appEntity isKindOfClass:[User class]]) {
        
        [cell bind:(User *)[_SectionOneListItems objectAtIndex:[indexPath row]] withIndexPath:indexPath];
        
    } else if ([appEntity isKindOfClass:[Group class]]){
        
        [cell bind:((Group *)appEntity) withIndexPath:indexPath];
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(WillDisplayCellforRowAtIndexPath:)]) {
//        [_delegate WillDisplayCellforRowAtIndexPath:indexPath];
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(RowAtIndexPath:)]) {
//        
//        switch (indexPath.section) {
//            case 0:
//                [_delegate RowAtIndexPath:[_SectionOneListItems objectAtIndex:[indexPath row]]];
//                break;
//            case 1:
//                [_delegate RowAtIndexPath:[_SectionTwoListItems objectAtIndex:[indexPath row]]];
//                break;
//        }
//    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

@end
