//
//  MMWebPicManager.h
//  StampMeSDK
//
//  Created by isan on 21/11/2017.
//  Copyright © 2017 siyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BQMM/BQMM.h>


#define TEXT_MESG_TYPE @"txt_msgType"  //key for text message
#define TEXT_MESG_FACE_TYPE @"facetype" //key for big emoji type
#define TEXT_MESG_EMOJI_TYPE @"emojitype" //key for photo-text message
#define TEXT_MESG_WEB_TYPE @"webtype" //key for web sticker message
#define TEXT_MESG_DATA @"msg_data"  //key for ext data of message

#define WEBSTICKER_IS_GIF @"is_gif"  //key for web sticker is gif or not
#define WEBSTICKER_ID @"data_id"  //key for web sticker id
#define WEBSTICKER_URL @"sticker_url"  //key for web sticker url
#define WEBSTICKER_HEIGHT @"h"  //key for web sticker height
#define WEBSTICKER_WIDTH @"w"  //key for web sticker width

typedef NS_OPTIONS (NSInteger, MMSearchModeStatus) {
    MMSearchModeStatusKeyboardHide = 1 << 0,         //收起键盘
    MMSearchModeStatusInputEndEditing = 1 << 1,         //收起键盘
    MMSearchModeStatusInputBecomeEmpty = 1 << 2,     //输入框清空
    MMSearchModeStatusInputTextChange = 1 << 3,      //输入框内容变化
    MMSearchModeStatusGifMessageSent = 1 << 4,       //发送了gif消息
    MMSearchModeStatusShowTrendingTriggered = 1 << 5,//触发流行表情
    MMSearchModeStatusGifsDataReceivedWithResult = 1 << 6,     //收到gif数据
    MMSearchModeStatusGifsDataReceivedWithEmptyResult = 1 << 7,     //搜索结果为空
};

typedef void (^MMGifSelectedHandler)(MMGif * _Nullable gif); //搜索表情点击的handler

@interface MMGifManager : NSObject
@property (nonatomic, copy) MMGifSelectedHandler _Nullable selectedHandler;

+ (nonnull instancetype)defaultManager;

//搜索模式设置
- (void)setSearchModeEnabled:(BOOL)enabled withInputView:(UIResponder<UITextInput> *_Nullable)input;
- (void)setSearchUiVisible:(BOOL)visible withAttatchedView:(UIView *_Nullable)attachedView;
- (void)showTrending;
@end
