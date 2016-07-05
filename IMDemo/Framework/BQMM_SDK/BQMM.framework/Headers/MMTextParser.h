//
//  MMTextParser.h
//  BQMM SDK
//
//  Created by ceo on 12/28/15.
//  Copyright © 2015 siyanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    EmojiTypeInvalid = 0,
    EmojiTypeSmall,
    EmojiTypeBig
} EmojiType;

@interface MMTextParser : NSObject

/**
*  parse text for MMEmoji and text (1.from local  2.from remote)
*
*  @param text              mmText
*  @param completionHandler completion handler  textImgArray: a collection of MMEmoji and text or error
*/
+ (void)parseMMText:(nullable NSString *)text
  completionHandler:(void(^__nullable)(NSArray * __nullable textImgArray))completionHandler;

/**
 *  parse text for MMEmoji and text only from local
 *
 *  @param text              mmText
 *  @param completionHandler completion handler  textImgArray: a collection of MMEmoji and text or error
 */
+ (void)localParseMMText:(nullable NSString *)text
       completionHandler:(void(^__nullable)(NSArray * __nullable textImgArray))completionHandler;

/**
 *  parse to get a collection of NSTextCheckingResult that suits the pattern of emojiCode
 *
 *  @param mmText  mmText
 *
 *  @return        a collection of NSTextCheckingResult that suits the pattern of emojiCode
 */
+ (nullable NSArray<NSTextCheckingResult *> *)findEmojicodesResultFromMMText:(nullable NSString *)mmText;

/**
 *  check the emojiCode to find out emoji type
 *
 *  @param emojiCode    emojiCode
 *
 *  @return             EmojiType
 */
+ (EmojiType)emojiTypeWithEmojiCode:(nullable NSString*)emojiCode;

@end
