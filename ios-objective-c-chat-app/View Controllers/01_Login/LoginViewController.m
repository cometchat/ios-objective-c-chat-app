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
@property(strong ,nonatomic) UIView  *holderView;
@property(strong ,nonatomic) UITextField *userNameField;
@property(strong ,nonatomic) UIButton *loginButton;
@property(strong ,nonatomic) UIImageView *logoImage;
@property(strong ,nonatomic) CALayer *border;
@property(nonatomic ,strong) UILabel *tryADemo;
@end

@implementation LoginViewController
{
     ActivityIndicatorView *activityIndicator;
     DemoUsersViewController *demousers;
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    demousers = [[DemoUsersViewController alloc] init];
    demousers.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.contentView addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)name:UIKeyboardWillHideNotification object:nil];
    [self setupsubViews];
    [self setUpActivityIndicatorView];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (IBAction)loginButtonTouchUpInside:(UIButton *)sender {
    [self login];
}
-(void)login
{
    [self indicatorstartAnimating];
    [CometChatProRequests loginWithUID:[self.userNameField text] andAPIKey:@API_KEY loggedinUser:^(User * _Nonnull user) {
        /**
         * l o g i n   s u c c e s s f u l
         **/
        dispatch_async(dispatch_get_main_queue(), ^{
            [self indicatorstopAnimating];
            
            TabBarViewController *tabbarcontroller  = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
            [self presentViewController:tabbarcontroller animated:YES completion:^{
                
                [[NSUserDefaults standardUserDefaults]setObject:[user uid] forKey:@LOGGED_IN_USER_ID];
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@IS_LOGGED_IN];
                
            }];
            
        });
    } andError:^(CometChatException * _Nonnull error) {
        /**
         * l o g i n   e r r o r
         **/
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self indicatorstopAnimating];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[error errorDescription] preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *ok = [UIAlertAction actionWithTitle: NSLocalizedString(@"Ok", "") style:(UIAlertActionStyleDefault) handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self dismissKeyboard];
    [self login];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}
