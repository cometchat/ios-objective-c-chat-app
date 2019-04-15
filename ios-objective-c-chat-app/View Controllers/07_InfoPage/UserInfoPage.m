//
//  UserInfoPage.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 27/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "UserInfoPage.h"

@interface UserInfoPage ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *_tableView;
@end

@implementation UserInfoPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self._tableView];
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
            
            entityCell.titleLbl.text = _user.name;
            entityCell.statusLbl.text = [NSString stringWithFormat:@"last active at: %@",[[NSString stringWithFormat:@"%ld",(long)_user.lastActiveAt]sentAtToTime]];
            
            NSString *firstLettr = [entityCell.titleLbl.text substringToIndex:1];
            Avatar *avatar = [[Avatar alloc]initWithRect:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f) fullName:firstLettr];
            [avatar setBackgroundColor:[UIColor grayColor]];
            entityCell.icon.image = [avatar imageRepresentation];
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^(void) {
                
                [DownloadManager link:[self->_user avatar] completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    
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
                if (_user.email) {
                    cell.textLabel.text = _user.email;
                } else {
                    cell.textLabel.text = [NSString stringWithFormat:@"--"];
                }
                return cell;
            
        }
            break;
        case 2:
        {
                if (_user.statusMessage) {
                    cell.textLabel.text = _user.statusMessage;
                } else {
                    cell.textLabel.text = [NSString stringWithFormat:@"--"];
                }
                return cell;
        }
            break;
        case 3:
        {
                if (_user.role) {
                    cell.textLabel.text = _user.role;
                } else {
                    cell.textLabel.text = [NSString stringWithFormat:@"--"];
                }
                return cell;
        }
            break;
        case 4:
        {
                if (_user.link) {
                    cell.textLabel.text = _user.link;
                } else {
                    cell.textLabel.text = [NSString stringWithFormat:@"--"];
                }
                return cell;
        }
            break;
        case 5:
        {
                if (_user.email) {
                    cell.textLabel.text = _user.email;
                } else {
                    cell.textLabel.text = [NSString stringWithFormat:@"--"];
                }
                return cell;
        }
            break;
        case 6:
        {
                if (_user.credits) {
                    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)_user.credits];
                } else {
                    cell.textLabel.text = [NSString stringWithFormat:@"--"];
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
    
    return 8;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch ([indexPath section]) {
        case 0:
            return self.view.frame.size.height * 30/100;
            break;
        default:
            return 44.0f;
            break;
    }
    return 0.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 44.0)];
    [view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0, view.frame.size.height - 30.0, 250.0, 25.0)];
    [label setFont:[UIFont systemFontOfSize:14.0f]];
    [label setTextColor:[UIColor grayColor]];
    [view addSubview:label];
    
    switch (section) {
        case 0: { label.text = [NSString stringWithFormat:@"details:"]; }       break;
        case 1: { label.text = [NSString stringWithFormat:@"email-id:"]; }      break;
        case 2: { label.text = [NSString stringWithFormat:@"status:"];}         break;
        case 3: { label.text = [NSString stringWithFormat:@"role:"]; }          break;
        case 4: { label.text = [NSString stringWithFormat:@"link:"]; }          break;
        case 5: { label.text = [NSString stringWithFormat:@"metadata:"]; }      break;
        case 6: { label.text = [NSString stringWithFormat:@"credits:"]; }       break;
        default:
            break;
    }
    return view;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch ([indexPath section]) {
        case 1:
            switch ([indexPath row]) {
                case 0:
                    break;
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
}

@end
