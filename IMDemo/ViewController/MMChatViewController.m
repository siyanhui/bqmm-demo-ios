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
#import "MMMessage.h"

#import "MMTextView.h"
#import <BQMM/BQMM.h>
#import "MMTextParser+ExtData.h"

@interface MMChatViewController (){
    NSMutableArray *_messagesArray;
    MMMessage *_longPressSelectedModel;
    UIMenuController *_menuController;
    BOOL _isFirstLayOut;
}

@end

@implementation MMChatViewController

- (void)viewWillAppear:(BOOL)animated {
    //menu
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidHide) name:UIMenuControllerWillHideMenuNotification object:nil];
    
    [MMEmotionCentre defaultCentre].delegate = _inputToolBar; //设置BQMM键盘delegate
    [[MMEmotionCentre defaultCentre] shouldShowShotcutPopoverAboveView:_inputToolBar.emojiButton withInput:_inputToolBar.inputTextView];
}

- (void)menuDidHide {
    [[UIMenuController sharedMenuController] setMenuItems:nil];
    _inputToolBar.inputTextView.disableActionMenu = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
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

- (void)scrollViewToBottom {
    if(self.messagesTableView.contentSize.height > self.messagesTableView.frame.size.height) {
        CGPoint offSet = CGPointMake(0, self.messagesTableView.contentSize.height - self.messagesTableView.frame.size.height);
        [self.messagesTableView setContentOffset:offSet animated:true];
    }
}
#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMMessage *message = (MMMessage *)_messagesArray[indexPath.row];
    return [MMChatViewBaseCell cellHeightFor:message];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _messagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MMMessage *message = (MMMessage *)_messagesArray[indexPath.row];
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
    }
    
    cell.delegate = self;
    [cell set:message];
    return cell;
}

#pragma mark <MMInputToolBarViewDelegate>
- (void)keyboardWillShowWithFrame:(CGRect)keyboardFrame {
    [self layoutViewsWithKeyboardFrame:keyboardFrame];
}

- (void)didTouchEmojiButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    [_inputToolBar.inputTextView becomeFirstResponder];
    if (sender.selected) {
        //attatch 表情mm键盘
        [[MMEmotionCentre defaultCentre] attachEmotionKeyboardToInput:_inputToolBar.inputTextView];
    }else{
        [[MMEmotionCentre defaultCentre] switchToDefaultKeyboard];
    }
}

- (void)didSendMMFace:(MMEmoji *)emoji {
    NSString *sendStr = [@"[" stringByAppendingFormat:@"%@]", emoji.emojiName];
    NSDictionary *extDic = @{TEXT_MESG_TYPE:TEXT_MESG_FACE_TYPE,
                          TEXT_MESG_DATA:[MMTextParser extDataWithEmojiCode:emoji.emojiCode]};
    MMMessage *message = [[MMMessage alloc] initWithMessageType:MMMessageTypeBigEmoji messageContent:sendStr messageExtraInfo:extDic];
    [_messagesArray addObject:message];
    [self.messagesTableView reloadData];
    [self scrollViewToBottom];
}

- (void)didTouchKeyboardReturnKey:(MMInputToolBarView *)inputView text:(NSString *)text {
    
    text = [text stringByReplacingOccurrencesOfString:@"\a" withString:@""];
    [MMTextParser localParseMMText:text completionHandler:^(NSArray *textImgArray) {
        NSDictionary *extDic = nil;
        NSString *sendStr = @"";
        for (id obj in textImgArray) {
            if ([obj isKindOfClass:[MMEmoji class]]) {
                MMEmoji *emoji = (MMEmoji*)obj;
                if (!extDic) {
                    extDic = @{TEXT_MESG_TYPE:TEXT_MESG_EMOJI_TYPE,
                            TEXT_MESG_DATA:[MMTextParser extDataWithTextImageArray:textImgArray]};
                }
                sendStr = [sendStr stringByAppendingString:[NSString stringWithFormat:@"[%@]", emoji.emojiName]];
            }
            else if ([obj isKindOfClass:[NSString class]]) {
                sendStr = [sendStr stringByAppendingString:obj];
            }
        }

        MMMessage *message = [[MMMessage alloc] initWithMessageType:MMMessageTypeText messageContent:sendStr messageExtraInfo:extDic];
        [_messagesArray addObject:message];
        [self.messagesTableView reloadData];
        [self scrollViewToBottom];
        
    }];
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

#pragma mark RCMessageCellDelegate
- (void)didTapChatViewCell:(MMMessage *)messageModel {
    if(messageModel.messageType == MMMessageTypeBigEmoji){
        
        NSDictionary *extDic = messageModel.messageExtraInfo;
        if (extDic != nil && [extDic[TEXT_MESG_TYPE] isEqualToString:TEXT_MESG_FACE_TYPE]) {
            UIViewController *emojiController = [[MMEmotionCentre defaultCentre] controllerForEmotionCode:extDic[TEXT_MESG_DATA][0][0]];
            [self.navigationController pushViewController:emojiController animated:YES];
        }
    }
}

- (void)didLongPressChatViewCell:(MMMessage *)messageModel inView:(UIView *)view {
    _inputToolBar.inputTextView.disableActionMenu = YES;
    
    _longPressSelectedModel = messageModel;
    
    CGRect rect = [self.view convertRect:view.frame fromView:view.superview];
    
    _menuController = [UIMenuController sharedMenuController];
    UIMenuItem *copyItem = [[UIMenuItem alloc]
                            initWithTitle:@"复制"
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
