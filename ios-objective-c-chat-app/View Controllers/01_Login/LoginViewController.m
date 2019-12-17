//
//  LoginViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "LoginViewController.h"
#import "TabBarViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface LoginViewController ()
@property(strong ,nonatomic) UIView             *subViewHolder;
@property(strong ,nonatomic) UIView             *imageHolder;
@property(strong ,nonatomic) UITextField        *userNameField;
@property(strong ,nonatomic) UIButton           *loginButton;
@property(strong ,nonatomic) UIImageView        *logoImage;
@property(nonatomic ,strong) UILabel            *tryADemo;
@property(nonatomic ,strong) ActivityIndicatorView   *activityIndicator;
@end

@implementation LoginViewController
{
    DemoUsersViewController *demoUsers;
    HexToRGBConvertor       *hexToRGB;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    demoUsers = [DemoUsersViewController new];
    hexToRGB = [HexToRGBConvertor new];
    demoUsers.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.contentView addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)name:UIKeyboardWillHideNotification object:nil];
    [self viewWillsetupSubviews];
    
}

#pragma mark  - CometChatPro Login


//SuperHero 1 Button Login
- (IBAction)onClickBtnSuperHero1:(id)sender {
    [self.txtFld_UID setText:@"superhero1"];
}

//SuperHero2 Button Login
- (IBAction)onClickBtnSuperHero2:(id)sender {
    [self.txtFld_UID setText:@"superhero2"];
}

//SuperHero3 Button Login
- (IBAction)onClickBtnSuperHero3:(id)sender {
    [self.txtFld_UID setText:@"superhero3"];
}

//SuperHero4 Button Login
- (IBAction)onClickBtnSuperHero4:(id)sender {
    [self.txtFld_UID setText:@"superhero4"];
}

//Login Button
- (IBAction)onClickBtnLogin:(id)sender {
    if (_txtFld_UID.text && _txtFld_UID.text.length > 0)
    {
        [self login:_btn_login];
    }
    else
    {
       UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                  message:@"The UID cannot be Empty."
                                  preferredStyle:UIAlertControllerStyleAlert];

       UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action) {}];

       [alert addAction:defaultAction];
       [self presentViewController:alert animated:YES completion:nil];
    }
    
}




