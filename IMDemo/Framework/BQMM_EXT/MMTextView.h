//
//  MMTextView.h
//  BQMM SDK
//
//  Created by ceo on 11/9/15.
//  Copyright © 2015 siyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MMTextViewDelegate;

@interface MMTextView : UITextView<UIGestureRecognizerDelegate>

@property (nonatomic, weak) id <MMTextViewDelegate> clickActionDelegate;

/*!
 是否关闭菜单
 
 @discussion 默认值为NO。
 */
@property(nonatomic, assign) BOOL disableActionMenu;

/**
 *  字体
 */
@property (nonatomic,strong) UIFont *mmFont;
/**
 *  字色
 */
@property (nonatomic,strong) UIColor *mmTextColor;

/**
 *  设定视图文本，需要显示表情的地方用占位图片代替
 *
 *  @param extData 二维数组 如 @[@[@"emojiCode", @1], @[@"text", @0]]
 */

- (void)setPlaceholderTextWithData:(NSArray*)extData;
/**
 *  设定视图文本，需要显示表情的地方如果本地有就显示，没有下载后显示
 *
 *  @param extData 二维数组 如 @[@[@"emojiCode", @1], @[@"text", @0]]
 */

- (void)setMmTextData:(NSArray *)extData;
/**
 *  设定视图文本，需要显示表情的地方如果本地有就显示，没有下载后显示
 *
 *  @param extData           二维数组 如 @[@[@"emojiCode", @1], @[@"text", @0]]
 *  @param completionHandler 完成显示表情后的回调
 */
- (void)setMmTextData:(NSArray*)extData completionHandler:(void(^)(void))completionHandler;

- (void)setURLAttributes;

@end

@protocol MMTextViewDelegate <NSObject>
@optional

/*!
 点击URL的回调
 
 @param label 当前Label
 @param url   点击的URL
 */
- (void)mmTextView:(MMTextView *)textView didSelectLinkWithURL:(NSURL *)url;

/*!
 点击电话号码的回调
 
 @param label       当前Label
 @param phoneNumber 点击的URL
 */
- (void)mmTextView:(MMTextView *)textView didSelectLinkWithPhoneNumber:(NSString *)phoneNumber;

/*!
 点击Label的回调
 
 @param label   当前Label
 @param content 点击的内容
 */
- (void)mmTextView:(MMTextView *)textView didTapTextView:(NSString *)content;

@end
