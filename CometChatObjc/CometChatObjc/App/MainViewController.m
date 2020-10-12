//
//  MainViewController.m
//  CometChatObjc
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "CometChatObjc-Swift.h"

@interface MainViewController ()

@end


@implementation MainViewController

@synthesize mainTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    self.navigationItem.hidesBackButton = YES;
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
}

-(void) setupTableView {
    mainTableView.separatorColor = [UIColor clearColor];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"UnifiedCell" bundle:nil]forCellReuseIdentifier:@"unifiedCell"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ComponentCell" bundle:nil]forCellReuseIdentifier:@"componentCell"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"UIScreensCell" bundle:nil]forCellReuseIdentifier:@"screensCell"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"UICallingCell" bundle:nil]forCellReuseIdentifier:@"callingCell"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"LogoutCell" bundle:nil]forCellReuseIdentifier:@"logoutCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( indexPath.row == 0) {
        return 330;
    }else if ( indexPath.row == 1){
        return 370;
    }else if ( indexPath.row == 2){
        return 290;
    }else if ( indexPath.row == 3){
        return 430;
    } else{
        return 80;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if (indexPath.row == 0) {
        UnifiedCell *unifiedCell = [mainTableView dequeueReusableCellWithIdentifier:@"unifiedCell"];
        unifiedCell.delegate = self;
        return unifiedCell;
    }else if (indexPath.row == 1){
        UIScreensCell *screenCell = [mainTableView dequeueReusableCellWithIdentifier:@"screensCell"];
        screenCell.delegate = self;
        return screenCell;
    }else if (indexPath.row == 2) {
        ComponentCell *componentCell = [mainTableView dequeueReusableCellWithIdentifier:@"componentCell"];
        componentCell.delegate = self;
        return componentCell;
    }else if (indexPath.row == 3) {
        UICallingCell *callingCell = [mainTableView dequeueReusableCellWithIdentifier:@"callingCell"];
        callingCell.delegate = self;
        return callingCell;
    }else if (indexPath.row == 4) {
        LogoutCell *logoutCell = [mainTableView dequeueReusableCellWithIdentifier:@"logoutCell"];
        logoutCell.delegate = self;
        return logoutCell;
    }
    return  cell;
}

-(void)makeCallTo {
    
}

-(void)makeCallToEntity:(NSString *)user withType:(CallType *)type withEntityType:(ReceiverType *)receiverType{
    
    CometChatCallManager *callManager = [[CometChatCallManager alloc] init];
    if (receiverType == ReceiverTypeUser) {
        [CometChat getUserWithUID:user onSuccess:^(User * user) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (type == CallTypeAudio){
                    [callManager makeCallWithCall:CallTypeAudio to:user];
                }else{
                    [callManager makeCallWithCall:CallTypeVideo to:user];
                }
            });
        } onError:^(CometChatException * error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CometChatSnackbar *snackBar = [[CometChatSnackbar alloc]initWithMessage:error.errorDescription duration:( CometChatSnackbarDurationLong)];
                [snackBar show];
            });
        }];
    }else{
        [CometChat getGroupWithGUID:user onSuccess:^(Group * group) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (type == CallTypeAudio){
                    [callManager makeCallWithCall:CallTypeAudio to:group];
                }else{
                    [callManager makeCallWithCall:CallTypeVideo to:group];
                }
            });
        } onError:^(CometChatException * error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CometChatSnackbar *snackBar = [[CometChatSnackbar alloc]initWithMessage:error.errorDescription duration:( CometChatSnackbarDurationLong)];
                [snackBar show];
            });
        }];
    }
}


- (void)didLaunchButtonPressed:(UISegmentedControl *)typeSegment{
    NSInteger selectedScreen = typeSegment.selectedSegmentIndex;
    if (selectedScreen == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CometChatUnified *unifiedUI = [[CometChatUnified alloc]init];
            [unifiedUI setupWithStyle: UIModalPresentationFullScreen];
            [self presentViewController:unifiedUI animated:true completion:nil];
        });
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            CometChatUnified *unifiedUI = [[CometChatUnified alloc]init];
            [unifiedUI setupWithStyle: UIModalPresentationPopover];
            [self presentViewController:unifiedUI animated:true completion:nil];
            
        });
    }
}


