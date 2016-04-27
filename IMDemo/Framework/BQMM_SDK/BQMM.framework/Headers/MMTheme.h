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
@property (nonatomic, strong) UIColor  *groupViewBgColor;

/**
 *  表情mm键盘表情包背景色
 */
@property (nonatomic, strong) UIColor  *inputToolViewBgColor;

/**
 *  表情mm键盘表情包背景色
 */
@property (nonatomic, strong) UIColor  *packageBgColor;

/**
 *  表情mm键盘表情包选中状态背景色
 */
@property (nonatomic, strong) UIColor  *packageSelectedBgColor;


/**
 *  表情mm键盘底部发送按钮的背景色
 */
@property (nonatomic, strong) UIColor  *sendBtnBgColor;

/**
 *  表情mm键盘底部发送按钮的文字的颜色
 */
@property (nonatomic, strong) UIColor  *sendBtnTitleColor;

/**
 *   表情商店顶部导航条颜色
 */
@property (nonatomic, strong) UIColor  *navigationBarColor;

/**
 *  表情商店顶部导航条文字颜色
 */
@property (nonatomic, strong) UIColor  *navigationBarTintColor;

/**
 *  表情商店顶部导航条文字字体
 */
@property (nonatomic, strong) UIFont   *navigationTitleFont;

/**
 *  分隔线的颜色
 */
@property (nonatomic, strong) UIColor  *separateColor;

/**
 *  在商店界面，表情分类名文字字体
 */
@property (nonatomic, strong) UIFont   *shopCategoryFont;

/**
 *  在商店界面，表情分类名文字颜色
 */
@property (nonatomic, strong) UIColor  *shopCategoryColor;

/**
 *  在商店界面，表情包标题文字字体
 */
@property (nonatomic, strong) UIFont   *shopPackageTitleFont;

/**
 *  在商店界面，表情包标题文字颜色
 */
@property (nonatomic, strong) UIColor  *shopPackageTitleColor;

/**
 *  在商店界面，表情包子标题文字字体
 */
@property (nonatomic, strong) UIFont   *shopPackageSubTitleFont;

/**
 *  在商店界面，表情包子标题文字颜色
 */
@property (nonatomic, strong) UIColor  *shopPackageSubTitleColor;

/**
 *  在已下载表情界面，移除按钮背景色
 */
@property (nonatomic, strong) UIColor  *removeBtnBgColor;

/**
 *  在已下载表情界面，移除按钮字体
 */
@property (nonatomic, strong) UIFont  *removeBtnTitleFont;

/**
 *  在已下载表情界面，移除按钮字颜色
 */
@property (nonatomic, strong) UIColor  *removeBtnTitleColor;

/**
 *  在已下载表情界面，移除按钮边框颜色
 */
@property (nonatomic, strong) UIColor  *removeBtnBorderColor;

/**
 *  表情包详情页标题文字字体
 */
@property (nonatomic, strong) UIFont   *detailPackageTitleFont;

/**
 *  表情包详情页标题文字颜色
 */
@property (nonatomic, strong) UIColor  *detailPackageTitleColor;

/**
 *  表情包详情页描述文字字体
 */
@property (nonatomic, strong) UIFont   *detailPackageDescFont;

/**
 *  表情包详情页描述文字颜色
 */
@property (nonatomic, strong) UIColor  *detailPackageDescColor;

/**
 *   表情包详情页"长按表情可预览"文字字体
 */
@property (nonatomic, strong) UIFont   *detailPackagePreviewFont;

/**
 *  表情包详情页"长按表情可预览"文字颜色
 */
@property (nonatomic, strong) UIColor  *detailPackagePreviewColor;

/**
 *  表情包列表"下载"按钮文字字体
 */
@property (nonatomic, strong) UIFont   *downloadTitleFont;

/**
 *  表情包列表"下载"按钮文字颜色
 */
@property (nonatomic, strong) UIColor  *downloadTitleColor;

/**
 *  表情包列表"已下载"按钮文字颜色
 */
