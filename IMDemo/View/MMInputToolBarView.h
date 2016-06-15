//
//  MMInputToolBarView.h
//  IMDemo
//
//  Created by isan on 16/4/22.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
//BQMM集成
#import "MMTextView.h"
#import <BQMM/BQMM.h>
#define INPUT_TOOL_BAR_HEIGHT 50.0f
#define TEXTVIEW_MAX_HEIGHT 200.0f
#define TEXTVIEW_MIN_HEIGHT 36.0f

@class MMEmoji;
/*!
 输入工具栏delegate
 */
@protocol MMInputToolBarViewDelegate;

@interface MMInputToolBarView : UIView<UITextViewDelegate, MMEmotionCentreDelegate>


@property(weak, nonatomic) id<MMInputToolBarViewDelegate> delegate;
@property(strong, nonatomic) MMTextView *inputTextView;
@property(strong, nonatomic) UIButton *emojiButton;

/*!
 文本输入框的高度
 */
@property(assign, nonatomic) float inputTextViewHeight;

@end

@protocol MMInputToolBarViewDelegate <NSObject>

@optional

/*!
 键盘即将显示的回调
 
 @param keyboardFrame 键盘最终需要显示的Frame
 */
- (void)keyboardWillShowWithFrame:(CGRect)keyboardFrame;

/*!
 键盘即将隐藏的回调
 */
- (void)keyboardWillHide;

//BQMM集成
/*!
 点击键盘Return按钮的回调
 
 @param inputView    当前输入工具栏
 @param text         当前输入框的文本内容
 */
- (void)didTouchKeyboardReturnKey:(MMInputToolBarView *)inputView text:(NSString *)text;

/*!
 点击表情按钮的回调
 
 @param sender 表情按钮
 */
- (void)didTouchEmojiButton:(UIButton *)sender;

/**
 *  发送表情mm大表情
 *
 *  @param emoji 表情对象
 */
- (void)didSendMMFace:(MMEmoji *)emoji;

/**
 *  点击输入框触发切换键盘
 */
- (void)didTouchMMTextViewOverLay;

/**
 *  toolBar的高度变化回调
 *
 *  @param height
 */
- (void)toolbarHeightDidChangedTo:(CGFloat)height;

@end
