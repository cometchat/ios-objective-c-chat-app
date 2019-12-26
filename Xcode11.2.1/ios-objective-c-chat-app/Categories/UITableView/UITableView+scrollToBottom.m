//
//  UITableView+scrollToBottom.m
//  SparkChat
//
//  Created by Ins on 31/07/18.
//  Copyright © 2018 inscripts. All rights reserved.
//

#import "UITableView+scrollToBottom.h"

@implementation UITableView (scrollToBottom)
-(void)scrollToBottom{
    
    NSInteger cells_count = [self numberOfRowsInSection:0];
    NSIndexPath* ipath = [NSIndexPath indexPathForRow: cells_count-1 inSection:0];
    if (cells_count >= 1 ) {
        [self scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    }
}
@end
