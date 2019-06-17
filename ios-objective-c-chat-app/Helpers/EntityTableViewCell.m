//
//  EntityTableViewCell.m
//  ios-objective-c-chat-app
//
//  Created by MacMini-03 on 10/06/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "EntityTableViewCell.h"

@implementation EntityTableViewCell

@synthesize nameLabel,detailLabel,iconView,blockedView,unreadCountBadge,unreadCountLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    iconView.layer.cornerRadius = 27.5f;
    iconView.clipsToBounds = true;
    unreadCountBadge.layer.cornerRadius = 12.5f;
    unreadCountBadge.clipsToBounds = true;
    [iconView.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [iconView.layer setBorderWidth: 2.0];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

-(void)bind:(AppEntity *)entity withIndexPath:(NSIndexPath*)indexPath
{
    
    NSString *link , * letter , *badgeCount;
    
    if ([entity isKindOfClass:User.class]) {
        
        User *person = (User *)entity;
        
        self.nameLabel.text = [person name];
        switch ([person status]) {
                
            case UserStatusOnline:
                
            {
                NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
                attachment.image = [UIImage imageNamed:@"user_online"];
                CGFloat imageOffsetY = -2.0;
                attachment.bounds = CGRectMake(5, imageOffsetY, attachment.image.size.width, attachment.image.size.height);
                
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                
                NSMutableAttributedString *online= [[NSMutableAttributedString alloc] initWithString:@"\tOnline"];
                
                NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
                
                [attributedString appendAttributedString:attachmentString];
                [attributedString appendAttributedString:online];
                
                self.detailLabel.attributedText = attributedString;
            }
                
                break;
            case UserStatusOffline:
                
            {
                NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
                attachment.image = [UIImage imageNamed:@"user_offline"];
                CGFloat imageOffsetY = -2.0;
                attachment.bounds = CGRectMake(5, imageOffsetY, attachment.image.size.width, attachment.image.size.height);
                
                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                
                NSMutableAttributedString *offline= [[NSMutableAttributedString alloc] initWithString:@"\tOffline"];
                
                NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
                
                [attributedString appendAttributedString:attachmentString];
                [attributedString appendAttributedString:offline];
                
                self.detailLabel.attributedText = attributedString;
            }
                break;
        }
        
        if ([person blockedByMe] == YES){
            [self.blockedView setHidden:NO];
        }else{
            [self.blockedView setHidden:YES];
        }
        
        [CometChatProRequests getUnreadCountForAllUsers:[person uid] onSuccess:^(NSDictionary * _Nonnull success) {
            NSLog(@"keasdsady: %@",[success objectForKey:[person uid]]);
             NSLog(@"keasdsady: %@",[success valueForKey:[person uid]]);
            
            if([success objectForKey:[person uid]]){
                NSString *count = [success objectForKey:[person uid]];
                NSLog(@"count: %@",count);
                dispatch_async(dispatch_get_main_queue(), ^(){
                    self.unreadCountLabel.text = [NSString stringWithFormat:@"%@",count];
                    [self.unreadCountBadge setHidden:NO];
                });
            }
        } andError:^(CometChatException * _Nonnull error) {
            
            NSLog(@"error: %@",error.debugDescription);
        }];
        
        
        letter = [NSString stringWithFormat:@"%@",[person name]];
        link = [NSString stringWithFormat:@"%@",[person avatar]];
    } else if ([entity isKindOfClass:Group.class]) {
        
        Group *group = (Group *)entity;
        self.nameLabel.text = [group name];
        letter = [NSString stringWithFormat:@"%@",[group name]];
        link = [NSString stringWithFormat:@"%@",[group icon]];
        self.detailLabel.text = [group groupDescription];
        
        [CometChatProRequests getUnreadCountForAllGroups:[group guid] onSuccess:^(NSDictionary * _Nonnull success) {
            
            if([success objectForKey:[group guid]]){
                NSString *count = [success objectForKey:[group guid]];
                NSLog(@"count: %@",count);
                dispatch_async(dispatch_get_main_queue(), ^(){
                    self.unreadCountLabel.text = [NSString stringWithFormat:@"%@",count];
                    [self.unreadCountBadge setHidden:NO];
                });
            }
        } andError:^(CometChatException * _Nonnull error) {
            
            NSLog(@"error: %@",error.debugDescription);
        }];
    }
    Avatar *avatar = [[Avatar alloc]initWithRect:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f) fullName:letter];
    [avatar setBackgroundColor:[UIColor grayColor]];
    self.iconView.image = [avatar imageRepresentation];
    self.tag = indexPath.row;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        
        [DownloadManager link:link completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (data) {
                UIImage* image = [[UIImage alloc] initWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (self.tag == indexPath.row) {
                            self.iconView.image = image;
                        }
                    });
                }
            }
        }];
    });
}

@end
