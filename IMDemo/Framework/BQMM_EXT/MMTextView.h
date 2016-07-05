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

/**
 *  disable the action menu of the input control or not, default is NO.
 */
@property(nonatomic, assign) BOOL disableActionMenu;

/**
 *  the font of MMTextView
 */
@property (nonatomic,strong) UIFont *mmFont;
/**
 *  the text color of MMtextView
 */
@property (nonatomic,strong) UIColor *mmTextColor;

/**
 *  set data of MMTextView
 *  the method will download the emoji image with emoji code if necessary
 *
 *  @param extData two dimentional array e.g. @[@[@"emojiCode", @1], @[@"text", @0]]
 */

- (void)setMmTextData:(NSArray *)extData;
/**
 *  set data of MMTextView
 *  the method will download the emoji image with emoji code if necessary
 *
 *  @param extData two dimentional array e.g. @[@[@"emojiCode", @1], @[@"text", @0]]
 *  @param completionHandler   completion callback
 */
- (void)setMmTextData:(NSArray*)extData completionHandler:(void(^)(void))completionHandler;

/**
 *  search the content of MMtextView for URL and Phone number and set `link attribute` on them
 */
- (void)setURLAttributes;

@end

@protocol MMTextViewDelegate <NSObject>
@optional

/**
 *  the delegate method handles the click of URL
 *
 *  @param textView current MMtextView
 *  @param url      the url that being clicked
 */
- (void)mmTextView:(MMTextView *)textView didSelectLinkWithURL:(NSURL *)url;

/**
 *  the delegate method handles the click of phone number
 *
 *  @param textView    current MMtextView
 *  @param phoneNumber the phone number that being clicked
 */
- (void)mmTextView:(MMTextView *)textView didSelectLinkWithPhoneNumber:(NSString *)phoneNumber;

@end
