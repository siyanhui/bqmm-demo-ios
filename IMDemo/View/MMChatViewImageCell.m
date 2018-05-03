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
    _pictureView = [[MMImageView alloc] initWithFrame:CGRectZero];
//    _pictureView.layer.cornerRadius = 2.0f;
    _pictureView.layer.masksToBounds = YES;
    [self.messageView addSubview:_pictureView];
    
    self.messageBubbleView.hidden = true;
}

- (void)set:(ChatMessage *)messageData {
    [super set:messageData];
    
    self.pictureView.image = [UIImage imageNamed:@"mm_emoji_loading"];
    //Integrate BQMM
    NSDictionary *extDic = messageData.messageExtraInfo;
    if (extDic != nil && [extDic[TEXT_MESG_TYPE] isEqualToString:TEXT_MESG_FACE_TYPE]) {
        NSString *emojiCode = nil;
        if (extDic[TEXT_MESG_DATA]) {
            emojiCode = extDic[TEXT_MESG_DATA][0][0];
        }
        
        if (emojiCode != nil && emojiCode.length > 0) {
            self.pictureView.errorImage = [UIImage imageNamed:@"mm_emoji_error"];
            self.pictureView.image = [UIImage imageNamed:@"mm_emoji_loading"];
            [self.pictureView setImageWithEmojiCode:emojiCode];
        }else {
            self.pictureView.image = [UIImage imageNamed:@"mm_emoji_error"];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize messageSize = self.messageView.frame.size;
    CGSize size = CGSizeMake(120, 120);
    size = [MMImageView sizeForImageSize:size imgMaxSize:size];
    self.pictureView.frame = CGRectMake(messageSize.width - size.width - CONTENT_RIGHT_MARGIN, (messageSize.height - size.height) / 2, size.width, size.height);
}

-(void)prepareForReuse {
    [super prepareForReuse];
    _pictureView.image = nil;
}



@end