-(UIImageView *)logoImage{
    
    if (!_logoImage) {
        _logoImage = [UIImageView new];
        [_logoImage setImage:[UIImage imageNamed:@"cometchat_white"]];
        [_logoImage setImage:[[_logoImage image] imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)]];
        [_logoImage setTintColor:[UIColor darkGrayColor]];
        [_logoImage setContentMode:(UIViewContentModeScaleAspectFit)];
    }
    return _logoImage;
}
-(UITextField *)userNameField{
    
    if (!_userNameField) {
        _userNameField = [UITextField new];
        _userNameField.delegate = self;
        _userNameField.layer.masksToBounds = YES;
        _userNameField.placeholder = NSLocalizedString(@"Username", "");
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
        [_loginButton setBackgroundColor:[UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f]];
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
        NSString *someString = NSLocalizedString(@"DON'T HAVE AN ACCOUNT ? TRY A DEMO USER", "");
        [_tryADemo setTextAlignment:NSTextAlignmentCenter];
        NSMutableAttributedString *some = [[NSMutableAttributedString alloc]initWithString: someString];
        [some addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f] range:[someString rangeOfString:NSLocalizedString(@"TRY A DEMO USER", "")]];
        [_tryADemo setAttributedText:some];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [_tryADemo addGestureRecognizer:tap];
        [tap addTarget:self action:@selector(showDemoUsers)];
    }
    return _tryADemo;
}
-(UIView *)holderView{
    
    if (!_holderView) {
        _holderView = [UIView new];
    }
    return _holderView;
}
-(CALayer *)border{
    
    if (!_border) {
        
        _border = [CALayer new];
        
        _border.cornerRadius = 2.0f;
        _border.borderWidth = 1.0f;
        _border.borderColor = [UIColor clearColor].CGColor;
        _border.masksToBounds = YES;
        _border.shadowColor = [UIColor lightGrayColor].CGColor;
        _border.shadowOffset = CGSizeMake(0, 2.0f);
        _border.shadowRadius = 5.0f;
        _border.shadowOpacity = 1.0f;
        _border.masksToBounds = NO;
        _border.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_holderView.bounds cornerRadius:_border.cornerRadius].CGPath;
        
    }
    return _border;
}
-(void)setupsubViews{
    
    [self.contentView addSubview:self.holderView];
    [_holderView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [_holderView setBackgroundColor:[UIColor whiteColor]];
    
    [_holderView addSubview:self.logoImage];
    [_holderView addSubview:self.userNameField];
    [_holderView addSubview:self.loginButton];
    [_holderView addSubview:self.tryADemo];
    
    [_logoImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_userNameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_tryADemo setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints];
}
-(void)addConstraints
{
    
    CGFloat height = IS_IPAD?(self.view.frame.size.height) * 73/100:self.view.frame.size.height;
    CGFloat width  = IS_IPAD?(self.view.frame.size.width) * 69/100:self.view.frame.size.width;
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_holderView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0f];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_holderView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0f];
    
    NSLayoutConstraint *heightForView = [NSLayoutConstraint constraintWithItem:_holderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
    NSLayoutConstraint *widthForView = [NSLayoutConstraint constraintWithItem:_holderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
    
    [self.contentView addConstraints:@[centerX, centerY]];
    [self.contentView addConstraints:@[heightForView, widthForView]];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_logoImage,_userNameField,_loginButton,_tryADemo);
    
    if ([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationPortrait) {
        
        CGFloat _logoImageWidth = width - paddingX*2;
        CGFloat _logoImageHeight = height/3;
        CGFloat textFieldWidth = width*0.50;
        CGFloat textfieldHeight = 50;
        CGFloat _loginButtonWidth = textFieldWidth ;
        CGFloat _loginButtonHeight = 50.0f;
        CGFloat horizntalSpacing = paddingX*3;
        CGFloat verticalSpacing = height * 0.15;
        
        NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%f",_logoImageWidth],@"_logoImageWidth",
                                 [NSString stringWithFormat:@"%f",_logoImageHeight],@"_logoImageHeight",
                                 [NSString stringWithFormat:@"%f",textFieldWidth],@"textFieldWidth",
                                 [NSString stringWithFormat:@"%f",textfieldHeight],@"textfieldHeight",
                                 [NSString stringWithFormat:@"%f",_loginButtonWidth],@"_loginButtonWidth",
                                 [NSString stringWithFormat:@"%f",_loginButtonHeight],@"_loginButtonHeight",
                                 [NSString stringWithFormat:@"%f",horizntalSpacing],@"horizntalSpacing",
                                 [NSString stringWithFormat:@"%f",verticalSpacing],@"verticalSpacing",nil];
        
        NSArray *verticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_logoImage(_logoImageHeight)]-(40)-[_userNameField(textfieldHeight)]-(16)-[_loginButton(_loginButtonHeight)]-(16)-[_tryADemo]-(verticalSpacing)-|"  options:0 metrics:metrics views:views];
        
        
        NSArray *horizontalConstraints1 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_logoImage(_logoImageWidth)]-|"  options:0 metrics:metrics views:views];
        NSArray *horizontalConstraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(horizntalSpacing)-[_userNameField]-(horizntalSpacing)-|"  options:0 metrics:metrics views:views];
        
        NSArray *horizontalConstraints3 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(horizntalSpacing)-[_loginButton]-(horizntalSpacing)-|"  options:0 metrics:metrics views:views];
        NSArray *horizontalConstraints4 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(horizntalSpacing)-[_tryADemo]-(horizntalSpacing)-|"  options:0 metrics:metrics views:views];
        
        [_holderView addConstraints:horizontalConstraints1];
        [_holderView addConstraints:horizontalConstraints2];
        [_holderView addConstraints:horizontalConstraints3];
        [_holderView addConstraints:horizontalConstraints4];
        [_holderView addConstraints:verticalConstraints];
        
    } else {
        
        CGFloat _logoImageWidth = width *30/100;
        CGFloat _logoImageHeight = height - paddingY*2;
        CGFloat textFieldWidth = width* 70/100 - paddingX*9;
        CGFloat textfieldHeight = 40;
        CGFloat _loginButtonWidth = textFieldWidth ;
        CGFloat _loginButtonHeight = 40;
        CGFloat horizntalSpacing = paddingX*3;
        CGFloat verticalSpacingFortextField = height * 30/100;
        
        NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%f",_logoImageWidth],@"_logoImageWidth",
                                 [NSString stringWithFormat:@"%f",_logoImageHeight],@"_logoImageHeight",
                                 [NSString stringWithFormat:@"%f",textFieldWidth],@"textFieldWidth",
                                 [NSString stringWithFormat:@"%f",textfieldHeight],@"textfieldHeight",
                                 [NSString stringWithFormat:@"%f",_loginButtonWidth],@"_loginButtonWidth",
                                 [NSString stringWithFormat:@"%f",_loginButtonHeight],@"_loginButtonHeight",
                                 [NSString stringWithFormat:@"%f",horizntalSpacing],@"horizntalSpacing",
                                 [NSString stringWithFormat:@"%f",verticalSpacingFortextField],@"verticalSpacingFortextField",nil];
        
        
        NSArray *verticalConstraints1 =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_logoImage(_logoImageHeight)]-|"  options:0 metrics:metrics views:views];
        
        NSArray *verticalConstraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(verticalSpacingFortextField)-[_userNameField(textfieldHeight)]-(16)-[_loginButton(_loginButtonHeight)]-(16)-[_tryADemo]"  options:0 metrics:metrics views:views];
        
        NSArray *horizontalConstraints1 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(horizntalSpacing)-[_logoImage(_logoImageWidth)]-(horizntalSpacing)-[_userNameField(textFieldWidth)]-|"  options:0 metrics:metrics views:views];
        NSArray *horizontalConstraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_logoImage(_logoImageWidth)]-(horizntalSpacing)-[_loginButton(_loginButtonWidth)]-|"  options:0 metrics:metrics views:views];
        NSArray *horizontalConstraints3 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_logoImage(_logoImageWidth)]-(horizntalSpacing)-[_tryADemo(_loginButtonWidth)]-|"  options:0 metrics:metrics views:views];
        
        [_holderView addConstraints:horizontalConstraints1];
        [_holderView addConstraints:horizontalConstraints2];
        [_holderView addConstraints:horizontalConstraints3];
        [_holderView addConstraints:verticalConstraints1];
        [_holderView addConstraints:verticalConstraints2];
    }
    
}

