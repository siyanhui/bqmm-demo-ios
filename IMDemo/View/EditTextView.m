//
//  EditTextView.m
//  IMDemo
//
//  Created by isan on 16/7/5.
//  Copyright © 2016年 siyanhui. All rights reserved.
//

#import "EditTextView.h"

@interface EditTextView() {
    UILabel *_placeHolderLabel;
}
@end

@implementation EditTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _disableActionMenu = NO;
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.disableActionMenu) {
        return NO;
    }
    [[UIMenuController sharedMenuController] setMenuItems:nil];
    return [super canPerformAction:action withSender:sender];
}

@end
