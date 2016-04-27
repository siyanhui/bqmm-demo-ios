//
//  MMChatViewController.h
//  IMDemo
//
//  Created by isan on 16/4/21.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMInputToolBarView.h"
#import "MMChatViewBaseCell.h"
#import "MMMessage.h"

@interface MMChatViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, RCMessageCellDelegate, MMInputToolBarViewDelegate>

@property(strong, nonatomic) UITableView *messagesTableView;
@property(strong, nonatomic) MMInputToolBarView *inputToolBar;

@end
