//
//  LoginViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "LoginViewController.h"
#import "TabBarViewController.h"

@interface LoginViewController ()
@property(strong ,nonatomic) UIView             *subViewHolder;
@property(strong ,nonatomic) UIView             *imageHolder;
@property(strong ,nonatomic) UITextField        *userNameField;
@property(strong ,nonatomic) UIButton           *loginButton;
@property(strong ,nonatomic) UIImageView        *logoImage;
@property(nonatomic ,strong) UILabel            *tryADemo;
@property(nonatomic ,strong)   ActivityIndicatorView   *activityIndicator;
@end

@implementation LoginViewController
{
    DemoUsersViewController *demoUsers;
    HexToRGBConvertor       *hexToRGB;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    demoUsers = [[DemoUsersViewController alloc] init];
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
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

#pragma mark  - CometChatPro Login

- (IBAction)loginButtonTouchUpInside:(UIButton *)sender {
    [self login:sender];
}
-(void)login:(id)sender
{
    [self indicatorstartAnimating];
    
    __weak __typeof__(self) weakSelf = self;
    
    [CometChatProRequests loginWithUID:[self.userNameField text] andAPIKey:@API_KEY loggedinUser:^(User * _Nonnull user) {
        /**
         * l o g i n   s u c c e s s f u l
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            __typeof__(self) strongSelf = weakSelf;
            
            [strongSelf indicatorstopAnimating];
            TabBarViewController *tabbarcontroller  = [strongSelf.storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
            [strongSelf presentViewController:tabbarcontroller animated:YES completion:^{
                
                [[NSUserDefaults standardUserDefaults]setObject:[user uid] forKey:@LOGGED_IN_USER_ID];
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@IS_LOGGED_IN];
                
            }];
            
        });
    } andError:^(CometChatException * _Nonnull error) {
        /**
         * l o g i n   e r r o r
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            
             __typeof__(self) strongSelf = weakSelf;
            
            [strongSelf indicatorstopAnimating];
            
            if ([sender isKindOfClass:[UIButton class]]) {
                [(UIButton *) sender setBackgroundColor:[UIColor redColor]];
            }
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[error errorCode] message:[error errorDescription] preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *ok = [UIAlertAction actionWithTitle: NSLocalizedString(@"Ok", "") style:(UIAlertActionStyleDefault) handler:nil];
            [alert addAction:ok];
            [strongSelf presentViewController:alert animated:YES completion:nil];
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
    [self login:self.loginButton];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
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
-(UIButton *)loginButton{
    
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_loginButton setTitle:NSLocalizedString(@"login", "") forState:UIControlStateNormal];
        [_loginButton.layer setCornerRadius:12.0f];
        [_loginButton setBackgroundColor:[hexToRGB colorWithHexString:@"#2636BE"]];
        [_loginButton setTintColor:[UIColor whiteColor]];
        [[_loginButton titleLabel] setFont:[UIFont systemFontOfSize:17.0f weight:(UIFontWeightSemibold)]];
        [_loginButton addTarget:self action:@selector(loginButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
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
-(UIView *)imageHolder
{
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
    
    [self addConstraintsforSize:self.view.frame.size];
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
    [_userNameField setRightView:[self activityIndicator]];
    _userNameField.rightViewMode = UITextFieldViewModeAlways;
    [[self activityIndicator] startAnimating];
    [_loginButton setEnabled:NO];
    [_userNameField setEnabled:NO];
}
-(void)indicatorstopAnimating
{
    [[self activityIndicator] stopAnimating];
    [[self activityIndicator] removeFromSuperview];
    [_loginButton setEnabled:YES];
    [_userNameField setEnabled:YES];
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
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.contentView removeConstraints:self.contentView.constraints];
        [self.subViewHolder removeConstraints:self.subViewHolder.constraints];
        [self.imageHolder removeConstraints:self.imageHolder.constraints];
        [self addConstraintsforSize:size];
    }];
}

-(void)dealloc
{
    NSLog(@"dealloc %@", self);
}
@end
