//
//  ConversationsViewController.m
//  ios-objective-c-chat-app
//
//  Created by Nishant on 11/12/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "ConversationsViewController.h"
#import "ConversationTableViewCell.h"

@interface ConversationsViewController()<UITableViewDelegate,UITableViewDataSource,CometChatMessageDelegate>
@property (nonatomic, strong) ResultsTableController *resultTableViewController;
@property (nonatomic) BOOL moreLoading;
-(id) initIMessageWithEntity:(AppEntity *)appEntity;
@end

@implementation ConversationsViewController
{
    HexToRGBConvertor *hexToRGB;
    NSMutableArray *conversation;
    Conversation *convo;
    User *user;
    Group *group;
    TextMessage *message;
    ConversationRequest *convoRequest;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    hexToRGB = [HexToRGBConvertor new];
    [self.view setBackgroundColor:[hexToRGB colorWithHexString:@"#2636BE"]];
    [self.navigationController.navigationBar setBarTintColor:[hexToRGB colorWithHexString:@"#2636BE"]];
    //[self initializeSearchController];
    [self viewWillSetNavigationBar];

    convoRequest = [[[[ConversationRequestBuilder alloc]initWithLimit:50]setConversationTypeWithConversationType:ConversationTypeNone]build];
     [self fetchConversation];
}

//AppDelegate to Run the Delegate Methods
- (AppDelegate *)delegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

//View Will Appear used to set the delegate methods
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //[self initializeSearchController];
    [self viewWillSetNavigationBar];
}


//Fetching Conversations
- (void)fetchConversation{
    
    [convoRequest fetchNextOnSuccess:^(NSArray<Conversation *> * conversation) {
        if ([conversation count] != 0) {
            self->_conversationListArray = conversation;
             dispatch_async(dispatch_get_main_queue(), ^{
                   [self.tblView_conversation reloadData];
               });
        }else{
            [self refreshContactsList];
        }
    } onError:^(CometChatException * error) {
        [Alert showAlertForError:error in:self];
    }];
}

-(void)refreshContactsList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tblView_conversation reloadData];
    });
}

//Initializing Search Controller
- (void)initializeSearchController {
    
    //instantiate a search results controller for presenting the search/filter results (will be presented on top of the parent table view)
    
    //instantiate a UISearchController - passing in the search results controller table
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:_resultTableViewController];
    [self.searchController.searchBar setBarStyle:UIBarStyleDefault];
    //this view controller can be covered by theUISearchController's view (i.e. search/filter table)
    self.definesPresentationContext = YES;
    
    
    //define the frame for the UISearchController's search bar and tint
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    //    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    self.searchController.obscuresBackgroundDuringPresentation = YES;
    
    //this ViewController will be responsible for implementing UISearchResultsDialog protocol method(s) - so handling what happens when user types into the search bar
    self.searchController.searchResultsUpdater = self;
    
    
    //this ViewController will be responsisble for implementing UISearchBarDelegate protocol methods(s)
    self.searchController.searchBar.delegate = self;
    
    //add the UISearchController's search bar to the header of this table
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchController;
    } else {
        // Fallback on earlier versions
        self.tblView_conversation.tableHeaderView = self.searchController.searchBar;
    }
}

//Setting the Navigation Controller
-(void)viewWillSetNavigationBar{
    
    _view_backgroundView.layer.cornerRadius = 12.0f;
    _view_backgroundView.clipsToBounds = YES;
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        
    } else {
        // Fallback on earlier versions
    }
    
    self.navigationItem.title = NSLocalizedString(@"Conversations", @"");
     UIBarButtonItem *user_details = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"more_vertical"] style:UIBarButtonItemStylePlain target:self action:@selector(showUserDetails)];
       [user_details setTintColor:[UIColor whiteColor]];
       [self.navigationItem setRightBarButtonItems:@[user_details]];
       [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
       [self.navigationController.navigationBar setTranslucent:YES];
    
}

-(void)showUserDetails
{
    
    __weak typeof(self) weakSelf = self;
    MoreViewController *morePage = [self.storyboard instantiateViewControllerWithIdentifier:@"MoreViewController"];
    morePage.hidesBottomBarWhenPushed = YES;
    [weakSelf.navigationController pushViewController:morePage animated:YES];
}


//TableView Delegate Methods

