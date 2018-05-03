//
//  MMTextAttachment.m
//  StampMeSDK
//
//  Created by ceo on 11/9/15.
//  Copyright © 2015 siyanhui. All rights reserved.
//

#import "MMTextAttachment.h"

#import <BQMM/BQMM.h>

@implementation MMTextAttachment

- (void)setEmoji:(MMEmoji *)emoji {
    if (_emoji != emoji) {
        _emoji = emoji;
        self.image = _emoji.emojiImage;
        self.bounds = CGRectMake(0, 0, self.image.size.width * self.image.scale / 4, self.image.size.height * self.image.scale / 4);

    }
}

- (UIImage *)placeHolderImage {
    static UIImage *clearImage = nil;
    if (clearImage == nil) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
        clearImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return clearImage;
}
@end
