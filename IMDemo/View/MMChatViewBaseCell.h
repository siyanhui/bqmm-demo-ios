//
//  MMChatViewBaseCell.h
//  IMDemo
//
//  Created by isan on 16/4/21.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessage.h"
//Integrate BQMM
#import <BQMM/BQMM.h>
#import "MMTextParser.h"

#define BUBBLE_MAX_WIDTH ([[UIScreen mainScreen] bounds].size.width * 0.65)
#define TEXT_MESSAGEFONT_SIZE 17
#define CONTENT_TOP_MARGIN 6
#define CONTENT_BOTTOM_MARGIN 6
#define CONTENT_LEFT_MARGIN 6
#define CONTENT_RIGHT_MARGIN 14

@protocol RCMessageCellDelegate;

@interface MMChatViewBaseCell : UITableViewCell

@property(strong, nonatomic) UIImageView *avatarView;
@property(strong, nonatomic) UIView *messageView;
@property(strong, nonatomic) UIImageView *messageBubbleView;

@property(strong, nonatomic) ChatMessage *messageModel;
@property(nonatomic) CGSize bubbleSize;

@property(nonatomic, weak) id<RCMessageCellDelegate> delegate;

- (void)setView;
- (void)set:(ChatMessage *)messageData;
+ (CGFloat)cellHeightFor:(ChatMessage *)message;

@end

@protocol RCMessageCellDelegate <NSObject>

@optional

/*!
 the delegate method handles `tap` of message cell
 
 @param model message model
 */
- (void)didTapChatViewCell:(ChatMessage *)messageModel;

/**
 *  the delegate method handles `long press` of message cell
 *
 *  @param messageModel message model
 *  @param view         the view that holds the message
 */
- (void)didLongPressChatViewCell:(ChatMessage *)messageModel inView:(UIView *)view;

/**
 *  the delegate method handles `tap` of url in message cell
 *
 *  @param url   the url string
 */
- (void)didTapUrlInMessageCell:(NSString *)url;

/**
 *  the delegate method handles `tap` of phone number in message cell
 *
 *  @param phoneNumber    phone number
 */
- (void)didTapPhoneNumberInMessageCell:(NSString *) phoneNumber;
@end
