//
//  MMTextAttachment.h
//  StampMeSDK
//
//  Created by ceo on 11/9/15.
//  Copyright © 2015 siyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MMEmoji;

@interface MMTextAttachment : NSTextAttachment

/**
 *  the emoji that holds the image of attachement
 */
@property (nonatomic, strong) MMEmoji *emoji;

/**
 *  the first frame of the gif which can be showed in the input control
 *  the size of the placeholder image is 100X100
 *  @return placeholder image
 */
- (UIImage *)placeHolderImage;

@end
