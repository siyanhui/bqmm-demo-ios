//
//  MMChatViewBaseCell.h
//  IMDemo
//
//  Created by isan on 16/4/21.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMMessage.h"
#import <BQMM/BQMM.h>
#import "MMTextParser+ExtData.h"

#define BUBBLE_MAX_WIDTH ([[UIScreen mainScreen] bounds].size.width * 0.65)
#define TEXT_MESSAGEFONT_SIZE 17
#define CONTENT_TOP_MARGIN 6
#define CONTENT_BOTTOM_MARGIN 6
#define CONTENT_LEFT_MARGIN 6
#define CONTENT_RIGHT_MARGIN 14

#define TEXT_MESG_TYPE @"txt_msgType"  //文字消息类型key的名称
#define TEXT_MESG_FACE_TYPE @"facetype" //大表情消息类型
#define TEXT_MESG_EMOJI_TYPE @"emojitype" //图文混排消息类型
#define TEXT_MESG_DATA @"msg_data"  //文字消息扩展内容

@protocol RCMessageCellDelegate;

@interface MMChatViewBaseCell : UITableViewCell

@property(strong, nonatomic) UIImageView *avatarView;
@property(strong, nonatomic) UIView *messageView;
@property(strong, nonatomic) UIImageView *messageBubbleView;

@property(strong, nonatomic) MMMessage *messageModel;
@property(nonatomic) CGSize bubbleSize;

@property(nonatomic, weak) id<RCMessageCellDelegate> delegate;

- (void)setView;
- (void)set:(MMMessage *)messageData;
+ (CGFloat)cellHeightFor:(MMMessage *)message;

@end

@protocol RCMessageCellDelegate <NSObject>

@optional

/*!
 点击Cell内容的回调
 
 @param model 消息Cell的数据模型
 */
- (void)didTapChatViewCell:(MMMessage *)messageModel;

/**
 *  长按Cell的回调
 *
 *  @param messageModel cell对应的消息model
 *  @param view         显示消息内容的view
 */
- (void)didLongPressChatViewCell:(MMMessage *)messageModel inView:(UIView *)view;

/**
 *  点击cell中的url回调
 *
 *  @param url 消息中包含的url字符窜
 */
- (void)didTapUrlInMessageCell:(NSString *)url;

/**
 *  点击消息中电话号码的回调
 *
 *  @param phoneNumber 电话号码
 */
- (void)didTapPhoneNumberInMessageCell:(NSString *) phoneNumber;
@end
