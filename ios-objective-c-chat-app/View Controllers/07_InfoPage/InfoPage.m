//
//  UserInfoPage.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 27/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "InfoPage.h"

@interface InfoPage ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *entityProfileDetailstableView;
@property (strong, nonatomic)  UITableView *entityOtherDetailstableView;
@end

@implementation InfoPage
{
    NSMutableArray *dataSource;
}
- (void)viewDidLoad {
    
    [self.view addSubview:self.entityProfileDetailstableView];
    [_entityProfileDetailstableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.entityOtherDetailstableView];
    [_entityOtherDetailstableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraintsforSize:self.view.frame.size];
    
    if ([_entity isKindOfClass:User.class]) {
        
        User *_user = (User *)_entity;
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@LOGGED_IN_USER_ID]  isEqualToString:[_user uid]]) {
            
            
            dataSource = [NSMutableArray arrayWithObjects:@[@"Status Message",@"round_create_black_36pt"],@[@"Set Status",@"round_local_offer_black_36pt"] ,@[@"Log Out",@"outline_power_settings_new_black_36pt"] ,nil];
            
        }else{
            dataSource  = [NSMutableArray arrayWithObjects:@[@"Send Message",@"round_arrow_upward_black_36pt"],@[@"Audio Call",@"profile_callaudio"],@[@"Video Call",@"profile_callvideo"] ,nil];
        }
    } else if ([_entity isKindOfClass:Group.class]){
        
        Group *group = (Group *)_entity;
        
        dataSource = [NSMutableArray arrayWithObjects:@[@"View Members",@"round_people_black_36pt"],@[@"Leave Group",@"round_exit_to_app_black_36pt"] ,nil];
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@LOGGED_IN_USER_ID]  isEqualToString:[group owner]]) {
         
            [dataSource addObject:@[@"View blocked Members",@"outline_block_black_36pt"]];
        }
    }
    
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [[self.entityOtherDetailstableView layer] setCornerRadius:15.0f];
    [self.entityProfileDetailstableView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    [super viewDidLoad];
}

