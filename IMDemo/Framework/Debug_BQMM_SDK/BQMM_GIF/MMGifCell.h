//
//  BQSSGifCell
//  bqss-demo
//
//  Created by isan on 29/12/2016.
//  Copyright © 2016 siyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BQMM/BQMM.h>

@interface MMGifCell : UICollectionViewCell
@property(strong, nonatomic) UIActivityIndicatorView *loadingIndicator;
@property(strong, atomic) UIImageView *emojiImageView;
@property(strong, atomic) MMGif *picture;

- (void)setData: (MMGif *)gif;
@end
