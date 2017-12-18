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
    _pictureView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _pictureView.layer.cornerRadius = 2.0f;
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
        NSDictionary *msgData = extDic[TEXT_MESG_DATA];
        NSURL * url = [[NSURL alloc] initWithString:msgData[WEBSTICKER_URL]];
        if (url != nil) {
            __weak typeof(self) weakSelf = self;
            [self.pictureView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(error == nil && image) {
                    if (image.images.count > 1) {
                        weakSelf.pictureView.animationImages = image.images;
                        weakSelf.pictureView.image = image.images[0];
                        weakSelf.pictureView.animationDuration = image.duration;
                        [weakSelf.pictureView startAnimating];
                    }else{
                        weakSelf.pictureView.image = image;
                    }
                }else{
                    weakSelf.pictureView.image = [UIImage imageNamed:@"mm_emoji_error"];
                }
            }];
        }else {
            self.pictureView.image = [UIImage imageNamed:@"mm_emoji_error"];
        }
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
    if (width > 200) {
        height = 200.0 / width * height;
        width = 200;
    }
    size = CGSizeMake(width, height);
    self.pictureView.frame = CGRectMake(messageSize.width - size.width - CONTENT_RIGHT_MARGIN, (messageSize.height - size.height) / 2, size.width, size.height);
}

-(void)prepareForReuse {
    [super prepareForReuse];
    _pictureView.image = nil;
}



@end
