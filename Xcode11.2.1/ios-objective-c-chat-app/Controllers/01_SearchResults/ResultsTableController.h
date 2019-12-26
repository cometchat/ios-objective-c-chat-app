//
//  ResultsTableController.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 28/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ResultViewDelegate <NSObject>
- (void)RowAtIndexPath:(AppEntity*)appEntity;
@end
@interface ResultsTableController : UITableViewController
@property (nonatomic, strong) NSArray<AppEntity*> *SectionOneListItems;
@property (nonatomic, weak) id<ResultViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
