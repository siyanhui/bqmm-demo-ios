//
//  MMTextParser+ExtData.m
//  ChatDemo-UI2.0
//
//  Created by LiChao Jun on 16/1/23.
//  Copyright © 2016年 LiChao Jun. All rights reserved.
//

#import "MMTextParser+ExtData.h"

static MMEmoji *s_placeholderEmoji = nil;

@implementation MMTextParser (ExtData)

+ (NSArray*)extDataWithTextImageArray:(NSArray*)textImageArray {
    NSMutableArray *ret = [NSMutableArray array];
    
    for (id obj in textImageArray) {
        if ([obj isKindOfClass:[MMEmoji class]]) {
            MMEmoji *emoji = (MMEmoji*)obj;
            [ret addObject:@[emoji.emojiCode, [NSString stringWithFormat:@"%d", [MMTextParser emojiTypeWithEmojiCode:emoji.emojiCode]]]];
        } else if ([obj isKindOfClass:[NSString class]]) {
            [ret addObject:@[obj, [NSString stringWithFormat:@"%d", EmojiTypeInvalid]]];
        } else {
            assert(0);
        }
    }
    
    return ret;
}

+ (NSArray*)extDataWithEmojiCode:(NSString*)emojiCode {
    
    return @[@[emojiCode, [NSString stringWithFormat:@"%d", [MMTextParser emojiTypeWithEmojiCode:emojiCode]]]];
}

+ (NSString*)stringWithExtData:(NSArray*)extData {
    NSString *ret = @"";
    for (NSArray *obj in extData) {
        NSString *str = obj[0];
        BOOL isEmojiCode = [obj[1] boolValue];
        if (isEmojiCode) {
            ret = [ret stringByAppendingString:[NSString stringWithFormat:@"[%@]", str]];
        } else {
            ret = [ret stringByAppendingString:str];
        }
    }
    return ret;
}

+ (CGSize)sizeForMMTextWithExtData:(NSArray*)extData
                              font:(UIFont *)font
                  maximumTextWidth:(CGFloat)maximumTextWidth {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    for (NSArray *obj in extData) {
        NSString *str = obj[0];
        EmojiType type = [obj[1] intValue];
        switch (type) {
            case EmojiTypeInvalid:
            {
                [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:str]];
            }
                break;
                
            case EmojiTypeSmall:
            {
                NSTextAttachment *placeholderAttachment = [[NSTextAttachment alloc] init];
                placeholderAttachment.bounds = CGRectMake(0, 0, 20, 20);//fixed size: 20X20
                [attrStr appendAttributedString:[NSAttributedString attributedStringWithAttachment:placeholderAttachment]];
            }
                break;
                
            case EmojiTypeBig:
            {
                NSTextAttachment *placeholderAttachment = [[NSTextAttachment alloc] init];
                placeholderAttachment.bounds = CGRectMake(0, 0, 60, 60);//fixed size: 60X60
                [attrStr appendAttributedString:[NSAttributedString attributedStringWithAttachment:placeholderAttachment]];
            }
                break;
                
            default:
                break;
        }
    }
    
    if (font) {
        [attrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrStr.length)];
    }
    
    CGSize sizeToFit = [attrStr boundingRectWithSize:CGSizeMake(maximumTextWidth, MAXFLOAT)
                                             options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                             context:nil].size;
    
    return CGRectIntegral(CGRectMake(0, 0, sizeToFit.width + 10, sizeToFit.height + 16)).size;
}

+ (CGSize)sizeForTextWithText:(NSString *)text
                         font:(UIFont *)font
             maximumTextWidth:(CGFloat)maximumTextWidth {
    CGSize size = CGSizeZero;
    size = [text boundingRectWithSize:CGSizeMake(maximumTextWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    size.width += 10;
    size.height += 16;
    
    return size;
}

@end