-(void)PushToNext:(AppEntity *)user{
    
    ChatViewController *chatviewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
    chatviewcontroller.hidesBottomBarWhenPushed = YES;
    [chatviewcontroller setAppEntity:user];
    __weak typeof(self) weakSelf = self;
    [weakSelf.navigationController pushViewController:chatviewcontroller animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_conversationListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self PushToNext:[_conversationListArray objectAtIndex:[indexPath row]]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *cellId = @"ConversationTableViewCell";
    ConversationTableViewCell *cell = [_tblView_conversation dequeueReusableCellWithIdentifier:cellId];
     NSString *link;
    
    if (cell == nil) {
        cell = [[ConversationTableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    Conversation *convoObj = [_conversationListArray objectAtIndex:indexPath.row];
    
   // [[_contactListArray objectAtIndex:[indexPath row]] withIndexPath:indexPath];
    NSLog(@"Value of convo is = %@", convoObj.stringValue);
    
    
    //[cell.lbl_name setText:[conversation objectAtIndex:indexPath.row]];
    
    switch (convoObj.conversationType)
    {
            case ConversationTypeUser:
               user = (User *)_appEntity;
               user = convoObj.conversationWith;
               cell.lbl_name.text = [user name];
               link = [user avatar];

            break;

            case ConversationTypeGroup:
                group = (Group *)_appEntity;
                group = convoObj.conversationWith;
                cell.lbl_name.text = [group name];
            
              break;

            case ConversationTypeNone:
              break;
    }
    
    message = (TextMessage *)_appEntity;
    message = convoObj.lastMessage;
    NSString *senderName = message.sender.name;
    
    switch (convoObj.lastMessage.messageCategory) {
            
        case MessageCategoryMessage:
            switch (convoObj.lastMessage.messageType) {
                case MessageTypeText :
                    if (convoObj.conversationType == ConversationTypeUser){
                        cell.lbl_conversation.text = message.text;
                    }
                    else{
                        cell.lbl_conversation.text = message.text;
                    }
                    break;
                case MessageTypeImage:
                    if (convoObj.conversationType == ConversationTypeUser){
                        cell.lbl_conversation.text = @"has sent an image.";
                    }
                    else{
                        NSString *constStatement = @"has sent an image.";
                        NSString *constStatement2 = @": ";
                        NSString *str = [NSString stringWithFormat: @"%@ %@ %@", senderName, constStatement2, constStatement];

                        cell.lbl_conversation.text = senderName = str;
                    }
                    break;
                case MessageTypeVideo:
                   if (convoObj.conversationType == ConversationTypeUser){
                        cell.lbl_conversation.text = @"has sent a video.";
                    }
                    else{
                        NSString *constStatement = @"has sent a video.";
                        NSString *constStatement2 = @": ";
                        NSString *str = [NSString stringWithFormat: @"%@ %@ %@", senderName, constStatement2, constStatement];

                        cell.lbl_conversation.text = senderName = str;
                    }
                    break;
                case MessageTypeAudio:
                    if (convoObj.conversationType == ConversationTypeUser){
                        cell.lbl_conversation.text = @"has sent a audio.";
                    }
                    else{
                        NSString *constStatement = @"has sent a audio.";
                        NSString *constStatement2 = @": ";
                        NSString *str = [NSString stringWithFormat: @"%@ %@ %@", senderName, constStatement2, constStatement];

                        cell.lbl_conversation.text = senderName = str;
                    }
                    break;
                case MessageTypeFile:
                    if (convoObj.conversationType == ConversationTypeUser){
                        cell.lbl_conversation.text = @"has sent a file.";
                    }
                    else{
                        NSString *constStatement = @"has sent a file.";
                        NSString *constStatement2 = @": ";
                        NSString *str = [NSString stringWithFormat: @"%@ %@ %@", senderName, constStatement2, constStatement];

                        cell.lbl_conversation.text = senderName = str;
                    }
                    break;
                case MessageTypeCustom:
                    break;
                default:
                    break;
            }
        case MessageCategoryAction:
            message = convoObj.lastMessage;
            break;
        case MessageCategoryCall:
            break;
        case MessageCategoryCustom:
            
            break;
    }
    
    
     cell.imgView_avatar.tag = indexPath.row;
    
       [cell.imgView_avatar.layer setCornerRadius:cell.imgView_avatar.frame.size.height/2];
       [cell.imgView_avatar setClipsToBounds:YES];
       [cell.imgView_avatar.layer setBorderWidth:1.0f];
       [cell.imgView_avatar.layer setBorderColor:[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0].CGColor];
    
    //date conversion
    NSString *number = [[NSString alloc] initWithFormat:@"%ld", (long)message.sentAt];
    NSTimeInterval seconds = [number doubleValue];
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    NSLog (@"Epoch time %ld equates to UTC %@", (long)message.sentAt, epochNSDate);
    // (Step 2) Use NSDateFormatter to display epochNSDate in local time zone
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:a"];
    NSLog (@"Epoch time %@ equates to %@", number, [dateFormatter stringFromDate:epochNSDate]);

    // (Just for interest) Display your current time zone
    NSString *currentTimeZone = [[dateFormatter timeZone] abbreviation];
    NSLog (@"(Your local time zone is: %@)", currentTimeZone);
    cell.lbl_time.text = @"";
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        
        [DownloadManager link:link completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (data) {
                UIImage* image = [[UIImage alloc] initWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (cell.imgView_avatar.tag == indexPath.row) {
                            cell.imgView_avatar.image = image;
                        }
                    });
                }
            }
        }];
    });
    
    return cell;
}

@end
