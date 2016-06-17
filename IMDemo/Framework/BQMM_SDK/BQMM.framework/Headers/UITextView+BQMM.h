//
//  UITextView+BQMM.h
//  BQMM SDK
//
//  Created by ceo on 11/9/15.
//  Copyright © 2015 siyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (BQMM)

/**
 *  表情消息
 */
@property(nonatomic, assign, nullable) NSString *mmText;

/**
 *  获取特定范围内的表情消息
 *
 *  @param range attributedText的range
 *
 *  @return 表情消息
 */
- (nullable NSString *)mmTextWithRange:(NSRange)range;

@end