- (void)didLaunchPressed:(UISegmentedControl *)typeSegment screens:(UISegmentedControl *)screensSegment{
    
    NSInteger selectedStyle = typeSegment.selectedSegmentIndex;
    NSInteger selectedScreen = screensSegment.selectedSegmentIndex;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CometChatConversationList *conversationList = [[CometChatConversationList alloc] init];
        CometChatCallsList *callsList = [[CometChatCallsList alloc] init];
        CometChatUserList *userList = [[CometChatUserList alloc] init];
        CometChatGroupList *groupList = [[CometChatGroupList alloc] init];
        CometChatMessageList *messageList = [[CometChatMessageList alloc] init];
        CometChatUserInfo *userInfo = [[CometChatUserInfo alloc] init];
        
        
        if (selectedStyle == 0){
            if (selectedScreen == 0){
                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:conversationList];
                navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
                [conversationList setWithTitle:@"Chats" mode:UINavigationItemLargeTitleDisplayModeAutomatic];
                [self presentViewController:navigationController animated:true completion:nil];
            }else if (selectedScreen == 1){
                
                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:callsList];
                navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
                [callsList setWithTitle:@"Calls" mode:UINavigationItemLargeTitleDisplayModeAutomatic];
                [self presentViewController:navigationController animated:true completion:nil];
                
            }else if (selectedScreen == 2){
                
                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:userList];
                navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
                [userList setWithTitle:@"Contacts" mode:UINavigationItemLargeTitleDisplayModeAutomatic];
                [self presentViewController:navigationController animated:true completion:nil];
                
            }else if (selectedScreen == 3){
                
                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:groupList];
                navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
                [groupList setWithTitle:@"Groups" mode:UINavigationItemLargeTitleDisplayModeAutomatic];
                [self presentViewController:navigationController animated:true completion:nil];
                
            }else if (selectedScreen == 4){
                
                [CometChat joinGroupWithGUID:@"supergroup" groupType:groupTypePublic password:nil onSuccess:^(Group * group) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:messageList];
                        navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
                        [messageList setWithConversationWith:group type:ReceiverTypeGroup];
                        [self presentViewController:navigationController animated:true completion:nil];
                        
                    });
                    
                } onError:^(CometChatException * error) {
                    
                    if([error.errorCode isEqualToString:@"ERR_ALREADY_JOINED"]){
                        
                        [CometChat getGroupWithGUID:@"supergroup" onSuccess:^(Group * group) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:messageList];
                                navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
                                [messageList setWithConversationWith:group type:ReceiverTypeGroup];
                                [self presentViewController:navigationController animated:true completion:nil];
                            });
                        } onError:^(CometChatException * error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                CometChatSnackbar *snackBar = [[CometChatSnackbar alloc]initWithMessage:error.errorDescription duration:( CometChatSnackbarDurationShort)];
                                [snackBar show];
                            });
                        }];
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            CometChatSnackbar *snackBar = [[CometChatSnackbar alloc]initWithMessage:error.errorDescription duration:( CometChatSnackbarDurationShort)];
                            [snackBar show];
                        });
                    }
                }];
                
            } else if (selectedScreen == 5){
                
                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:userInfo];
                navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
                [userInfo setWithTitle:@"More Info" mode:UINavigationItemLargeTitleDisplayModeAutomatic];
                [self presentViewController:navigationController animated:true completion:nil];
            }
            
        }else{
            
            if (selectedScreen == 0){
                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:conversationList];
                navigationController.modalPresentationStyle = UIModalPresentationPopover;
                [conversationList setWithTitle:@"Chats" mode:UINavigationItemLargeTitleDisplayModeAutomatic];
                [self presentViewController:navigationController animated:true completion:nil];
            }else if (selectedScreen == 1){
                
                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:callsList];
                navigationController.modalPresentationStyle = UIModalPresentationPopover;
                [callsList setWithTitle:@"Calls" mode:UINavigationItemLargeTitleDisplayModeAutomatic];
                [self presentViewController:navigationController animated:true completion:nil];
                
            }else if (selectedScreen == 2){
                
                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:userList];
                navigationController.modalPresentationStyle = UIModalPresentationPopover;
                [userList setWithTitle:@"Contacts" mode:UINavigationItemLargeTitleDisplayModeAutomatic];
                [self presentViewController:navigationController animated:true completion:nil];
                
            }else if (selectedScreen == 3){
                
                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:groupList];
                navigationController.modalPresentationStyle = UIModalPresentationPopover;
                [groupList setWithTitle:@"Groups" mode:UINavigationItemLargeTitleDisplayModeAutomatic];
                [self presentViewController:navigationController animated:true completion:nil];
                
            }else if (selectedScreen == 4){
                
                [CometChat joinGroupWithGUID:@"supergroup" groupType:groupTypePublic password:nil onSuccess:^(Group * group) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:messageList];
                        navigationController.modalPresentationStyle = UIModalPresentationPopover;
                        [messageList setWithConversationWith:group type:ReceiverTypeGroup];
                        [self presentViewController:navigationController animated:true completion:nil];
                        
                    });
                    
                } onError:^(CometChatException * error) {
                    
                    if([error.errorCode isEqualToString:@"ERR_ALREADY_JOINED"]){
                        
                        [CometChat getGroupWithGUID:@"supergroup" onSuccess:^(Group * group) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:messageList];
                                navigationController.modalPresentationStyle = UIModalPresentationPopover;
                                [messageList setWithConversationWith:group type:ReceiverTypeGroup];
                                [self presentViewController:navigationController animated:true completion:nil];
                                
                                
                            });
                        } onError:^(CometChatException * error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                CometChatSnackbar *snackBar = [[CometChatSnackbar alloc]initWithMessage:error.errorDescription duration:( CometChatSnackbarDurationShort)];
                                [snackBar show];
                            });
                        }];
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            CometChatSnackbar *snackBar = [[CometChatSnackbar alloc]initWithMessage:error.errorDescription duration:( CometChatSnackbarDurationShort)];
                            [snackBar show];
                        });
                    }
                }];
                
                
            } else if (selectedScreen == 5){
                
                UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:userInfo];
                navigationController.modalPresentationStyle = UIModalPresentationPopover;
                [userInfo setWithTitle:@"More Info" mode:UINavigationItemLargeTitleDisplayModeAutomatic];
                [self presentViewController:navigationController animated:true completion:nil];
            }
        }
    });
}



