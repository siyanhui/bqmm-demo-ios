//
//  MMChatViewBaseCell.m
//  IMDemo
//
//  Created by isan on 16/4/21.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import "MMChatViewBaseCell.h"

@implementation MMChatViewBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setView {
    
    _avatarView = [[UIImageView alloc] init];
    _avatarView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarView.backgroundColor = [UIColor grayColor];
    _avatarView.layer.cornerRadius = 4;
    _avatarView.image = [UIImage imageNamed:@"ic_avatar_holder"];
    _avatarView.clipsToBounds = true;
    [self.contentView addSubview:_avatarView];
    
    _messageView = [[UIView alloc] init];
    _messageView.backgroundColor = [UIColor clearColor];
    _messageView.clipsToBounds = true;
    [_messageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chatViewCellTaped)]];
    [_messageView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)]];
    
    
    [self.contentView addSubview:_messageView];
    
    _messageBubbleView = [[UIImageView alloc] init];
    _messageBubbleView.backgroundColor = [UIColor clearColor];
    _messageBubbleView.contentMode = UIViewContentModeScaleToFill;
    [_messageView addSubview:_messageBubbleView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize cellSize = self.contentView.frame.size;
    CGSize size = CGSizeMake(35, 35);
    _avatarView.frame = CGRectMake(cellSize.width - size.width - 15, 0, size.width, size.height);
    
    _messageView.frame = CGRectMake(CGRectGetMinX(_avatarView.frame) - 4 - _bubbleSize.width, 0, _bubbleSize.width, _bubbleSize.height);
    _messageBubbleView.frame = CGRectMake(0, 0, _bubbleSize.width, _bubbleSize.height);
}

- (void)set:(ChatMessage *)messageData {
    self.messageModel = messageData;
    
    UIImage *bubbleImage = [UIImage imageNamed:@"ic_bubble"];
    self.messageBubbleView.image = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 15, 10, 15) resizingMode:UIImageResizingModeStretch];
    
    _bubbleSize = [MMChatViewBaseCell bubbleSizeFor:messageData];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.bubbleSize = CGSizeMake(0, 0);
}

+ (CGFloat)cellHeightFor:(ChatMessage *)message {
    CGFloat height = 0;
    CGSize bubbleSize = [MMChatViewBaseCell bubbleSizeFor:message];
    height += bubbleSize.height + 20;
    return height;
}

+ (CGSize)bubbleSizeFor:(ChatMessage *)message {
    CGSize size;
    switch (message.messageType) {
        //Integrate BQMM
        case MMMessageTypeText:
            if(message.messageExtraInfo != nil) {
                size = [MMTextParser sizeForMMTextWithExtData:message.messageExtraInfo[TEXT_MESG_DATA] font:[UIFont systemFontOfSize:TEXT_MESSAGEFONT_SIZE] maximumTextWidth:BUBBLE_MAX_WIDTH - (CONTENT_RIGHT_MARGIN + CONTENT_LEFT_MARGIN)];

            }else{
                size = [MMTextParser sizeForTextWithText:message.messageContent font:[UIFont systemFontOfSize:TEXT_MESSAGEFONT_SIZE] maximumTextWidth:BUBBLE_MAX_WIDTH - (CONTENT_RIGHT_MARGIN + CONTENT_LEFT_MARGIN)];
            }
            break;
        case MMMessageTypeBigEmoji:
            size = CGSizeMake(120, 120);
            size = [MMImageView sizeForImageSize:size imgMaxSize:size];
            break;
        case MMMessageTypeGif:
        {
            NSDictionary *extDic = message.messageExtraInfo;
            NSDictionary *msgData = extDic[TEXT_MESG_DATA];
            float height = [msgData[WEBSTICKER_HEIGHT] floatValue];
            float width = [msgData[WEBSTICKER_WIDTH] floatValue];
            //宽最大200 高最大 150
            size = [MMImageView sizeForImageSize:CGSizeMake(width, height) imgMaxSize:CGSizeMake(200, 150)];
        }
            break;
    }
    size.width = size.width + CONTENT_RIGHT_MARGIN + CONTENT_LEFT_MARGIN;
    size.height = size.height + CONTENT_TOP_MARGIN + CONTENT_BOTTOM_MARGIN;
    return size;
}

#pragma mark -- user action
- (void)chatViewCellTaped {
    if([self.delegate respondsToSelector:@selector(didTapChatViewCell:)]){
        [self.delegate didTapChatViewCell:self.messageModel];
    }
}

- (void)longPressed:(id)sender {
    UILongPressGestureRecognizer *press = (UILongPressGestureRecognizer *)sender;
    if (press.state == UIGestureRecognizerStateBegan) {
        if([self.delegate respondsToSelector:@selector(didLongPressChatViewCell:inView:)]){
            [self.delegate didLongPressChatViewCell:self.messageModel inView:self.messageView];
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
