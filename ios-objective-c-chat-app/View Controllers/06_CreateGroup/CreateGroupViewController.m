//
//  CreateGroupViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 21/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "CreateGroupViewController.h"

@interface CreateGroupViewController ()<UITextFieldDelegate ,UITableViewDelegate ,UITableViewDataSource >
@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wrapperBottomConstraint;
@property (strong , nonatomic) UIButton *selectgroupType;
@property (strong , nonatomic) UITextField *selectgroupName;
@property (strong , nonatomic) UITextField *selectgroupDesc;
@property (strong , nonatomic) UITextField *passwordTxtFld;
@property (strong , nonatomic) NSString *groupType;
@property (nonatomic) groupType group_type;
@end

@implementation CreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    self.groupType = [NSString stringWithFormat:@"Public"];
    self.group_type = groupTypePublic;
    
    [self viewWillSetNavigationBar];
    
}
-(void)viewWillSetNavigationBar{
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        
    } else {
        // Fallback on earlier versions
    }
    
    self.navigationItem.title = @"Create New Group";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(doneGroup)];
    [self.navigationItem setRightBarButtonItem:done];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
            if (_selectgroupName) { [_selectgroupName removeFromSuperview]; }
            _selectgroupName = [[UITextField alloc]initWithFrame:CGRectMake(20.0f, 0.0f, cell.contentView.frame.size.width, cell.contentView.frame.size.height - 2.0f)];
            [_selectgroupName setFont:[UIFont systemFontOfSize:14.0f weight:(UIFontWeightSemibold)]];
            [_selectgroupName setDelegate:self];
            [_selectgroupName setPlaceholder:@"group name"];
            [_selectgroupName setBackground:[UIImage imageNamed:@"underline"]];
            [[cell contentView] addSubview:_selectgroupName];
            
            return cell;
        }
            break;
        case 1:
        {
            if (_selectgroupDesc) { [_selectgroupDesc removeFromSuperview]; }
            _selectgroupDesc = [[UITextField alloc]initWithFrame:CGRectMake(20.0f, 0.0f, cell.contentView.frame.size.width, cell.contentView.frame.size.height - 2.0f)];
            [_selectgroupDesc setFont:[UIFont systemFontOfSize:14.0f weight:(UIFontWeightSemibold)]];
            [_selectgroupDesc setDelegate:self];
            [_selectgroupDesc setPlaceholder:@"group description"];
            [_selectgroupDesc setBackground:[UIImage imageNamed:@"underline"]];
            [[cell contentView] addSubview:_selectgroupDesc];
            
            return cell;
        }
            break;
        case 2:
        {
            
            switch ([indexPath row]) {
                case 0:
                    if (_selectgroupType) { [_selectgroupType removeFromSuperview]; }
                    _selectgroupType = [[UIButton alloc]initWithFrame:CGRectMake(20.0f, 0.0f, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
                    [_selectgroupType setTitle:self.groupType forState:UIControlStateNormal];
                    [_selectgroupType setTitleColor:[UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
                    [_selectgroupType.titleLabel setFont:[UIFont systemFontOfSize:14.0f weight:(UIFontWeightSemibold)]];
                    [_selectgroupType addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
                    _selectgroupType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    
                    [[cell contentView] addSubview:_selectgroupType];
                    return cell;
                    break;
                case 1:
                    if (_passwordTxtFld) { [_passwordTxtFld removeFromSuperview]; }
                    _passwordTxtFld = [[UITextField alloc]initWithFrame:CGRectMake(20.0f, 0.0f, cell.contentView.frame.size.width, cell.contentView.frame.size.height - 2.0f)];
                    [_passwordTxtFld setFont:[UIFont systemFontOfSize:14.0f weight:(UIFontWeightSemibold)]];
                    [_passwordTxtFld setDelegate:self];
                    [_passwordTxtFld setPlaceholder:@"password"];
                    [_passwordTxtFld setBackground:[UIImage imageNamed:@"underline"]];
                    [[cell contentView] addSubview:_passwordTxtFld];
                    
                    return cell;
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2 && [self.groupType isEqualToString:@"Password Protected"]) {
        return 2;
    }
    return 1.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 44.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view;
    
    switch (section) {
        case 0:{
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 44.0)];
            [view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0, view.frame.size.height - 30.0, 250.0, 25.0)];
            label.text = [NSString stringWithFormat:@"Group Name*"];
            [label setFont:[UIFont systemFontOfSize:14.0f]];
            [label setTextColor:[UIColor grayColor]];
            [view addSubview:label];
            
            break;
        }
        case 1:{
            view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 44.0)];
            [view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0, view.frame.size.height - 30.0, 250.0, 25.0)];
            label.text = [NSString stringWithFormat:@"Group Description"];
            [label setFont:[UIFont systemFontOfSize:14.0f]];
            [label setTextColor:[UIColor grayColor]];
            [view addSubview:label];
            break;
        }
        case 2:
        {
            view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 44.0)];
            [view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0, view.frame.size.height - 30.0, 250.0, 25.0)];
            label.text = [NSString stringWithFormat:@"Group Type *"];
            [label setFont:[UIFont systemFontOfSize:14.0f]];
            [label setTextColor:[UIColor grayColor]];
            [view addSubview:label];
            break;
        }
        default:
            break;
    }
    
    
    return view;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)keyboardWillChange:(NSNotification *)notification
{
    
    // Get duration of keyboard appearance/ disappearance animation
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions animationOptions = animationCurve | (animationCurve << 16); // Convert animation curve to animation option
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Get the final size of the keyboard
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Calculate the new bottom constraint, which is equal to the size of the keyboard
    CGRect screen = [UIScreen mainScreen].bounds;
    CGFloat newBottomConstraint = (screen.size.height-keyboardEndFrame.origin.y);
    
    // Keep old y content offset and height before they change
    CGFloat oldYContentOffset = self._tableView.contentOffset.y;
    CGFloat oldTableViewHeight = self._tableView.bounds.size.height;
    
    [UIView animateWithDuration:animationDuration delay:0 options:animationOptions animations:^{
        // Set the new bottom constraint
        self.wrapperBottomConstraint.constant = - newBottomConstraint;
        // Request layout with the new bottom constraint
        [self.view layoutIfNeeded];
        
        // Calculate the new y content offset
        CGFloat newTableViewHeight = self._tableView.bounds.size.height;
        CGFloat contentSizeHeight = self._tableView.contentSize.height;
        CGFloat newYContentOffset = oldYContentOffset - newTableViewHeight + oldTableViewHeight;
        
        // Prevent new y content offset from exceeding max, i.e. the bottommost part of the UITableView
        CGFloat possibleBottommostYContentOffset = contentSizeHeight - newTableViewHeight;
        newYContentOffset = MIN(newYContentOffset, possibleBottommostYContentOffset);
        
        // Prevent new y content offset from exceeding min, i.e. the topmost part of the UITableView
        CGFloat possibleTopmostYContentOffset = 0;
        newYContentOffset = MAX(possibleTopmostYContentOffset, newYContentOffset);
        
        // Create new content offset
        CGPoint newTableViewContentOffset = CGPointMake(self._tableView.contentOffset.x, newYContentOffset);
        self._tableView.contentOffset = newTableViewContentOffset;
        
    } completion:nil];
}
-(void)alert
{
    [self.view resignFirstResponder];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"select group type" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *Private = [UIAlertAction actionWithTitle:@"Private" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.groupType = [NSString stringWithFormat:@"Private"];
        self.group_type = groupTypePublic;
        NSIndexSet *section = [NSIndexSet indexSetWithIndex:2];
        [__tableView reloadSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    UIAlertAction *Public = [UIAlertAction actionWithTitle:@"Public" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.groupType = [NSString stringWithFormat:@"Public"];
        self.group_type = groupTypePrivate;
        NSIndexSet *section = [NSIndexSet indexSetWithIndex:2];
        [__tableView reloadSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    UIAlertAction *Password = [UIAlertAction actionWithTitle:@"Password Protected" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.groupType = [NSString stringWithFormat:@"Password Protected"];
        self.group_type = groupTypePassword;
        NSIndexSet *section = [NSIndexSet indexSetWithIndex:2];
        [__tableView reloadSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [alert addAction:Private];
    [alert addAction:Public];
    [alert addAction:Password];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)doneGroup
{
    NSString *password;
    if (self.group_type == groupTypePassword && [_passwordTxtFld.text isEqualToString:@""]) {
        [self shakeAnimation:_passwordTxtFld];
        return;
    }else
    {
        password = [NSString stringWithFormat:@"%@",[_passwordTxtFld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
    
    if ([self.selectgroupName.text isEqualToString:@""]) {
        [self shakeAnimation:_selectgroupName];
        return;
    }
    NSString *groupName = [_selectgroupName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *guid = [NSString stringWithFormat:@"%@_%u",groupName,arc4random_uniform(99)];
    
    Group *groupToBeCreated;
    NSDictionary *metadata = [NSDictionary dictionaryWithObjectsAndKeys:@"dummyValue",@"dummyKey", nil];
    
    if (![self.selectgroupDesc.text isEqualToString:@""]) {
        
        groupToBeCreated = [[Group alloc]initWithGuid:guid name:groupName groupType:self.group_type password:password icon:@"https://cdn0.iconfinder.com/data/icons/social-circle-3/72/Codepen-512.png" description:self.selectgroupDesc.text];
        
    }else
    {
        groupToBeCreated =  [[Group alloc]initWithGuid:guid name:groupName groupType:self.group_type password:password];
    }
    [groupToBeCreated setMetadata:metadata];
    
    [CometChat createGroupWithGroup:groupToBeCreated onSuccess:^(Group * _Nonnull created_group) {
        
        [self showNextWithGroup:created_group];
        
    } onError:^(CometChatException * _Nullable error) {
        
        [Alert showAlertForError:error in:self];
        
    }];
}
-(void)shakeAnimation:(UIView *)aView
{

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:4];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([aView center].x - 10.0f, [aView center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([aView center].x + 10.0f, [aView center].y)]];
    [[aView layer] addAnimation:animation forKey:@"position"];

}
-(void)showNextWithGroup:(Group*)group{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        ChatViewController *chatviewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
        chatviewcontroller.hidesBottomBarWhenPushed = YES;
        [chatviewcontroller setAppEntity:group];
        [self pushNextTo:chatviewcontroller];
        
    });
}
-(void)pushNextTo:(UIViewController *)viewcontroller{
    
    [self.navigationController pushViewController:viewcontroller animated:YES];
}
@end
