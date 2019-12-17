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
@property (strong , nonatomic) AppEntity *entity;
@end

@implementation ConversationsViewController
{
    HexToRGBConvertor *hexToRGB;
    NSMutableArray *conversation;
    Conversation *convo;
    ConversationRequest *convoRequest;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    hexToRGB = [HexToRGBConvertor new];
    [self.view setBackgroundColor:[hexToRGB colorWithHexString:@"#2636BE"]];
    [self.navigationController.navigationBar setBarTintColor:[hexToRGB colorWithHexString:@"#2636BE"]];
    [self initializeSearchController];
    [self viewWillSetNavigationBar];
    
//    conversation = [[NSMutableArray alloc]initWithObjects:
//                 @"New Delhi",@"Mumbai",@"Hyderabad",
//                 @"Bangalore",@"Sydney",@"Melbourne",
//                 @"Brisbane",@"Perth",@"New York",
//                 @"Los Angeles",@"Chicago",@"Boston", nil];
    

    convoRequest = [[[[ConversationRequestBuilder alloc]initWithLimit:50]setConversationTypeWithConversationType:ConversationTypeNone]build];
    
}

//AppDelegate to Run the Delegate Methods
- (AppDelegate *)delegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

//View Will Appear used to set the delegate methods
- (void)viewWillAppear:(BOOL)animated{
    [self delegate].messagedelegate = self;
    [self fetchConversation];
    
}

//Fetching Conversations
- (void)fetchConversation{
    
    [convoRequest fetchNextOnSuccess:^(NSArray<Conversation *> * conversation) {
        if ([conversation count] != 0) {
            [self.contactListArray addObjectsFromArray:conversation];
            //self->_conversationListArray = conversation;
            [self refreshContactsList];
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
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        
    } else {
        // Fallback on earlier versions
    }
    
    self.navigationItem.title = NSLocalizedString(@"Conversations", @"");
    UIBarButtonItem *creategroupBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"group_create"] style:UIBarButtonItemStylePlain target:self action:@selector(showAlertSheet:)];
    
    [creategroupBtn setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItems:@[creategroupBtn]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:YES];
    
}

//Conversation Request Call




//TableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contactListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 75;
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
    NSLog(@"Value of convo is = %@", convoObj.stringValue);
    
    _contactListArray = _entity;
    //[cell.lbl_name setText:[conversation objectAtIndex:indexPath.row]];
    
//    switch (convoObj.conversationType)
//    {
//            case ConversationTypeUser:
//
//            //User *userObj = [(User *)convoObj.conversationWith];
//            //[cell.lbl_name setText:[[(User *)appEntity name]];
//            break;
//
//            case ConversationTypeGroup:
//
//              break;
//
//            case ConversationTypeNone:
//              break;
//    }
    
    if ([_entity isKindOfClass:User.class]) {
        
        User *person = (User *)_entity;
        
        cell.lbl_name.text = [person name];
        link = [NSString stringWithFormat:@"%@",[person avatar]];
    
    } else if ([_entity isKindOfClass:Group.class]) {
        
        Group *group = (Group *)_entity;
        cell.lbl_name.text = [group name];
    }
    
    cell.imgView_avatar.tag = indexPath.row;
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
