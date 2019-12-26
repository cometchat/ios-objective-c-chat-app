//
//  ResultsTableController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 28/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "ResultsTableController.h"

@interface ResultsTableController ()

@end

@implementation ResultsTableController

- (void)viewDidLoad {
    [super viewDidLoad];

    _SectionOneListItems = [NSMutableArray new];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 0.0f;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(RowAtIndexPath:)]) {
        
        [_delegate RowAtIndexPath:[_SectionOneListItems objectAtIndex:[indexPath row]]];
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    
    return 0.0f;
}
@end
