//
//  MMChatViewController.m
//  IMDemo
//
//  Created by isan on 16/4/21.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import "MMChatViewController.h"
#import "MMChatViewTextCell.h"
#import "MMChatViewImageCell.h"
#import "MMChatViewGifCell.h"
#import "ChatMessage.h"
//Integrate BQMM
#import "MMTextView.h"
#import <BQMM/BQMM.h>
#import "MMTextParser.h"
#import "MMGifManager.h"

@interface MMChatViewController (){
    NSMutableArray *_messagesArray;
    ChatMessage *_longPressSelectedModel;
    UIMenuController *_menuController;
    BOOL _isFirstLayOut;
}

@end

@implementation MMChatViewController

- (void)viewWillAppear:(BOOL)animated {
    //menu
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidHide) name:UIMenuControllerWillHideMenuNotification object:nil];
    
    [MMEmotionCentre defaultCentre].delegate = _inputToolBar; //set SDK delegate
//    [[MMEmotionCentre defaultCentre] shouldShowShotcutPopoverAboveView:_inputToolBar.emojiButton withInput:_inputToolBar.inputTextView];
    //BQMM集成   设置gif搜索相关
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

- (void)menuDidHide {
    [[UIMenuController sharedMenuController] setMenuItems:nil];
    _inputToolBar.inputTextView.disableActionMenu = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MMEmotionCentre defaultCentre].delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _isFirstLayOut = true;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyboard)]];
    _messagesTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _messagesTableView.backgroundColor = [UIColor whiteColor];
    _messagesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _messagesTableView.delegate = self;
    _messagesTableView.dataSource = self;
    _messagesTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    _messagesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    [self.view addSubview:_messagesTableView];
    
    _inputToolBar = [[MMInputToolBarView alloc] initWithFrame:CGRectZero];
    _inputToolBar.delegate = self;
    [self.view addSubview:_inputToolBar];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"表情商店" style:(UIBarButtonItemStylePlain) target:self action:@selector(openBqShop)];
    
    _messagesArray = [[NSMutableArray alloc] initWithCapacity:0];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if(_isFirstLayOut) {
        CGSize viewSize = self.view.frame.size;
        _inputToolBar.frame = CGRectMake(0, viewSize.height - INPUT_TOOL_BAR_HEIGHT, viewSize.width, INPUT_TOOL_BAR_HEIGHT);
        
        _messagesTableView.frame = CGRectMake(0, 0, viewSize.width, viewSize.height - INPUT_TOOL_BAR_HEIGHT);
        
        _isFirstLayOut = false;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self test];
}

- (void)layoutViewsWithKeyboardFrame:(CGRect)keyboardFrame {
    
    CGRect toolBarFrame = self.inputToolBar.frame;
    toolBarFrame.origin.y = keyboardFrame.origin.y - toolBarFrame.size.height;
    self.inputToolBar.frame = toolBarFrame;
    
    CGRect tableviewFrame = self.messagesTableView.frame;
    tableviewFrame.size.height = toolBarFrame.origin.y;
    self.messagesTableView.frame = tableviewFrame;
    
    [self scrollViewToBottom];
}

- (void)tapToDismissKeyboard {
    [[MMEmotionCentre defaultCentre] switchToDefaultKeyboard];
    _inputToolBar.emojiButton.selected = false;
    [self.view endEditing:true];
}

- (void)openBqShop {
    [[MMEmotionCentre defaultCentre] presentShopViewController];
}

