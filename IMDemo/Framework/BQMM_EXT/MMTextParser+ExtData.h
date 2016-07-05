//
//  MMTextParser+ExtData.h
//  ChatDemo-UI2.0
//
//  Created by LiChao Jun on 16/1/23.
//  Copyright © 2016 LiChao Jun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BQMM/BQMM.h>

@interface MMTextParser (ExtData)

/**
 *  convert textImageArray to extData
 *
 *  @param textImageArray    a collection of MMEmoji and text
 *
 *  @return extData          a two dimentional array e.g. @[@[@"emojiCode", @1], @[@"text", @0]]
 */
+ (NSArray*)extDataWithTextImageArray:(NSArray*)textImageArray;

/**
 *  convert a single emojiCode to extData
 *
 *  @param emojiCode         the emoji code
 *
 *  @return extData          a two dimentional array e.g. @[@[@"emojiCode", @1], @[@"text", @0]]
 */
+ (NSArray*)extDataWithEmojiCode:(NSString*)emojiCode;

/**
 *  convert extData to mmtext
 *
 *  @param extData           a two dimentional array e.g. @[@[@"emojiCode", @1], @[@"text", @0]]
 *
 *  @return mmtext
 */
+ (NSString*)stringWithExtData:(NSArray*)extData;

/**
 *  compute the size of MMTextView, `extData` is MMTextView's content
 *
 *  @param extData           a two dimentional array e.g. @[@[@"emojiCode", @1], @[@"text", @0]]
 *  @param font              the font of MMTextView
 *  @param maximumTextWidth  the max width set to MMTextView
 *
 *  @return the size of content in MMTextView
 */
+ (CGSize)sizeForMMTextWithExtData:(NSArray*)extData
                              font:(UIFont *)font
                  maximumTextWidth:(CGFloat)maximumTextWidth;

/**
 *  compute the size of MMTextView, `text` is MMTextView's content
 *
 *  @param extData           a two dimentional array e.g. @[@[@"emojiCode", @1], @[@"text", @0]]
 *  @param font              the font of MMTextView
 *  @param maximumTextWidth  the max width set to MMTextView
 *
 *  @return the size of content in MMTextView
 */
+ (CGSize)sizeForTextWithText:(NSString *)text
                         font:(UIFont *)font
             maximumTextWidth:(CGFloat)maximumTextWidth;

@end
