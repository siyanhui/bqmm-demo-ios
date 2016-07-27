//
//  MMInputToolBarView.h
//  IMDemo
//
//  Created by isan on 16/4/22.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
//Integrate BQMM
#import "EditTextView.h"
#import <BQMM/BQMM.h>
#define INPUT_TOOL_BAR_HEIGHT 50.0f
#define TEXTVIEW_MAX_HEIGHT 200.0f
#define TEXTVIEW_MIN_HEIGHT 36.0f

@class MMEmoji;
/*!
 input toolbar delegate
 */
@protocol MMInputToolBarViewDelegate;

@interface MMInputToolBarView : UIView<UITextViewDelegate, MMEmotionCentreDelegate>


@property(weak, nonatomic) id<MMInputToolBarViewDelegate> delegate;
@property(strong, nonatomic) EditTextView *inputTextView;
@property(strong, nonatomic) UIButton *emojiButton;

/*!
 the height of inputTextView
 */
@property(assign, nonatomic) float inputTextViewHeight;

@end

@protocol MMInputToolBarViewDelegate <NSObject>

@optional

/*!
 keyboard will show with frame delegate method
 
 @param keyboardFrame  the Frame of keyboard
 */
- (void)keyboardWillShowWithFrame:(CGRect)keyboardFrame;

/*!
 keyboard will hide delegate method
 */
- (void)keyboardWillHide;

//Integrate BQMM
/*!
 the delegate method handles the click of `return` key in keyboard
 
 @param inputView    UITextView
 */
- (void)didTouchKeyboardReturnKey:(UITextView *)inputView;

/*!
 the delegate method handles the click of emoji button
 
 @param sender  emoji button
 */
- (void)didTouchEmojiButton:(UIButton *)sender;

/**
 *  the delegate method handles send big emoji message
 *
 *  @param emoji MMemoji object
 */
- (void)didSendMMFace:(MMEmoji *)emoji;


/**
 *  the delegate method handles the change of toolbar height
 *
 *  @param height
 */
- (void)toolbarHeightDidChangedTo:(CGFloat)height;

@end
