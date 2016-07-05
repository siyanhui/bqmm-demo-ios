//
//  MMChatViewTextCell.h
//  IMDemo
//
//  Created by isan on 16/4/21.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import "MMChatViewBaseCell.h"
//Integrate BQMM
#import "MMTextView.h"

@interface MMChatViewTextCell : MMChatViewBaseCell<MMTextViewDelegate>

@property(strong, nonatomic) MMTextView *textMessageView;

@end