- (void)didNavigateButtonPressed {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"LaunchComponentsVC" sender:nil];
    });
}

- (void)didMakeCallButtonPressed:(UISegmentedControl *)usersSegment entity:(UISegmentedControl *)typeSegment callType:(UISegmentedControl *)calltypeSegment {
     NSInteger selectedUser = usersSegment.selectedSegmentIndex;
     NSInteger selectedType = typeSegment.selectedSegmentIndex;
     NSInteger selectedCallType = calltypeSegment.selectedSegmentIndex;
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
        if (selectedType == 0){
            if (selectedCallType == 0){
                if (selectedUser == 0) {
                    [self makeCallToEntity:@"superhero1" withType:CallTypeAudio withEntityType:ReceiverTypeUser];
                }else if (selectedUser == 1) {
                    [self makeCallToEntity:@"superhero2" withType:CallTypeAudio withEntityType:ReceiverTypeUser];
                }else if (selectedUser == 1) {
                    [self makeCallToEntity:@"superhero3" withType:CallTypeAudio withEntityType:ReceiverTypeUser];
                }else if (selectedUser == 1) {
                    [self makeCallToEntity:@"superhero4" withType:CallTypeAudio withEntityType:ReceiverTypeUser];
                }else if (selectedUser == 1) {
                    [self makeCallToEntity:@"superhero5" withType:CallTypeAudio withEntityType:ReceiverTypeUser];
                }
            }else{
                if (selectedUser == 0) {
                    [self makeCallToEntity:@"superhero1" withType:CallTypeVideo withEntityType:ReceiverTypeUser];
                }else if (selectedUser == 1) {
                    [self makeCallToEntity:@"superhero2" withType:CallTypeVideo withEntityType:ReceiverTypeUser];
                }else if (selectedUser == 1) {
                    [self makeCallToEntity:@"superhero3" withType:CallTypeVideo withEntityType:ReceiverTypeUser];
                }else if (selectedUser == 1) {
                    [self makeCallToEntity:@"superhero4" withType:CallTypeVideo withEntityType:ReceiverTypeUser];
                }else if (selectedUser == 1) {
                    [self makeCallToEntity:@"superhero5" withType:CallTypeVideo withEntityType:ReceiverTypeUser];
                }
            }
        }else{
            if (selectedCallType == 0){
                 [self makeCallToEntity:@"supergroup" withType:CallTypeAudio withEntityType:ReceiverTypeGroup];
            }else{
                 [self makeCallToEntity:@"supergroup" withType:CallTypeVideo withEntityType:ReceiverTypeGroup];
            }
        }
        CometChatSnackbar *snackBar = [[CometChatSnackbar alloc]initWithMessage:@"You won't receive any real time events for calls by calling from here because Objective C won't allowing to extend the 'CometChatCallDelegate' protocol in application class. Still, you can check the calling functionality by launching Unified version of UI Kit. Also, to receive real time events for call. Please, check 'CometchatCallManager' class and add 'CometChatCallDelegate' methods in AppDelegate." duration:( CometChatSnackbarDurationLong)];
        [snackBar show];
    });
}



- (void)didLogoutPressed {
    
    [CometChat logoutOnSuccess:^(NSString * success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            LoginWithDemoUsers * viewController = [storyboard instantiateViewControllerWithIdentifier:@"loginWithDemoUsers"];
            [self presentViewController:viewController animated:YES completion:nil];
        });
    } onError:^(CometChatException * error) {
        
        
    }];
}



@end
