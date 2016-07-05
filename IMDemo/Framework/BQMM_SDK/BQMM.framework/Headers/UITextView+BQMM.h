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
 *  emoji message
 */
@property(nonatomic, assign, nullable) NSString *mmText;

/**
 *  get a range of emoji message
 *
 *  @param range     the range of selected attributedString
 *
 *  @return          a range of emoji message
 */
- (nullable NSString *)mmTextWithRange:(NSRange)range;

@end
