//
//  SMTheme.h
//  BQMM SDK
//
//  Created by ceo on 8/27/15.
//  Copyright (c) 2015 siyanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMTheme : NSObject

/**
 *  表情mm键盘背景色
 */
@property (nonatomic, strong, nullable) UIColor  *groupViewBgColor;

/**
 *  表情mm键盘表情包背景色
 */
@property (nonatomic, strong, nullable) UIColor  *inputToolViewBgColor;

/**
 *  表情mm键盘表情包背景色
 */
@property (nonatomic, strong, nullable) UIColor  *packageBgColor;

/**
 *  表情mm键盘表情包选中状态背景色
 */
@property (nonatomic, strong, nullable) UIColor  *packageSelectedBgColor;


/**
 *  表情mm键盘底部发送按钮的背景色
 */
@property (nonatomic, strong, nullable) UIColor  *sendBtnBgColor;

/**
 *  表情mm键盘底部发送按钮的文字的颜色
 */
@property (nonatomic, strong, nullable) UIColor  *sendBtnTitleColor;

/**
 *   表情商店顶部导航条颜色
 */
@property (nonatomic, strong, nullable) UIColor  *navigationBarColor;

/**
 *  表情商店顶部导航条文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *navigationBarTintColor;

/**
 *  表情商店顶部导航条文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *navigationTitleFont;

/**
 *  分隔线的颜色
 */
@property (nonatomic, strong, nullable) UIColor  *separateColor;

/**
 *  在商店界面，表情分类名文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *shopCategoryFont;

/**
 *  在商店界面，表情分类名文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *shopCategoryColor;

/**
 *  在商店界面，表情包标题文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *shopPackageTitleFont;

/**
 *  在商店界面，表情包标题文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *shopPackageTitleColor;

/**
 *  在商店界面，表情包子标题文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *shopPackageSubTitleFont;

/**
 *  在商店界面，表情包子标题文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *shopPackageSubTitleColor;

/**
 *  在已下载表情界面，移除按钮背景色
 */
@property (nonatomic, strong, nullable) UIColor  *removeBtnBgColor;

/**
 *  在已下载表情界面，移除按钮字体
 */
@property (nonatomic, strong, nullable) UIFont  *removeBtnTitleFont;

/**
 *  在已下载表情界面，移除按钮字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *removeBtnTitleColor;

/**
 *  在已下载表情界面，移除按钮边框颜色
 */
@property (nonatomic, strong, nullable) UIColor  *removeBtnBorderColor;
/**
 *  表情包详情页禁止下载文字背景颜色
 */
@property (nonatomic, strong, nullable) UIColor  *detailPackageBannedBgColor;
/**
 *  表情包详情页禁止下载文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *detailPackageBannedFont;

/**
 *  表情包详情页禁止下载文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *detailPackageBannedColor;

/**
 *  表情包详情页标题文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *detailPackageTitleFont;

/**
 *  表情包详情页标题文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *detailPackageTitleColor;

/**
 *  表情包详情页描述文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *detailPackageDescFont;

/**
 *  表情包详情页描述文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *detailPackageDescColor;

/**
 *   表情包详情页"长按表情可预览"文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *detailPackagePreviewFont;

/**
 *  表情包详情页"长按表情可预览"文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *detailPackagePreviewColor;

/**
 *  表情包列表"下载"按钮文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *downloadTitleFont;

/**
 *  表情包列表"下载"按钮文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *downloadTitleColor;

/**
 *  表情包列表"已下载"按钮文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *downloadedTitleColor;

/**
 *  表情包列表"已下载"按钮背景色
 */
@property (nonatomic, strong, nullable) UIColor  *downloadedBgColor;

/**
 *  表情包列表"已下载"按钮边框颜色背景色
 */
@property (nonatomic, strong, nullable) UIColor  *downloadedBorderColor;

/**
 *  表情包列表下载控件边框颜色
 */
@property (nonatomic, strong, nullable) UIColor  *downloadBorderColor;

/**
 *  表情包列表下载控件背景色
 */
@property (nonatomic, strong, nullable) UIColor  *downloadBgColor;

/**
 *  表情包列表下载控件下载进度条下载中填充色
 */
@property (nonatomic, strong, nullable) UIColor  *downloadingColor;

/**
 *  表情包列表下载控件下载中文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *downloadingTextColor;

/**
 *  默认大表情下载控件文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *preloadDownloadedTitleColor;
/**
 *  默认大表情下载控件字体
 */
@property (nonatomic, strong, nullable) UIFont   *preloadDownloadTitleFont;
/**
 *  默认大表情介绍label文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *preloadIntroduceTitleColor;
/**
 *  默认大表情介绍label字体
 */
@property (nonatomic, strong, nullable) UIFont   *preloadIntroduceTitleFont;
/**
 *  默认大表情蒙板颜色
 */
@property (nonatomic,strong, nullable) UIColor *preloadMaskViewColor;
/**
 *   表情包详情页,底部版权文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *copyrightFont;

/**
 *  表情包详情页,底部版权文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *copyrightColor;

/**
 *  错误提示文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *promptLabelFont;

/**
 *  错误提示文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *promptLabelColor;

/**
 *  键盘内错误提示重试按钮字体
 */
@property (nonatomic, strong, nullable) UIFont   *retryBtnFont;

/**
 *  键盘内错误提示重试按钮文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *retryBtnColor;

/**
 *  键盘内错误提示重试按钮背景色
 */
@property (nonatomic, strong, nullable) UIColor  *retryBtnBgColor;

/**
 *  键盘内错误提示重试按钮边框颜色
 */
@property (nonatomic, strong, nullable) UIColor  *retryBtnBorderColor;


/**
 *  键盘商店按钮背景色
 */
@property (nonatomic, strong, nullable) UIColor  *shopBtnBgColor;

/**
 *  键盘商店按钮图标颜色
 */
@property (nonatomic, strong, nullable) UIColor  *shopBtnIconColor;


/**
 *  表情预览页面错误提示文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *remindLabelFont;

/**
 *  表情预览页面错误提示文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *remindLabelColor;

/**
 *  商店内错误页面提示文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *loadFailedLabelFont;

/**
 *  商店内错误页面提示文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *loadFailedLabelColor;

/**
 *  商店内错误页面重试按钮字体
 */
@property (nonatomic, strong, nullable) UIFont   *reloadBtnFont;

/**
 *  商店内错误页面重试按钮文字颜色
 */
@property (nonatomic, strong, nullable) UIColor  *reloadBtnColor;

/**
 *  我的表情页面排序按钮的颜色
 */
@property (nonatomic, strong, nullable) UIColor *orderBtnColor;

/**
 *  我的表情页面完成状态按钮的颜色
 */
@property (nonatomic, strong, nullable) UIColor *finishBtnColor;
/**
 *  表情包禁止下载的提示背景颜色
 */
@property (nonatomic, strong, nullable) UIColor *packageBannedBgColor;
/**
 *  表情包禁止下载的提示文字颜色
 */
@property (nonatomic, strong, nullable) UIColor *packageBannedTextColor;
/**
 *  表情包禁止下载的提示文字字体
 */
@property (nonatomic, strong, nullable) UIFont   *packageBannedTextFont;
/**
 *  若值>0则固定键盘高度，否则自动与切换之前的键盘高度保持一致
 */
@property (nonatomic, assign) CGFloat  keyboardHeight;
@end
