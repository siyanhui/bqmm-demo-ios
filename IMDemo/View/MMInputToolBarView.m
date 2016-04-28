//
//  MMInputToolBarView.m
//  IMDemo
//
//  Created by isan on 16/4/22.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import "MMInputToolBarView.h"
#import <BQMM/BQMM.h>

@implementation MMInputToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setView];
        [self registerNotification];
    }
    return self;
}

- (void)dealloc
{
    [self unRegisterNotification];
}

- (void)registerNotification
{
    [self unRegisterNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveKeyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveKeyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)unRegisterNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveKeyboardWillShowNotification:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSInteger animationCurveOption = (animationCurve << 16);
    
    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationCurveOption
                     animations:^{
                         if ([self.delegate respondsToSelector:@selector(keyboardWillShowWithFrame:)]) {
                             [self.delegate keyboardWillShowWithFrame:keyboardEndFrame];
                         }
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)didReceiveKeyboardWillHideNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSInteger animationCurveOption = (animationCurve << 16);
    
    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationCurveOption
                     animations:^{
                         if ([self.delegate respondsToSelector:@selector(keyboardWillShowWithFrame:)]) {
                             [self.delegate keyboardWillShowWithFrame:keyboardEndFrame];
                         }
                     }
                     completion:^(BOOL finished) {
                         
                     }];

}

- (void)setView
{
    _inputTextViewHeight = TEXTVIEW_MIN_HEIGHT;
    self.backgroundColor = [UIColor colorWithRed:200 / 255.f green:200 / 255.f blue:200 / 255.f alpha:1];
    _inputTextView = [[MMTextView alloc] init];
    _inputTextView.delegate = self;
    [_inputTextView setExclusiveTouch:YES];
    [_inputTextView setTextColor:[UIColor blackColor]];
    [_inputTextView setFont:[UIFont systemFontOfSize:16]];
    [_inputTextView setReturnKeyType:UIReturnKeySend];
    _inputTextView.backgroundColor = [UIColor colorWithRed:248 / 255.f green:248 / 255.f blue:248 / 255.f alpha:1];
    _inputTextView.enablesReturnKeyAutomatically = YES;
    _inputTextView.layer.cornerRadius = 4;
    _inputTextView.layer.masksToBounds = YES;
    _inputTextView.layer.borderWidth = 0.3f;
    _inputTextView.layer.borderColor = [UIColor colorWithRed:60 / 255.f green:60 / 255.f blue:60 / 255.f alpha:1].CGColor;

    [self addSubview:_inputTextView];
    
    _emojiButton = [[UIButton alloc] init];
    [_emojiButton setImage:[UIImage imageNamed:@"keyboard_bqmm"] forState:UIControlStateNormal];
    [_emojiButton setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateSelected];
    [_emojiButton addTarget:self action:@selector(didTouchEmojiDown:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_emojiButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutViews];
}

- (void)layoutViews {
    CGSize viewSize = self.frame.size;
    
    CGSize emojiButtonSize = CGSizeMake(28, 28);
    self.emojiButton.frame = CGRectMake(15, viewSize.height - emojiButtonSize.height - 11, emojiButtonSize.width, emojiButtonSize.height);
    
    CGFloat inputViewWidth = viewSize.width - CGRectGetMaxX(self.emojiButton.frame) - 10 - 10;
    self.inputTextView.frame = CGRectMake(CGRectGetMaxX(self.emojiButton.frame) + 10, (viewSize.height - _inputTextViewHeight) / 2, inputViewWidth, _inputTextViewHeight);
}

#pragma mark user action
- (void)didTouchEmojiDown:(UIButton *)sender {
    [self.delegate didTouchEmojiButton:sender];
}

#pragma mark <UITextViewDelegate>
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self didSendTextMessage];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.markedTextRange == nil) {
        NSRange selectedRange = textView.selectedRange;
        textView.mmText = textView.mmText;
        textView.selectedRange = selectedRange;
    }
    [self performSelector:@selector(layoutTextView:) withObject:textView afterDelay:0.1];
}

#pragma mark MMEmotionCentreDelegate

- (void)didSelectEmoji:(MMEmoji *)emoji
{
    if ([self.delegate respondsToSelector:@selector(didSendMMFace:)]) {
        [self.delegate didSendMMFace:emoji];
    }
}

- (void)didSelectTipEmoji:(MMEmoji *)emoji
{
    if ([self.delegate respondsToSelector:@selector(didSendMMFace:)]) {
        [self.delegate didSendMMFace:emoji];
        self.inputTextView.text = @"";
    }
}

- (void)didSendWithInput:(UIResponder<UITextInput> *)input
{
    [self didSendTextMessage];
}

- (void)tapOverlay
{
    self.emojiButton.selected = false;
    [[MMEmotionCentre defaultCentre] switchToDefaultKeyboard];
    if ([self.delegate respondsToSelector:@selector(didTouchMMTextViewOverLay)]) {
        [self.delegate didTouchMMTextViewOverLay];
    }
}

#pragma mark private method
- (void)didSendTextMessage {
    if ([self.delegate respondsToSelector:@selector(didTouchKeyboardReturnKey:text:)]) {
        NSString *_needToSendText = _inputTextView.mmText;
        NSString *_formatString =
        [_needToSendText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([_formatString length] > 0) {
            [self.delegate didTouchKeyboardReturnKey:self text:[_needToSendText copy]];
        }
    }
    self.inputTextView.mmText = @"";
    _inputTextViewHeight = TEXTVIEW_MIN_HEIGHT;
    [self relayout];
}

- (void)layoutTextView:(UITextView *)textView {
    CGFloat height = textView.contentSize.height;
    if(height != _inputTextViewHeight) {
        
        if(height > TEXTVIEW_MIN_HEIGHT) {
            _inputTextViewHeight = height;
            if(height + textView.textContainerInset.top + textView.textContainerInset.bottom < TEXTVIEW_MAX_HEIGHT) {
            }else{
                _inputTextViewHeight = (TEXTVIEW_MAX_HEIGHT - textView.textContainerInset.top - textView.textContainerInset.bottom);
            }
        }else{
            _inputTextViewHeight = TEXTVIEW_MIN_HEIGHT;
        }
        [self relayout];
    }
}

- (void)relayout{
    [self.delegate toolbarHeightDidChangedTo:_inputTextViewHeight + 14];
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutViews];
    }];
    
}

@end
