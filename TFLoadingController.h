//
//  TFLoadingController.h
//  App23_animation_fix
//
//  Created by 向阳 on 15/10/14.
//  Copyright © 2015年 向阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"

@protocol TFLoadingControllerDelegate;

@interface TFLoadingController : UIViewController
@property (assign, nonatomic) BOOL showCancelButton;
@property (strong, nonatomic) NSString *loadingMessage;
@property (assign, nonatomic) id <TFLoadingControllerDelegate> delegate;
- (void)reset;
- (void)changeErrState:(NSString*)msg;

/// 此属性只用于 数据恢复提示页面
@property (nonatomic) BOOL recoveryData;
@property (nonatomic, weak) ProgressView *progressView;
@end

@protocol TFLoadingControllerDelegate<NSObject>
@required
- (void)cancelButtonClicked:(TFLoadingController*)tfLoadingController;
- (void)retryButtnClicked:(TFLoadingController*)tfLoadingController;
@optional
- (void)didClickCancelLoadingButton;
@end