- (void)scrollViewToBottom {
    NSUInteger finalRow = MAX(0, [self.messagesTableView numberOfRowsInSection:0] - 1);
    if (0 == finalRow) {
        return;
    }
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathForItem:finalRow inSection:0];
    [self.messagesTableView scrollToRowAtIndexPath:finalIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:true];
}
#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessage *message = (ChatMessage *)_messagesArray[indexPath.row];
    return [MMChatViewBaseCell cellHeightFor:message];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _messagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatMessage *message = (ChatMessage *)_messagesArray[indexPath.row];
    NSString *reuseId = @"";
    
    MMChatViewBaseCell *cell = nil;
    switch (message.messageType) {
        case MMMessageTypeText:
        {
            reuseId = @"textMessage";
            cell = (MMChatViewTextCell *)[tableView dequeueReusableCellWithIdentifier:reuseId];
            if(cell == nil) {
                cell = [[MMChatViewTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
            }
            
        }
            break;
            
        case MMMessageTypeBigEmoji:
        {
            reuseId = @"bigEmojiMessage";
            cell = (MMChatViewImageCell *)[tableView dequeueReusableCellWithIdentifier:reuseId];
            if(cell == nil) {
                cell = [[MMChatViewImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
            }
        }
            break;
        case MMMessageTypeGif:
        {
            reuseId = @"gifMessage";
            cell = (MMChatViewGifCell *)[tableView dequeueReusableCellWithIdentifier:reuseId];
            if(cell == nil) {
                cell = [[MMChatViewGifCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
            }
        }
            break;
    }
    
    cell.delegate = self;
    [cell set:message];
    return cell;
}
//Integrate BQMM
#pragma mark <MMInputToolBarViewDelegate>

- (void)didClickGifTab {
    //点击gif tab 后应该保证搜索模式是打开的 搜索UI是允许显示的
    [[MMGifManager defaultManager] setSearchModeEnabled:true withInputView:_inputToolBar.inputTextView];
    [[MMGifManager defaultManager] setSearchUiVisible:true withAttatchedView:_inputToolBar];
    [[MMGifManager defaultManager] showTrending];
}

- (void)keyboardWillShowWithFrame:(CGRect)keyboardFrame {
    [self layoutViewsWithKeyboardFrame:keyboardFrame];
}

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

- (void)toolbarHeightDidChangedTo:(CGFloat)height {
    CGRect tableViewFrame = _messagesTableView.frame;
    CGRect toolBarFrame = _inputToolBar.frame;
    
    toolBarFrame.origin.y = CGRectGetMaxY(_inputToolBar.frame) - height;
    toolBarFrame.size.height = height;
    tableViewFrame.size.height = toolBarFrame.origin.y;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _inputToolBar.frame = toolBarFrame;
        _messagesTableView.frame = tableViewFrame;
    } completion:^(BOOL finished) {
        
    }];
    [self scrollViewToBottom];
}

#pragma mark -- private
- (void)appendAndDisplayMessage:(ChatMessage *)message {
    if (!message) {
        return;
    }
    [_messagesArray addObject:message];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_messagesArray.count - 1 inSection:0];
    if ([self.messagesTableView numberOfRowsInSection:0] != _messagesArray.count - 1) {
        NSLog(@"Error, datasource and tableview are inconsistent!!");
        [self.messagesTableView reloadData];
        return;
    }
    [self.messagesTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self scrollViewToBottom];
}

//Integrate BQMM
#pragma mark RCMessageCellDelegate
- (void)didTapChatViewCell:(ChatMessage *)messageModel {
    if(messageModel.messageType == MMMessageTypeBigEmoji){
        
        NSDictionary *extDic = messageModel.messageExtraInfo;
        if (extDic != nil && [extDic[TEXT_MESG_TYPE] isEqualToString:TEXT_MESG_FACE_TYPE]) {
            UIViewController *emojiController = [[MMEmotionCentre defaultCentre] controllerForEmotionCode:extDic[TEXT_MESG_DATA][0][0]];
            [self.navigationController pushViewController:emojiController animated:YES];
        }
    }
}

- (void)didLongPressChatViewCell:(ChatMessage *)messageModel inView:(UIView *)view {
    _inputToolBar.inputTextView.disableActionMenu = YES;
    
    _longPressSelectedModel = messageModel;
    
    CGRect rect = [self.view convertRect:view.frame fromView:view.superview];
    
    _menuController = [UIMenuController sharedMenuController];
    UIMenuItem *copyItem = [[UIMenuItem alloc]
                            initWithTitle:@"Copy"
                            action:@selector(onCopyMessage)];
    [_menuController setMenuItems:nil];
    [_menuController setMenuItems:@[ copyItem ]];
    [_menuController setTargetRect:rect inView:self.view];
    [_menuController setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)onCopyMessage {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    if(_longPressSelectedModel.messageType == MMMessageTypeText) {
        if(_longPressSelectedModel.messageExtraInfo) {
            pasteboard.string = [MMTextParser stringWithExtData:_longPressSelectedModel.messageExtraInfo[TEXT_MESG_DATA]];
        }else{
            pasteboard.string = _longPressSelectedModel.messageContent;
        }
    }else{
        pasteboard.string = _longPressSelectedModel.messageContent;
    }
}

- (void)didTapPhoneNumberInMessageCell:(NSString *)phoneNumber {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (void)didTapUrlInMessageCell:(NSString *)url {
    NSURL *stringUrl = [[NSURL alloc] initWithString:url];
    [[UIApplication sharedApplication] openURL:stringUrl];
}
@end
