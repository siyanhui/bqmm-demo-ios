//
//  MMTextParser.h
//  BQMM SDK
//
//  Created by ceo on 12/28/15.
//  Copyright © 2015 siyanhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BQMM/BQMM.h>
typedef enum
{
    EmojiTypeInvalid = 0,
    EmojiTypeSmall,
    EmojiTypeBig
} EmojiType;

@interface MMTextParser : NSObject

/**
 *  convert textImageArray to extData
 *
 *  @param textImageArray    a collection of MMEmoji and text
 *
 *  @return extData          a two dimentional array e.g. @[@[@"emojiCode", @1], @[@"text", @0]]
 */
+ (nonnull NSArray*)extDataWithTextImageArray:(nonnull NSArray* )textImageArray;

+ (nonnull NSArray * )extDataWithEmoji:(nonnull MMEmoji *)emoji;

/**
 *  convert extData to mmtext
 *
 *  @param extData           a two dimentional array e.g. @[@[@"emojiCode", @1], @[@"text", @0]]
 *
 *  @return mmtext
 */
+ (nonnull NSString*)stringWithExtData:(nonnull NSArray*)extData;

/**
 *  compute the size of MMTextView, `extData` is MMTextView's content
 *
 *  @param extData           a two dimentional array e.g. @[@[@"emojiCode", @1], @[@"text", @0]]
 *  @param font              the font of MMTextView
 *  @param maximumTextWidth  the max width set to MMTextView
 *
 *  @return the size of content in MMTextView
 */
+ (CGSize)sizeForMMTextWithExtData:(nonnull NSArray*)extData
                              font:(nonnull UIFont *)font
                  maximumTextWidth:(CGFloat)maximumTextWidth;

/**
 *  compute the size of MMTextView, `text` is MMTextView's content
 *
 *  @param font              the font of MMTextView
 *  @param maximumTextWidth  the max width set to MMTextView
 *
 *  @return the size of content in MMTextView
 */
+ (CGSize)sizeForTextWithText:(nonnull NSString *)text
                         font:(nonnull UIFont *)font
             maximumTextWidth:(CGFloat)maximumTextWidth;



/**
 *  check the emoji to find out emoji type
 *
 *  @param emoji        emoji
 *
 *  @return             EmojiType
 */
+ (EmojiType)emojiTypeWithEmoji:(nullable MMEmoji *)emoji;

@end
