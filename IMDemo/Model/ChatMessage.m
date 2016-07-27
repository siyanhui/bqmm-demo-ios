//
//  MMMessage.m
//  IMDemo
//
//  Created by isan on 16/4/21.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import "ChatMessage.h"

@implementation ChatMessage

- (id)initWithMessageType:(MMMessageType)messageType messageContent:(NSString *)messageContent messageExtraInfo:(NSDictionary *)messageExtraInfo {
    
    self = [super init];
    if (self) {
        self.messageType = messageType;
        self.messageContent = messageContent;
        self.messageExtraInfo = messageExtraInfo;
    }
    
    return self;
}

@end