-(UITableView *)entityProfileDetailstableView {
    
    if (!_entityProfileDetailstableView) {
        // the tableview
        _entityProfileDetailstableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _entityProfileDetailstableView.delegate = self;
        _entityProfileDetailstableView.dataSource = self;
        _entityProfileDetailstableView.estimatedSectionFooterHeight = 0.0f;
        _entityProfileDetailstableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _entityProfileDetailstableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_entityProfileDetailstableView registerClass:EntityDetailsTableViewCell.class forCellReuseIdentifier:EntityOtherDetailsTableViewCell.cellIdentifier];
    }
    return _entityProfileDetailstableView;
}
-(UITableView *)entityOtherDetailstableView
{
    
    if (!_entityOtherDetailstableView) {
        // the tableview
        _entityOtherDetailstableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _entityOtherDetailstableView.delegate = self;
        _entityOtherDetailstableView.dataSource = self;
        _entityOtherDetailstableView.estimatedRowHeight = 60;
        _entityOtherDetailstableView.rowHeight = UITableViewAutomaticDimension;
        _entityOtherDetailstableView.estimatedSectionFooterHeight = 0.0f;
        _entityOtherDetailstableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _entityOtherDetailstableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_entityOtherDetailstableView registerClass:EntityOtherDetailsTableViewCell.class forCellReuseIdentifier:EntityOtherDetailsTableViewCell.cellIdentifier];
    }
    return _entityOtherDetailstableView;
}
-(void)addConstraintsforSize:(CGSize)size
{
    NSDictionary * views = @{@"profileDetailsTable" : _entityProfileDetailstableView ,@"othersDetailstable":_entityOtherDetailstableView};
    
    
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",size.height*0.40],@"profileTableHeight",[NSString stringWithFormat:@"%f",size.width*0.50],@"profileTablewidth",[NSString stringWithFormat:@"%f",size.height*0.12],@"othersDetailstableMargin",nil];
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationUnknown)
    {
        
        
        NSArray *constraintsH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[profileDetailsTable]|"
                                                                         options:0
                                                                         metrics:0
                                                                           views:views];
        NSArray *constraintsH2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[othersDetailstable]-(50)-|"
                                                                         options:0
                                                                         metrics:0
                                                                           views:views];
        
        [self.view addConstraints:constraintsH1];
        [self.view addConstraints:constraintsH2];
        
        NSArray *constraintsV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[profileDetailsTable(profileTableHeight)]-(othersDetailstableMargin)-[othersDetailstable]-(othersDetailstableMargin)-|"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:views];
        [self.view addConstraints:constraintsV1];
        
        
    }else
    {
        
        
        NSArray *constraintsH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[profileDetailsTable(profileTablewidth)]-(16)-[othersDetailstable]-(16)-|"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:views];
        [self.view addConstraints:constraintsH1];
        
        NSArray *constraintsV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[profileDetailsTable]|"
                                                                         options:0
                                                                         metrics:0
                                                                           views:views];
        NSArray *constraintsV2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(othersDetailstableMargin)-[othersDetailstable]-(othersDetailstableMargin)-|"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:views];
        
        [self.view addConstraints:constraintsV1];
        [self.view addConstraints:constraintsV2];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    if (tableView == self.entityProfileDetailstableView) {
        
        switch ([indexPath section]) {
            case 0:
            {
                switch ([indexPath row]) {
                    case 0:
                    {
                        
                        NSString *name , *link ;
                        
                        if ([_entity isKindOfClass:User.class]) {
                            
                            User *_user = (User *)_entity;
                            name = [_user name];
                            link = [_user avatar];
                            
                        }else if ([_entity isKindOfClass:Group.class])
                        {
                            Group *group = (Group *)_entity;
                            name = [group name];
                            link = [group icon];
                        }
                        
                        EntityDetailsTableViewCell *entityCell = (EntityDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[EntityDetailsTableViewCell cellIdentifier]];
                        
                        if (!entityCell) {
                            
                            entityCell = [[EntityDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityDetailsTableViewCell cellIdentifier]];
                        }
                        entityCell.tag = indexPath.row;
                        
                        entityCell.titleLbl.text = name;
                        
                        if ([_entity isKindOfClass:User.class]) {
                            
                            User *_user = (User *)_entity;
                            name = [_user name];
                            link = [_user avatar];
                            
                            entityCell.statusLbl.text = [NSString stringWithFormat:@"last active at :%@",[[NSString stringWithFormat:@"%ld",(long)_user.lastActiveAt]sentAtToTime]];
                        }
                        
                        
                        
                        NSString *firstLettr = [entityCell.titleLbl.text substringToIndex:1];
                        Avatar *avatar = [[Avatar alloc]initWithRect:CGRectMake(0.0f, 0.0f, 90, 90.0f) fullName:firstLettr];
                        [avatar setBackgroundColor:[UIColor grayColor]];
                        entityCell.icon.image = [avatar imageRepresentation];
                        
                        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                        dispatch_async(queue, ^(void) {
                            
                            [DownloadManager link:link completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                
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
                        
                    default:
                        break;
                }
            }
                break;
                
            default:
                break;
        }
        
    } else if (tableView == self.entityOtherDetailstableView){
        
        switch ([indexPath section]) {
            case 0:
            {
                switch ([indexPath row]) {
                    case 0:
                    {
                        EntityOtherDetailsTableViewCell *otherCell = [[EntityOtherDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityOtherDetailsTableViewCell cellIdentifier]];
                        
                        otherCell.alabel.text = [dataSource objectAtIndex:indexPath.row][0];
                        otherCell.aImageView.image = [UIImage imageNamed:[dataSource objectAtIndex:indexPath.row][1]];
                        return otherCell;
                    }
                        break;
                    case 1:
                    {
                        EntityOtherDetailsTableViewCell *otherCell = [[EntityOtherDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityOtherDetailsTableViewCell cellIdentifier]];
                        
                        otherCell.alabel.text = [dataSource objectAtIndex:indexPath.row][0];
                        otherCell.aImageView.image = [UIImage imageNamed:[dataSource objectAtIndex:indexPath.row][1]];
                         return otherCell;
                    }
                        break;
                    case 2:
                    {
                        EntityOtherDetailsTableViewCell *otherCell = [[EntityOtherDetailsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[EntityOtherDetailsTableViewCell cellIdentifier]];
                        
                        otherCell.alabel.text = [dataSource objectAtIndex:indexPath.row][0];
                        otherCell.aImageView.image = [UIImage imageNamed:[dataSource objectAtIndex:indexPath.row][1]];
                        return otherCell;
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
                
            default:
                break;
        }
        
    }
    
    return [UITableViewCell new];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (tableView == self.entityProfileDetailstableView) {
        return 1;
    } else if (tableView == self.entityOtherDetailstableView){
        return [dataSource count];
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.entityProfileDetailstableView) {
        switch ([indexPath section]) {
            case 0:
                return self.view.frame.size.height * 40/100;
                break;
            default:
                return 44.0f;
                break;
        }
    } else if (tableView == self.entityOtherDetailstableView){
        switch ([indexPath section]) {
            case 0:
                return 60.0f;
                break;
            default:
                return 44.0f;
                break;
        }
    }
    return 0.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if ([_entity isKindOfClass:User.class]) {
        
        User *_user = (User *)_entity;
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@LOGGED_IN_USER_ID]  isEqualToString:[_user uid]]) {
            
            switch ([indexPath row]) {
                case 0:
                    NSLog(@"view status message");
                    break;
                case 1:
                    NSLog(@"set status");
                    break;
                case 2:
                {
                    [self logOutUser];
                }
                    break;
                default:
                    break;
            }
        }else
        {
            switch ([indexPath row]) {
                case 0:
                {
                    [self sendMessageFor:_user];
                }
                    break;
                case 1:
                {
                    [self startAudioCall:_entity];
                }
                    break;
                case 2:
                {
                    [self startVideoCall:_entity];
                }
                    break;
                default:
                    break;
            }
        }
    }else if ([_entity isKindOfClass:Group.class]){
        
        Group *group = (Group *)_entity;
        
        switch ([indexPath row]) {
            case 0:
            {
                [self viewMembersfor:group];
            }
                break;
            case 1:
            {
                [self leaveGroup:group];
            }
                break;
            case 2:
            {
                [self viewBlockedMembersFor:group];
            }
                break;
            default:
                break;
        }

    }
    
    
}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [[self view] removeConstraints:[[self view] constraints]];
        [self addConstraintsforSize:(CGSize)size];
        
    }];
}


-(void)sendMessageFor:(AppEntity*)entity
{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChatViewController *chatviewcontroller = [sb instantiateViewControllerWithIdentifier:@"ChatViewController"];
    [chatviewcontroller setAppEntity:entity];
    __weak typeof(self) weakSelf = self;
    [weakSelf.navigationController pushViewController:chatviewcontroller animated:YES];
    
}
-(void)startAudioCall:(AppEntity *)entity
{
    CallViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CallViewController"];
    [controller setEntity:entity];
    [controller setCallType:CallTypeAudio];
    [self presentViewController:controller animated:YES completion:nil];
    
}
-(void)startVideoCall:(AppEntity *)entity
{
    
    CallViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CallViewController"];
    [controller setEntity:entity];
    [controller setCallType:CallTypeVideo];
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)viewMembersfor:(Group *)group
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MembersViewController *controller = [sb instantiateViewControllerWithIdentifier:@"MembersViewController"];
    [controller setGroup:group];
    [controller setIsLoadBanned:NO];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)viewBlockedMembersFor:(Group *)group
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MembersViewController *controller = [sb instantiateViewControllerWithIdentifier:@"MembersViewController"];
    [controller setGroup:group];
    [controller setIsLoadBanned:YES];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)leaveGroup:(Group *)group
{
    
    [CometChat leaveGroupWithGUID:[group guid] onSuccess:^(NSString * _Nonnull isSuccess) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
           [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        });
        
    } onError:^(CometChatException * _Nullable error) {
        
        // alert //
    }];
}
-(void)logOutUser
{
    [CometChat logoutOnSuccess:^(NSString * _Nonnull isSuccess) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        LoginViewController *lg = [sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:lg animated:YES completion:^{
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@LOGGED_IN_USER_ID];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@IS_LOGGED_IN];
        }];
        
    } onError:^(CometChatException * _Nonnull error) {
        
        NSLog(@"%@",[error errorDescription]);
        __weak __typeof__(self) weakSelf = self;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"LOGOUT Failed" message:[error errorDescription] preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:nil];
        [alert addAction:ok];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
}
@end
