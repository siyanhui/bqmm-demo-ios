# 帮助说明
Demo中集成BQMM关键处添加有“Integrate BQMM”注释，可在项目中全局搜索查看。

# 表情云SDK接入文档

接入**SDK**，有以下必要步骤：

1. 下载与安装
2. 获取必要的接入信息  
3. 开始集成  

##第一步：下载与安装

目前有两种方式安装SDK：

* 通过`CocoaPods`管理依赖。
* 手动导入`SDK`并管理依赖。

###1. 使用 CocoaPods 导入SDK

在终端中运行以下命令：

```
pod search BQMM
```

如果运行以上命令，没有搜到SDK，或者搜不到最新的 SDK 版本，您可以运行以下命令，更新您本地的 CocoaPods 源列表。

```
pod repo update
```

在您工程的 Podfile中添加最新版本的SDK（在此以2.1版本为例）：

```
pod 'BQMM', '2.1'
```

然后在工程的根目录下运行以下命令：

```
pod install
```

说明：pod中不包含gif表情的UI模块，可在官网[下载](http://7xl6jm.com2.z0.glb.qiniucdn.com/release/android-sdk/BQMM_Lib_V2.0.zip)，手动导入`BQMM_GIF`


###2. 手动导入SDK

下载当前最新版本，解压缩后获得3个文件夹

* `BQMM`
* `BQMM_EXT`
* `BQMM_GIF`

`BQMM`中包含SDK所需的资源文件`BQMM.bundle`和库文件`BQMM.framework`;`BQMM_EXT`提供了SDK的默认消息显示控件和消息默认格式的开源代码，开发者们导入后可按需修改;`BQMM_GIF`中包含gif表情的UI模块，开发者导入后可按需修改。

###3. 添加系统库依赖

您除了在工程中导入 SDK 之外，还需要添加libz动态链接库。


##第二步：获取必要的接入信息

开发者将应用与SDK进行对接时,必要接入信息如下

* `appId` - 应用的App ID
* `appSecret` - 应用的App Secret


如您暂未获得以上接入信息，可以在此[申请](http://open.biaoqingmm.com/open/register/index.html)


##第三步：开始集成

###0. 注册AppId&AppSecret、设置SDK语言和区域

在 `AppDelegate` 的 `-application:didFinishLaunchingWithOptions:` 中添加：

```objectivec
// 初始化SDK
[[MMEmotionCentre defaultCentre] setAppId:@“your app id” secret:@“your secret”]

//设置SDK语言和区域
[MMEmotionCentre defaultCentre].sdkLanguage = MMLanguageEnglish;
[MMEmotionCentre defaultCentre].sdkRegion = MMRegionChina;

```

###1. 在App重新打开时清空session

在 `AppDelegate` 的 `- (void)applicationWillEnterForeground:` 中添加：

```objectivec
[[MMEmotionCentre defaultCentre] clearSession];
```

###2. 使用表情键盘和GIF搜索模块

####设置SDK代理 

`MMChatViewController.m`
```objectivec
- (void)viewWillAppear:(BOOL)animated {
    ....
    //BQMM集成
    [MMEmotionCentre defaultCentre].delegate = self;
    ....
}
```

####配置GIF搜索模块

`MMChatViewController.m`
```objectivec
- (void)viewWillAppear:(BOOL)animated {
    ....
    //Integrate BQMM   设置gif搜索相关
    [[MMGifManager defaultManager] setSearchModeEnabled:true withInputView:_inputToolBar.inputTextView];
    [[MMGifManager defaultManager] setSearchUiVisible:true withAttatchedView:_inputToolBar];
    __weak MMChatViewController* weakSelf = self;
    [MMGifManager defaultManager].selectedHandler = ^(MMGif * _Nullable gif) {
        __strong MMChatViewController *tempSelf = weakSelf;
        if(tempSelf) {
            tempSelf.inputToolBar.inputTextView.text = nil;
            [tempSelf didSendGifMessage:gif];
        }
    };
}

-(void)didSendGifMessage:(MMGif *)gif {
    NSString *sendStr = [@"[" stringByAppendingFormat:@"%@]", gif.text];
    NSDictionary *msgData = @{WEBSTICKER_URL: gif.mainImage, WEBSTICKER_IS_GIF: (gif.isAnimated ? @"1" : @"0"), WEBSTICKER_ID: gif.imageId,WEBSTICKER_WIDTH: @((float)gif.size.width), WEBSTICKER_HEIGHT: @((float)gif.size.height)};
    NSDictionary *extDic = @{TEXT_MESG_TYPE:TEXT_MESG_WEB_TYPE,
                             TEXT_MESG_DATA:msgData
                             };
    
    ChatMessage *message = [[ChatMessage alloc] initWithMessageType:MMMessageTypeGif messageContent:sendStr messageExtraInfo:extDic];
    [self appendAndDisplayMessage:message];
}
```

####实现SDK代理方法

`MMInputToolBarView.m` 实现了SDK的代理方法
```objectivec
//点击表情键盘上的gif tab
- (void)didClickGifTab {
    self.emojiButton.selected = NO;
    if ([self.delegate respondsToSelector:@selector(didClickGifTab)]) {
        [self.delegate didClickGifTab];
    }
}

//点击键盘中大表情的代理
- (void)didSelectEmoji:(MMEmoji *)emoji
{
    if ([self.delegate respondsToSelector:@selector(didSendMMFace:)]) {
        [self.delegate didSendMMFace:emoji];
    }
}

//点击联想表情的代理 （`deprecated`）
- (void)didSelectTipEmoji:(MMEmoji *)emoji
{
    if ([self.delegate respondsToSelector:@selector(didSendMMFace:)]) {
        [self.delegate didSendMMFace:emoji];
        self.inputTextView.text = @"";
    }
}

//点击小表情键盘上发送按钮的代理
- (void)didSendWithInput:(UIResponder<UITextInput> *)input
{
    [self didSendTextMessage];
}

//点击输入框切换表情按钮状态
- (void)tapOverlay
{
    self.emojiButton.selected = false;
    [[MMEmotionCentre defaultCentre] switchToDefaultKeyboard];
}

```

`MMInputToolBarView` 通过代理将发送大表情及点击gif按钮代理给`MMChatViewController`
```objectivec
//BQMM集成
- (void)didClickGifTab;

//Integrate BQMM
/*!
 the delegate method handles the click of `return` key in keyboard
 
 @param inputView    UITextView
 */
- (void)didTouchKeyboardReturnKey:(UITextView *)inputView;

/**
 *  the delegate method handles send big emoji message
 *
 *  @param emoji MMemoji object
 */
- (void)didSendMMFace:(MMEmoji *)emoji;
```

`MMChatViewController`
```objectivec
- (void)didClickGifTab {
    //点击gif tab 后应该保证搜索模式是打开的 搜索UI是允许显示的
    [[MMGifManager defaultManager] setSearchModeEnabled:true withInputView:_inputToolBar.inputTextView];
    [[MMGifManager defaultManager] setSearchUiVisible:true withAttatchedView:_inputToolBar];
    [[MMGifManager defaultManager] showTrending];
}

-(void)didSendGifMessage:(MMGif *)gif {
    NSString *sendStr = [@"[" stringByAppendingFormat:@"%@]", gif.text];
    NSDictionary *msgData = @{WEBSTICKER_URL: gif.mainImage, WEBSTICKER_IS_GIF: (gif.isAnimated ? @"1" : @"0"), WEBSTICKER_ID: gif.imageId,WEBSTICKER_WIDTH: @((float)gif.size.width), WEBSTICKER_HEIGHT: @((float)gif.size.height)};
    NSDictionary *extDic = @{TEXT_MESG_TYPE:TEXT_MESG_WEB_TYPE,
                             TEXT_MESG_DATA:msgData
                             };
    
    ChatMessage *message = [[ChatMessage alloc] initWithMessageType:MMMessageTypeGif messageContent:sendStr messageExtraInfo:extDic];
    [self appendAndDisplayMessage:message];
}

- (void)didSendMMFace:(MMEmoji *)emoji {
    NSString *sendStr = [@"[" stringByAppendingFormat:@"%@]", emoji.emojiName];
    NSDictionary *extDic = @{TEXT_MESG_TYPE:TEXT_MESG_FACE_TYPE,
                             TEXT_MESG_DATA:[MMTextParser extDataWithEmoji:emoji]};
    ChatMessage *message = [[ChatMessage alloc] initWithMessageType:MMMessageTypeBigEmoji messageContent:sendStr messageExtraInfo:extDic];
    [self appendAndDisplayMessage:message];
}

- (void)didTouchKeyboardReturnKey:(UITextView *)inputView {
    
    NSArray *textImgArray = inputView.textImgArray;
    NSDictionary *extDic = @{TEXT_MESG_TYPE:TEXT_MESG_EMOJI_TYPE,
                             TEXT_MESG_DATA:[MMTextParser extDataWithTextImageArray:textImgArray]};;
    ChatMessage *message = [[ChatMessage alloc] initWithMessageType:MMMessageTypeText messageContent:inputView.characterMMText messageExtraInfo:extDic];
    [self appendAndDisplayMessage:message];
}
```

####表情键盘和普通键盘的切换

`MMChatViewController`

```objectivec
- (void)didTouchEmojiButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        //attatch emoji keyboard
        [[MMEmotionCentre defaultCentre] attachEmotionKeyboardToInput:_inputToolBar.inputTextView];
        
    }else{
        [[MMEmotionCentre defaultCentre] switchToDefaultKeyboard];
    }
    [_inputToolBar.inputTextView becomeFirstResponder];
}
```


###3. 使用表情消息编辑控件
SDK提供`UITextView+BQMM`作为表情编辑控件的扩展实现，可以以图文混排方式编辑，并提取编辑内容。
消息编辑框需要使用此控件，在适当位置引入头文件 

```objectivec
#import <BQMM/BQMM.h>
```

###4.消息的编码及发送

表情相关的消息需要编码成`extData`放入IM的普通文字消息的扩展字段，发送到接收方进行解析。
`extData`是SDK推荐的用于解析的表情消息发送格式，格式是一个二维数组，内容为拆分完成的`text`和`emojiCode`，并且说明这段内容是否是一个`emojiCode`。

#####图文混排消息
`MMInputToolBarView`
```objectivec
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self didSendTextMessage];
        return NO;
    }
    return YES;
}

- (void)didSendTextMessage {
    NSString *Text = [self.inputTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([Text isEqualToString:@""]) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(didTouchKeyboardReturnKey:)]) {
        [self.delegate didTouchKeyboardReturnKey:self.inputTextView];
    }
    self.inputTextView.text = @"";
    _inputTextViewHeight = TEXTVIEW_MIN_HEIGHT;
    [self relayout];
}
```

`MMChatViewController`
```objectivec
- (void)didTouchKeyboardReturnKey:(UITextView *)inputView {
    
    NSArray *textImgArray = inputView.textImgArray;
    NSDictionary *extDic = @{TEXT_MESG_TYPE:TEXT_MESG_EMOJI_TYPE,
                             TEXT_MESG_DATA:[MMTextParser extDataWithTextImageArray:textImgArray]};;
    ChatMessage *message = [[ChatMessage alloc] initWithMessageType:MMMessageTypeText messageContent:inputView.characterMMText messageExtraInfo:extDic];
    [self appendAndDisplayMessage:message];
}

```

#####大表情消息

`MMChatViewController`
```objectivec
- (void)didSendMMFace:(MMEmoji *)emoji {
    NSString *sendStr = [@"[" stringByAppendingFormat:@"%@]", emoji.emojiName];
    NSDictionary *extDic = @{TEXT_MESG_TYPE:TEXT_MESG_FACE_TYPE,
                             TEXT_MESG_DATA:[MMTextParser extDataWithEmoji:emoji]};
    ChatMessage *message = [[ChatMessage alloc] initWithMessageType:MMMessageTypeBigEmoji messageContent:sendStr messageExtraInfo:extDic];
    [self appendAndDisplayMessage:message];
}
```

#####Gif表情消息

`MMChatViewController`
```objectivec
-(void)didSendGifMessage:(MMGif *)gif {
    NSString *sendStr = [@"[" stringByAppendingFormat:@"%@]", gif.text];
    NSDictionary *msgData = @{WEBSTICKER_URL: gif.mainImage, WEBSTICKER_IS_GIF: (gif.isAnimated ? @"1" : @"0"), WEBSTICKER_ID: gif.imageId,WEBSTICKER_WIDTH: @((float)gif.size.width), WEBSTICKER_HEIGHT: @((float)gif.size.height)};
    NSDictionary *extDic = @{TEXT_MESG_TYPE:TEXT_MESG_WEB_TYPE,
                             TEXT_MESG_DATA:msgData
                             };
    
    ChatMessage *message = [[ChatMessage alloc] initWithMessageType:MMMessageTypeGif messageContent:sendStr messageExtraInfo:extDic];
    [self appendAndDisplayMessage:message];
}
```

Gif表情消息扩展解析出的图片尺寸存储在gifSize中，用于显示时布局。
`EaseMessageModel` 、 `IMessageModel`
```objectivec
@property (nonatomic) CGSize gifSize;
```

###5. 表情消息的解析

`ChatMessage`
```objectivec
- (id)initWithMessageType:(MMMessageType)messageType messageContent:(NSString *)messageContent messageExtraInfo:(NSDictionary *)messageExtraInfo {
    
    self = [super init];
    if (self) {
        self.messageType = messageType;
        self.messageContent = messageContent;
        self.messageExtraInfo = messageExtraInfo;
    }
    
    return self;
}
```

#### 混排消息的解析及显示
从消息的扩展中解析出`extData`
```objectivec
NSDictionary *extDic = messageModel.ext;
if (extDic != nil && [extDic[@"txt_msgType"] isEqualToString:@"emojitype"]) {
    NSArray *extData = extDic[@"msg_data"];
}
```

`MMChatViewTextCell`
```objectivec
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
```

#### 单个大表情解析及显示

从消息的扩展中解析出大表情（MMEmoji）的emojiCode

`MMChatViewImageCell`
```objectivec
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
    self.pictureView.frame = CGRectMake(messageSize.width - size.width - CONTENT_RIGHT_MARGIN, (messageSize.height - size.height) / 2, size.width, size.height);
}
```

#### Gif表情解析及显示

从消息的扩展中解析出Gif表情（MMGif）的imageId和mainImage

`MMChatViewGifCell`
```objectivec
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
    if (width > 200) {
        height = 200.0 / width * height;
        width = 200;
    }
    size = CGSizeMake(width, height);
    self.pictureView.frame = CGRectMake(messageSize.width - size.width - CONTENT_RIGHT_MARGIN, (messageSize.height - size.height) / 2, size.width, size.height);
}
```

###6. gif搜索模块UI定制

`BQMM_GIF`是一整套gif搜索UI模块的实现源码，可用于直接使用或用于参考实现gif搜索，及gif消息的发送解析。
####gif搜索源码说明
gif相关的功能由`MMGifManager`集中管理:

1.设置搜索模式的开启和关闭；指定输入控件
```objectivec
- (void)setSearchModeEnabled:(BOOL)enabled withInputView:(UIResponder<UITextInput> *_Nullable)input;
```

2.设置是否显示搜索出的表情内容；指定表情内容的显示位置
```objectivec
- (void)setSearchUiVisible:(BOOL)visible withAttatchedView:(UIView *_Nullable)attachedView;
```

3.通过`MMSearchModeStatus`管理搜索模式的开启和关闭及搜索内容的展示和收起（MMSearchModeStatus可自由调整）
```objectivec
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
- (void)updateSearchModeAndSearchUIWithStatus:(MMSearchModeStatus)status;
```

###7. UI定制

 SDK通过`MMTheme`提供一定程度的UI定制。具体参考类说明[MMTheme](../class_reference/README.md)。

创建一个`MMTheme`对象，设置相关属性， 然后[[MMEmotionCentre defaultCentre] setTheme:]即可修改商店和键盘样式。


###8. 清除缓存

调用`clearCache`方法清除缓存，此操作会删除所有临时的表情缓存，已下载的表情包不会被删除。建议在`- (void)applicationWillTerminate:(UIApplication *)application `方法中调用。

###9. 设置APP UserId

开发者可以用`setUserId`方法设置App UserId，以便在后台统计时跟踪追溯单个用户的表情使用情况。