-(void)login:(id)sender
{
    self.activityIndicatorView_login.hidden = NO;
    [self indicatorstartAnimating];
    
    __weak __typeof__(self) weakSelf = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"CometChat-info" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    id AuthenticationDict = [dict objectForKey: @"Authentication"];
    NSString *apiKey = AuthenticationDict[@"API_KEY"];
    NSLog(@"api key is: %@",apiKey);
    
    [CometChatProRequests loginWithUID:self.txtFld_UID.text andAPIKey:apiKey loggedinUser:^(User * _Nonnull user) {
        /**
         * l o g i n   s u c c e s s f u l
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            __typeof__(self) strongSelf = weakSelf;
           
            [[NSUserDefaults standardUserDefaults]setObject:[user uid] forKey:@LOGGED_IN_USER_ID];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@IS_LOGGED_IN];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [strongSelf indicatorstopAnimating];
            TabBarViewController *tabbarcontroller  = [strongSelf.storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
            if (@available(iOS 13.0, *)) {
                [tabbarcontroller setModalPresentationStyle: UIModalPresentationFullScreen];
                [strongSelf presentViewController:tabbarcontroller animated:YES completion:^{
                    
                    
                }];
            } else {
               [strongSelf presentViewController:tabbarcontroller animated:YES completion:^{
                    
                    
                }];
            }
            
            
        });
    } andError:^(CometChatException * _Nonnull error) {
        /**
         * l o g i n   e r r o r
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            
             __typeof__(self) strongSelf = weakSelf;
            
            [strongSelf indicatorstopAnimating];
            
        });
        
    }];
}

#pragma mark  - Keyboard Delegates

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, _userNameField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:_userNameField.frame animated:YES];
    }
}
- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark  - UITextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self dismissKeyboard];
    return YES;
}

#pragma mark  - Getters

-(UIImageView *)logoImage{
    
    if (!_logoImage) {
        _logoImage = [UIImageView new];
        [_logoImage setImage:[UIImage imageNamed:@"cometchat_white"]];
        [_logoImage setImage:[[_logoImage image] imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)]];
        [_logoImage setTintColor:[UIColor whiteColor]];
        [_logoImage setContentMode:(UIViewContentModeScaleAspectFit)];
    }
    return _logoImage;
}
-(UITextField *)userNameField{
    
    if (!_userNameField) {
        _userNameField = [UITextField new];
        _userNameField.delegate = self;
        _userNameField.layer.masksToBounds = YES;
        _userNameField.placeholder = NSLocalizedString(@"Enter UID", "");
        _userNameField.textAlignment = NSTextAlignmentCenter;
        _userNameField.returnKeyType = UIReturnKeyGo;
        [_userNameField becomeFirstResponder];
        [_userNameField setBackgroundColor:[UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255.0 alpha:1.0]];
        _userNameField.layer.cornerRadius = 12.0f;
    }
    return _userNameField;
}
//-(UIButton *)loginButton{
//
//    if (!_loginButton) {
//        _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [_loginButton setTitle:NSLocalizedString(@"login", "") forState:UIControlStateNormal];
//        [_loginButton.layer setCornerRadius:12.0f];
//        [_loginButton setBackgroundColor:[hexToRGB colorWithHexString:@"#2636BE"]];
//        [_loginButton setTintColor:[UIColor whiteColor]];
//        [[_loginButton titleLabel] setFont:[UIFont systemFontOfSize:17.0f weight:(UIFontWeightSemibold)]];
//        [_loginButton addTarget:self action:@selector(loginButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _loginButton;
//}
-(UILabel *)tryADemo{
    
    if (!_tryADemo) {
        
        _tryADemo = [UILabel new];
        [_tryADemo setUserInteractionEnabled:YES];
        [_tryADemo setFont:[UIFont systemFontOfSize:14.0f]];
        [_tryADemo setAdjustsFontSizeToFitWidth:YES];
        [_tryADemo setTextAlignment:NSTextAlignmentCenter];
        
        NSString *tryDemoUser = NSLocalizedString(@"DON'T HAVE AN ACCOUNT ? TRY A DEMO USER", "");
        NSMutableAttributedString *tryDemoAttributed = [[NSMutableAttributedString alloc]initWithString: tryDemoUser];
        [tryDemoAttributed addAttribute:NSForegroundColorAttributeName
                                  value:[hexToRGB colorWithHexString:@"#2636BE"]
                                  range:[tryDemoUser rangeOfString:NSLocalizedString(@"TRY A DEMO USER", "")]];
        
        [_tryADemo setAttributedText:tryDemoAttributed];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [_tryADemo addGestureRecognizer:tap];
        [tap addTarget:self action:@selector(presentDemoUserList:)];
        
    }
    return _tryADemo;
}
-(UIView *)subViewHolder{
    
    if (!_subViewHolder) {
        _subViewHolder = [UIView new];
        [_subViewHolder.layer setCornerRadius:10.0f];
    }
    return _subViewHolder;
}
-(UIView *)imageHolder {
    if (!_imageHolder) {
        _imageHolder = [UIView new];
    }
    return _imageHolder;
}

#pragma mark  - Set Up SubViews

-(void)viewWillsetupSubviews{
    
    [self.contentView addSubview:self.subViewHolder];
    [self.contentView addSubview:self.imageHolder];
    [_subViewHolder setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_imageHolder setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_imageHolder addSubview:self.logoImage];
    [_logoImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_subViewHolder addSubview:self.userNameField];
    [_subViewHolder addSubview:self.loginButton];
    [_subViewHolder addSubview:self.tryADemo];
    [_userNameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_tryADemo setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView setBackgroundColor:[hexToRGB colorWithHexString:@"#2636BE"]];
    [self.subViewHolder setBackgroundColor:[UIColor whiteColor]];
    //[self addConstraintsforSize:self.view.frame.size];
    
    //Update Ui
    [_view_LoginView.layer setCornerRadius:18.0f];
    [_view_LoginView.layer setMasksToBounds:YES];
    [_btn_login.layer setCornerRadius:15.0f];
    [_btn_login.layer setMasksToBounds:YES];
    [_view_superHero1.layer setCornerRadius:5.0f];
    [_view_superHero1.layer setBorderWidth:1.0f];
    [_view_superHero1.layer setBorderColor:[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0].CGColor];
    [_view_superHero1.layer setMasksToBounds:YES];
    [_view_superHero2.layer setCornerRadius:5.0f];
    [_view_superHero2.layer setBorderWidth:1.0f];
    [_view_superHero2.layer setBorderColor:[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0].CGColor];
    [_view_superHero2.layer setMasksToBounds:YES];
    [_view_superHero3.layer setCornerRadius:5.0f];
    [_view_superHero3.layer setBorderWidth:1.0f];
    [_view_superHero3.layer setBorderColor:[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0].CGColor];
    [_view_superHero3.layer setMasksToBounds:YES];
    [_view_superHero4.layer setCornerRadius:5.0f];
    [_view_superHero4.layer setBorderWidth:1.0f];
    [_view_superHero4.layer setBorderColor:[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0].CGColor];
    [_view_superHero4.layer setMasksToBounds:YES];
    _activityIndicatorView_login.hidden = YES;
}

-(void)addConstraintsforSize:(CGSize)size
{
    
    CGFloat height = IS_IPAD?(size.height) * 73/100:size.height;
    CGFloat width  = IS_IPAD?(size.width) * 69/100:size.width;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_userNameField,_loginButton,_tryADemo,_subViewHolder,_imageHolder);
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationUnknown) {
        
        
        NSArray *horizonatal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageHolder]|" options:0 metrics:nil views:views];
        NSArray *horizonatal2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_subViewHolder]|" options:0 metrics:nil views:views];
        NSArray *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(16)-[_imageHolder]-(20)-[_subViewHolder]-(-5)-|" options:0 metrics:nil views:views];
        
        [self.contentView addConstraints:horizonatal];
        [self.contentView addConstraints:horizonatal2];
        [self.contentView addConstraints:vertical];
        
        
        CGFloat textFieldWidth = width*0.50;
        CGFloat textfieldHeight = 50;
        CGFloat _loginButtonWidth = textFieldWidth ;
        CGFloat _loginButtonHeight = 50.0f;
        CGFloat horizntalSpacing = paddingX*3;
        CGFloat verticalSpacing = height * 0.15;
        
        NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%f",textFieldWidth],@"textFieldWidth",
                                 [NSString stringWithFormat:@"%f",textfieldHeight],@"textfieldHeight",
                                 [NSString stringWithFormat:@"%f",_loginButtonWidth],@"_loginButtonWidth",
                                 [NSString stringWithFormat:@"%f",_loginButtonHeight],@"_loginButtonHeight",
                                 [NSString stringWithFormat:@"%f",horizntalSpacing],@"horizntalSpacing",
                                 [NSString stringWithFormat:@"%f",verticalSpacing],@"verticalSpacing",nil];
        
        NSArray *verticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(verticalSpacing)-[_userNameField(textfieldHeight)]-(16)-[_loginButton(_loginButtonHeight)]-(16)-[_tryADemo]-(verticalSpacing)-|"  options:0 metrics:metrics views:views];
        
        
        NSArray *horizontalConstraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(horizntalSpacing)-[_userNameField]-(horizntalSpacing)-|"  options:0 metrics:metrics views:views];
        
        NSArray *horizontalConstraints3 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(horizntalSpacing)-[_loginButton]-(horizntalSpacing)-|"  options:0 metrics:metrics views:views];
        NSArray *horizontalConstraints4 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(horizntalSpacing)-[_tryADemo]-(horizntalSpacing)-|"  options:0 metrics:metrics views:views];
        
        [_subViewHolder addConstraints:horizontalConstraints2];
        [_subViewHolder addConstraints:horizontalConstraints3];
        [_subViewHolder addConstraints:horizontalConstraints4];
        [_subViewHolder addConstraints:verticalConstraints];
        
        [self.imageHolder addConstraint:[NSLayoutConstraint constraintWithItem:self.logoImage attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeWidth) multiplier:1 constant:width/3]];
        [self.imageHolder addConstraint:[NSLayoutConstraint constraintWithItem:self.logoImage attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeHeight) multiplier:1 constant:width/3]];
        
    } else {
        
        CGFloat textFieldWidth = width*0.50;
        CGFloat textfieldHeight = 50;
        CGFloat _loginButtonWidth = textFieldWidth ;
        CGFloat _loginButtonHeight = 50;
        CGFloat horizntalSpacing = paddingX*3;
        CGFloat verticalSpacingFortextField = height * 30/100;
        CGFloat imageHolderWidth = width*0.30;
        CGFloat holderViewWidth = width*0.70 - paddingX*2;
        
        NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%f",textFieldWidth],@"textFieldWidth",
                                 [NSString stringWithFormat:@"%f",textfieldHeight],@"textfieldHeight",
                                 [NSString stringWithFormat:@"%f",_loginButtonWidth],@"_loginButtonWidth",
                                 [NSString stringWithFormat:@"%f",_loginButtonHeight],@"_loginButtonHeight",
                                 [NSString stringWithFormat:@"%f",horizntalSpacing],@"horizntalSpacing",
                                 [NSString stringWithFormat:@"%f",verticalSpacingFortextField],@"verticalSpacingFortextField",
                                 [NSString stringWithFormat:@"%f",imageHolderWidth],@"imageHolderWidth",
                                 [NSString stringWithFormat:@"%f",holderViewWidth],@"holderViewWidth",nil];
        
        
        NSArray *horizonatal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageHolder(imageHolderWidth)]-[_subViewHolder(holderViewWidth)]|" options:0 metrics:metrics views:views];
        NSArray *vertical1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageHolder]|" options:0 metrics:nil views:views];
        NSArray *vertical2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_subViewHolder]|" options:0 metrics:nil views:views];
        
        [self.contentView addConstraints:horizonatal];
        [self.contentView addConstraints:vertical1];
        [self.contentView addConstraints:vertical2];
        
        NSArray *verticalConstraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(verticalSpacingFortextField)-[_userNameField(textfieldHeight)]-(16)-[_loginButton(_loginButtonHeight)]-(16)-[_tryADemo]"  options:0 metrics:metrics views:views];
        
        NSArray *horizontalConstraints1 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(horizntalSpacing)-[_userNameField]-(horizntalSpacing)-|"  options:0 metrics:metrics views:views];
        NSArray *horizontalConstraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(horizntalSpacing)-[_loginButton]-(horizntalSpacing)-|"  options:0 metrics:metrics views:views];
        NSArray *horizontalConstraints3 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(horizntalSpacing)-[_tryADemo]-(horizntalSpacing)-|"  options:0 metrics:metrics views:views];
        
        [_subViewHolder addConstraints:horizontalConstraints1];
        [_subViewHolder addConstraints:horizontalConstraints2];
        [_subViewHolder addConstraints:horizontalConstraints3];
        [_subViewHolder addConstraints:verticalConstraints2];
        
        [self.imageHolder addConstraint:[NSLayoutConstraint constraintWithItem:self.logoImage attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeWidth) multiplier:1 constant:height/3]];
        [self.imageHolder addConstraint:[NSLayoutConstraint constraintWithItem:self.logoImage attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeHeight) multiplier:1 constant:height/3]];
    }
    
    [self.imageHolder addConstraint:[NSLayoutConstraint constraintWithItem:self.logoImage attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:self.imageHolder attribute:(NSLayoutAttributeCenterX) multiplier:1 constant:0]];
    [self.imageHolder addConstraint:[NSLayoutConstraint constraintWithItem:self.logoImage attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:self.imageHolder attribute:(NSLayoutAttributeCenterY) multiplier:1 constant:0]];
    
}

-(ActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[ActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    }
    return _activityIndicator;
}

-(void)indicatorstartAnimating
{
    [_txtFld_UID setRightView:[self activityIndicator]];
    _txtFld_UID.rightViewMode = UITextFieldViewModeAlways;
    [[self activityIndicatorView_login] startAnimating];
    [_btn_login setEnabled:NO];
    [_btn_login setTitle:@"Processing..." forState:UIControlStateNormal];
    [_userNameField setEnabled:NO];
}

-(void)indicatorstopAnimating
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@IS_LOGGED_IN]){
        [[self activityIndicator] stopAnimating];
        self.activityIndicatorView_login.hidden = YES;
        [[self activityIndicator] removeFromSuperview];
        [_loginButton setEnabled:YES];
        [_btn_login setEnabled:YES];
        [_btn_login setTitle:@"Login Successful" forState:UIControlStateNormal];
        [_btn_login setBackgroundColor:[hexToRGB colorWithHexString:@"#9ACD32"]];
        [_userNameField setEnabled:YES];
    }
    else{
        [[self activityIndicator] stopAnimating];
        [[self activityIndicator] removeFromSuperview];
        self.activityIndicatorView_login.hidden = YES;
        [_btn_login setEnabled:YES];
        [_btn_login setTitle:@"Login Failure" forState:UIControlStateNormal];
        [_btn_login setBackgroundColor:[hexToRGB colorWithHexString:@"#FF0000"]];
        [_loginButton setEnabled:YES];
        [_userNameField setEnabled:YES];
    }
}

-(void)presentDemoUserList:(id)sender{
    
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *beView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    beView.frame = self.view.bounds;
    demoUsers.view.frame = self.view.bounds;
    demoUsers.view.backgroundColor = [UIColor clearColor];
    [demoUsers.view insertSubview:beView atIndex:0];
    [beView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [demoUsers.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(beView)]];
    [demoUsers.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(beView)]];
    demoUsers.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [DemoUser Present:demoUsers on:self];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
-(void)selectedUser:(DemoUser *)user{
    
    [_userNameField setText:[user uid]];
}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
     __weak __typeof__(self) weakSelf = self;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [weakSelf.contentView removeConstraints:weakSelf.contentView.constraints];
        [weakSelf.subViewHolder removeConstraints:weakSelf.subViewHolder.constraints];
        [weakSelf.imageHolder removeConstraints:weakSelf.imageHolder.constraints];
        [weakSelf addConstraintsforSize:size];
    }];
}

-(void)dealloc
{
    NSLog(@"dealloc %@", self);
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardDidShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}
@end
