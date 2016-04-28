//
//  MMMessage.h
//  IMDemo
//
//  Created by isan on 16/4/21.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TEXT_MESG_TYPE            @"txt_msgType"  //文字消息类型key的名称
#define TEXT_MESG_FACE_TYPE       @"facetype" //大表情消息类型
#define TEXT_MESG_EMOJI_TYPE      @"emojitype" //图文混排消息类型
#define TEXT_MESG_DATA            @"msg_data"  //文字消息扩展内容

typedef NS_ENUM(NSUInteger, MMMessageType) {
    /*!
     文字消息
     */
    MMMessageTypeText = 1,
    
    /*!
     大表情消息
     */
    MMMessageTypeBigEmoji = 2,
    
};

@interface MMMessage : NSObject

@property(nonatomic, assign) MMMessageType messageType;

/**
 *  消息文字内容
 */
@property(nonatomic, strong) NSString *messageContent;
/**
 *  消息扩展信息
 */
@property(nonatomic, strong) NSDictionary *messageExtraInfo;


/**
 *  初始化消息Model
 *
 *  @param messageType      消息类型
 *  @param messageContent   消息文字内容
 *  @param messageExtraInfo 消息的扩展信息
 *
 *  @return 消息Model
 */
- (id)initWithMessageType:(MMMessageType)messageType messageContent:(NSString *)messageContent messageExtraInfo:(NSDictionary *)messageExtraInfo;


@end