//
//  InfoPageViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 25/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "InfoPageViewController.h"

@interface InfoPageViewController ()<MFMailComposeViewControllerDelegate>
@property (nonatomic ,retain) InfoPage *userinfoPage;

@end

@implementation InfoPageViewController

- (void)viewDidLoad {
    
    [self viewWillSetNavigationBar];
    
    self.userinfoPage = [[InfoPage alloc]init];
    [self.userinfoPage setEntity:_appEntity];
    self.userinfoPage.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:self.userinfoPage];
    [self addSubview:self.userinfoPage.view toView:self.view];
    
    [self.userinfoPage didMoveToParentViewController:self];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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
//-(void)sendEmail:(id)sender
//{
//    
//    if ([MFMailComposeViewController canSendMail]) {
//        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
//        mail.mailComposeDelegate = self;
//        
//        if ([__chatEntity receiverType] == ReceiverTypeUser) {
//            if ([__chatEntity entityUser].email) {
//                [mail setToRecipients:@[[__chatEntity entityUser].email]];
//            }
//        }
//        [self presentViewController:mail animated:YES completion:NULL];
//    } else {
//        
//        [self showAlertForTitle:@"" Message:@"We could not find an Email client on your device" ButtonTitle:@"OK"];
//    }
//}
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
