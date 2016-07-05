//
//  MMChatViewImageCell.m
//  IMDemo
//
//  Created by isan on 16/4/21.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import "MMChatViewImageCell.h"

@implementation MMChatViewImageCell

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
    [self.messageView addSubview:_pictureView];
    
    self.messageBubbleView.hidden = true;
}

- (void)set:(MMMessage *)messageData {
    [super set:messageData];
    
    self.pictureView.image = [UIImage imageNamed:@"mm_emoji_loading"];
    //Integrate BQMM
    NSDictionary *extDic = messageData.messageExtraInfo;
    if (extDic != nil && [extDic[TEXT_MESG_TYPE] isEqualToString:TEXT_MESG_FACE_TYPE]) {
        NSArray *codes = nil;
        if (extDic[TEXT_MESG_DATA]) {
            codes = @[extDic[TEXT_MESG_DATA][0][0]];
        }
        __weak typeof(self) weakself = self;
        [[MMEmotionCentre defaultCentre] fetchEmojisByType:MMFetchTypeBig codes:codes completionHandler:^(NSArray *emojis) {
            if (emojis.count > 0) {
                MMEmoji *emoji = emojis[0];
                if ([codes[0] isEqualToString:emoji.emojiCode]) {
                    weakself.pictureView.image = emoji.emojiImage;
                }
            }
            else {
                weakself.pictureView.image = [UIImage imageNamed:@"mm_emoji_error"];
            }
        }];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize messageSize = self.messageView.frame.size;
    CGSize size = CGSizeMake(120, 120);
    self.pictureView.frame = CGRectMake(messageSize.width - size.width - CONTENT_RIGHT_MARGIN, (messageSize.height - size.height) / 2, size.width, size.height);
}

-(void)prepareForReuse {
    [super prepareForReuse];
    _pictureView.image = nil;
}



@end
