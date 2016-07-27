//
//  MMChatViewTextCell.m
//  IMDemo
//
//  Created by isan on 16/4/21.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import "MMChatViewTextCell.h"

@implementation MMChatViewTextCell

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
    _textMessageView = [[MMTextView alloc] init];
    _textMessageView.backgroundColor = [UIColor clearColor];
    _textMessageView.textContainerInset = UIEdgeInsetsZero;
    _textMessageView.mmTextColor = [UIColor blackColor];
    _textMessageView.mmFont = [UIFont systemFontOfSize:TEXT_MESSAGEFONT_SIZE];
    _textMessageView.editable = false;
    _textMessageView.selectable = false;
    _textMessageView.scrollEnabled = false;
    _textMessageView.clickActionDelegate = self;
    [self.messageView addSubview:_textMessageView];
}

- (void)set:(ChatMessage *)messageData {
    //Integrate BQMM
    [super set:messageData];
    NSDictionary *extDic = messageData.messageExtraInfo;
    if(extDic) {
        [_textMessageView setMmTextData:extDic[TEXT_MESG_DATA]];
    }else{
        _textMessageView.text = messageData.messageContent;
        //search the content of MMtextView for URL and Phone number and set `link attribute` on them
        [_textMessageView setURLAttributes];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize messageSize = self.messageView.frame.size;
    CGSize size = CGSizeZero;
    //Integrate BQMM
    if(self.messageModel.messageExtraInfo != nil) {
        size = [MMTextParser sizeForMMTextWithExtData:self.messageModel.messageExtraInfo[TEXT_MESG_DATA] font:[UIFont systemFontOfSize:TEXT_MESSAGEFONT_SIZE] maximumTextWidth:BUBBLE_MAX_WIDTH - (CONTENT_RIGHT_MARGIN + CONTENT_LEFT_MARGIN)];
        
    }else{
        size = [MMTextParser sizeForTextWithText:self.messageModel.messageContent font:[UIFont systemFontOfSize:TEXT_MESSAGEFONT_SIZE] maximumTextWidth:BUBBLE_MAX_WIDTH - (CONTENT_RIGHT_MARGIN + CONTENT_LEFT_MARGIN)];
    }
    
    _textMessageView.frame = CGRectMake(messageSize.width - size.width - CONTENT_RIGHT_MARGIN, CONTENT_TOP_MARGIN, size.width, size.height);
}

-(void)prepareForReuse {
    [super prepareForReuse];
}

#pragma mark MMTextViewDelegate
- (void)mmTextView:(MMTextView *)textView didSelectLinkWithPhoneNumber:(NSString *)phoneNumber {
    NSString *number = [@"tel://" stringByAppendingString:phoneNumber];
    if ([self.delegate respondsToSelector:@selector(didTapPhoneNumberInMessageCell:)]) {
        [self.delegate didTapPhoneNumberInMessageCell:number];
        return;
    }
}

- (void)mmTextView:(MMTextView *)textView didSelectLinkWithURL:(NSURL *)url {
    NSString *urlString=[url absoluteString];
    if (![urlString hasPrefix:@"http"]) {
        urlString = [@"http://" stringByAppendingString:urlString];
    }
    if ([self.delegate respondsToSelector:@selector(didTapUrlInMessageCell:)]) {
        [self.delegate didTapUrlInMessageCell:urlString];
        return;
    }
}

@end
