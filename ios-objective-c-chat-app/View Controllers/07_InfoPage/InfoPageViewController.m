//
//  InfoPageViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 25/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "InfoPageViewController.h"

@interface Entity : NSObject

-(id) initIMessageWithEntity:(AppEntity *)appEntity;
@property (nonatomic) ReceiverType receiverType;
@property (nonatomic ,retain) User *entityUser;
@property (nonatomic ,retain) Group *entityGroup;
@end

@implementation Entity

-(id) initIMessageWithEntity:(AppEntity *)appEntity
{
    self = [super init];
    if(self)
    {
        
        if ([appEntity isKindOfClass:User.class]) {
            
            self.receiverType = ReceiverTypeUser;
            self.entityUser = (User *)appEntity;
            
        } else if ([appEntity isKindOfClass:Group.class]){
            
            self.receiverType = ReceiverTypeGroup;
            self.entityGroup = (Group *)appEntity;
        }
    }
    
    return self;
}

@end

@interface InfoPageViewController ()<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) Entity *_chatEntity;
@property (nonatomic ,retain) UserInfoPage *userinfoPage;
@property (nonatomic ,retain) GroupInfoPage *groupinfoPage;

@end

@implementation InfoPageViewController

- (void)viewDidLoad {
    
    
    __chatEntity = [[Entity alloc]initIMessageWithEntity:_appEntity];
    [self viewWillSetNavigationBar];
    
    if ([__chatEntity receiverType] == ReceiverTypeUser) {
        
        self.userinfoPage = [[UserInfoPage alloc]init];
        [self.userinfoPage setUser:[__chatEntity entityUser]];
        self.userinfoPage.view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addChildViewController:self.userinfoPage];
        
        [self addSubview:self.userinfoPage.view toView:self.view];
        
        [self.userinfoPage didMoveToParentViewController:self];
        
    } else if ([__chatEntity receiverType] == ReceiverTypeGroup){
        
        self.groupinfoPage = [[GroupInfoPage alloc]init];
        [self.groupinfoPage setGroup:[__chatEntity entityGroup]];
        self.groupinfoPage.view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addChildViewController:self.groupinfoPage];
        [self addSubview:self.groupinfoPage.view toView:self.view];
        [self.groupinfoPage didMoveToParentViewController:self];
        
    }
    [super viewDidLoad];
    
}
- (void)addSubview:(UIView *)subView toView:(UIView*)parentView {
    [parentView addSubview:subView];
    
    NSDictionary * views = @{@"subView" : subView,};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|"
                                                                   options:0
                                                                   metrics:0
                                                                     views:views];
    [parentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|"
                                                          options:0
                                                          metrics:0
                                                            views:views];
    [parentView addConstraints:constraints];
}
-(void)viewWillSetNavigationBar{
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        
    } else {
        // Fallback on earlier versions
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
    
}
-(void)sendEmail:(id)sender
{
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        
        if ([__chatEntity receiverType] == ReceiverTypeUser) {
            if ([__chatEntity entityUser].email) {
                [mail setToRecipients:@[[__chatEntity entityUser].email]];
            }
        }
        [self presentViewController:mail animated:YES completion:NULL];
    } else {
        
        [self showAlertForTitle:@"" Message:@"We could not find an Email client on your device" ButtonTitle:@"OK"];
    }
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)showAlertForTitle:(NSString*)title Message:(NSString*)message ButtonTitle:(NSString*)buttontitle
{
    Class alert = NSClassFromString(@"UIAlertController");
    
    if (alert) {
        
        UIAlertController *alertCont = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:buttontitle
                                       style:UIAlertActionStyleCancel
                                       handler:nil];
        
        [alertCont addAction:cancelAction];
        
        [self presentViewController:alertCont animated:YES completion:nil];
        
    }
}
@end