-(void)setUpActivityIndicatorView
{
    activityIndicator = [[ActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
}

-(void)indicatorstartAnimating
{
    _userNameField.rightView = activityIndicator;
    _userNameField.rightViewMode = UITextFieldViewModeAlways;
    [activityIndicator startAnimating];
    [_loginButton setEnabled:NO];
    [_userNameField setEnabled:NO];
}
-(void)indicatorstopAnimating
{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    [_loginButton setEnabled:YES];
    [_userNameField setEnabled:YES];
}

-(void)showDemoUsers{
    
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *beView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    beView.frame = self.view.bounds;
    demousers.view.frame = self.view.bounds;
    demousers.view.backgroundColor = [UIColor clearColor];
    [demousers.view insertSubview:beView atIndex:0];
    [beView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [demousers.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(beView)]];
    [demousers.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(beView)]];
    demousers.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [DemoUser Present:demousers on:self];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [UIView animateWithDuration:0.25 animations:^{
        [self.contentView removeConstraints:self.contentView.constraints];
        [self.holderView removeConstraints:self.holderView.constraints];
        [self addConstraints];
    }];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.border removeFromSuperlayer];
    [_holderView.layer addSublayer:_border];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void)selectedUser:(DemoUser *)user{
    
    [_userNameField setText:[user uid]];
}

-(void)dealloc
{
    NSLog(@"dealloc %@", self);
}
@end
