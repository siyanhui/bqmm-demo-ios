//
//  MMChatViewGifCell.m
//  IMDemo
//
//  Created by Tender on 2017/12/18.
//  Copyright © 2017年 siyanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MMChatViewGifCell.h"
#import "UIImageView+WebCache.h"

@implementation MMChatViewGifCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setView];
    }
    
    return self;
}

- (void)setView {
    [super setView];
    _pictureView = [[MMImageView alloc] initWithFrame:CGRectZero];
//    _pictureView.layer.cornerRadius = 2.0f;
    _pictureView.layer.masksToBounds = YES;
    _pictureView.contentMode = UIViewContentModeScaleAspectFit;
    [self.messageView addSubview:_pictureView];
    
    self.messageBubbleView.hidden = true;
}

- (void)set:(ChatMessage *)messageData {
    [super set:messageData];
    
    self.pictureView.image = [UIImage imageNamed:@"mm_emoji_loading"];
    //Integrate BQMM
    NSDictionary *extDic = messageData.messageExtraInfo;
    if (extDic != nil && [extDic[TEXT_MESG_TYPE] isEqualToString:TEXT_MESG_WEB_TYPE]) {
        self.pictureView.image = [UIImage imageNamed:@"mm_emoji_loading"];
        self.pictureView.errorImage = [UIImage imageNamed:@"mm_emoji_error"];
        NSDictionary *msgData = extDic[TEXT_MESG_DATA];
        NSString *webStickerUrl = msgData[WEBSTICKER_URL];
        NSString *webStickerId = msgData[WEBSTICKER_ID];
        [self.pictureView setImageWithUrl:webStickerUrl gifId:webStickerId];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize messageSize = self.messageView.frame.size;
    CGSize size = CGSizeMake(120, 120);
    NSDictionary *extDic = self.messageModel.messageExtraInfo;
    NSDictionary *msgData = extDic[TEXT_MESG_DATA];
    float scale = [UIScreen mainScreen].scale;
    float height = [msgData[WEBSTICKER_HEIGHT] floatValue] / scale;
    float width = [msgData[WEBSTICKER_WIDTH] floatValue] / scale;
    
    //宽最大200 高最大 150
    size = [MMImageView sizeForImageSize:CGSizeMake(width, height) imgMaxSize:CGSizeMake(200, 150)];
    
    self.pictureView.frame = CGRectMake(messageSize.width - size.width - CONTENT_RIGHT_MARGIN, (messageSize.height - size.height) / 2, size.width, size.height);
}

-(void)prepareForReuse {
    [super prepareForReuse];
    _pictureView.image = nil;
}



@end
