//
//  StartUpViewController.m
//  ios-objective-c-chat-app
//
//  Created by Nishant on 05/12/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "StartUpViewController.h"

@interface StartUpViewController ()

@end

@implementation StartUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