@property (nonatomic, strong) UIColor  *downloadedTitleColor;

/**
 *  表情包列表"已下载"按钮背景色
 */
@property (nonatomic, strong) UIColor  *downloadedBgColor;

/**
 *  表情包列表"已下载"按钮边框颜色背景色
 */
@property (nonatomic, strong) UIColor  *downloadedBorderColor;

/**
 *  表情包列表下载控件边框颜色
 */
@property (nonatomic, strong) UIColor  *downloadBorderColor;

/**
 *  表情包列表下载控件背景色
 */
@property (nonatomic, strong) UIColor  *downloadBgColor;

/**
 *  表情包列表下载控件下载进度条下载中填充色
 */
@property (nonatomic, strong) UIColor  *downloadingColor;

/**
 *  表情包列表下载控件下载中文字颜色
 */
@property (nonatomic, strong) UIColor  *downloadingTextColor;

/**
 *  默认大表情下载控件文字颜色
 */
@property (nonatomic, strong) UIColor  *preloadDownloadedTitleColor;
/**
 *  默认大表情下载控件字体
 */
@property (nonatomic, strong) UIFont   *preloadDownloadTitleFont;
/**
 *  默认大表情介绍label文字颜色
 */
@property (nonatomic, strong) UIColor  *preloadIntroduceTitleColor;
/**
 *  默认大表情介绍label字体
 */
@property (nonatomic, strong) UIFont   *preloadIntroduceTitleFont;
/**
 *  默认大表情蒙板颜色
 */
@property (nonatomic,strong) UIColor *preloadMaskViewColor;
/**
 *   表情包详情页,底部版权文字字体
 */
@property (nonatomic, strong) UIFont   *copyrightFont;

/**
 *  表情包详情页,底部版权文字颜色
 */
@property (nonatomic, strong) UIColor  *copyrightColor;

/**
 *  错误提示文字字体
 */
@property (nonatomic, strong) UIFont   *promptLabelFont;

/**
 *  错误提示文字颜色
 */
@property (nonatomic, strong) UIColor  *promptLabelColor;

/**
 *  键盘内错误提示重试按钮字体
 */
@property (nonatomic, strong) UIFont   *retryBtnFont;

/**
 *  键盘内错误提示重试按钮文字颜色
 */
@property (nonatomic, strong) UIColor  *retryBtnColor;

/**
 *  键盘内错误提示重试按钮背景色
 */
@property (nonatomic, strong) UIColor  *retryBtnBgColor;

/**
 *  键盘内错误提示重试按钮边框颜色
 */
@property (nonatomic, strong) UIColor  *retryBtnBorderColor;


/**
 *  键盘商店按钮背景色
 */
@property (nonatomic, strong) UIColor  *shopBtnBgColor;

/**
 *  键盘商店按钮图标颜色
 */
@property (nonatomic, strong) UIColor  *shopBtnIconColor;


/**
 *  表情预览页面错误提示文字字体
 */
@property (nonatomic, strong) UIFont   *remindLabelFont;

/**
 *  表情预览页面错误提示文字颜色
 */
@property (nonatomic, strong) UIColor  *remindLabelColor;

/**
 *  商店内错误页面提示文字字体
 */
@property (nonatomic, strong) UIFont   *loadFailedLabelFont;

/**
 *  商店内错误页面提示文字颜色
 */
@property (nonatomic, strong) UIColor  *loadFailedLabelColor;

/**
 *  商店内错误页面重试按钮字体
 */
@property (nonatomic, strong) UIFont   *reloadBtnFont;

/**
 *  商店内错误页面重试按钮文字颜色
 */
@property (nonatomic, strong) UIColor  *reloadBtnColor;

/**
 *  我的表情页面排序按钮的颜色
 */
@property (nonatomic, strong) UIColor *orderBtnColor;

/**
 *  我的表情页面完成状态按钮的颜色
 */
@property (nonatomic, strong) UIColor *finishBtnColor;

@end
