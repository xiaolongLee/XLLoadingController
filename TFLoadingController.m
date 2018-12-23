//
//  TFLoadingController.m
//  App23_animation_fix
//
//  Created by 向阳 on 15/10/14.
//  Copyright © 2015年 向阳. All rights reserved.
//

#import "TFLoadingController.h"
#define DEFAULT_INFO_LOADING @"数据加载中"

@interface TFLoadingController ()
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIButton *canelBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *retryBtn;

//按钮层
@property (strong, nonatomic) IBOutlet UIView *btnView;
//菊花层
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *juhuaFlag;
//报错文字信息
@property (strong, nonatomic) IBOutlet UILabel *errMsg;
@property (strong, nonatomic) IBOutlet UIView *splitView;

//加载中取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelLoadingButton;

@end

@implementation TFLoadingController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mainView.layer.cornerRadius = 2;
    self.mainView.layer.masksToBounds = YES;
    self.btnView.layer.cornerRadius = 2;
    self.btnView.layer.masksToBounds = YES;
    
    if (_loadingMessage) {
        self.errMsg.text = _loadingMessage;
    } else {
        self.errMsg.text = DEFAULT_INFO_LOADING;
    }
    self.btnView.hidden = YES;
    
    self.splitView.hidden = !_showCancelButton;
    _cancelLoadingButton.hidden = !_showCancelButton;
    
    if (!_showCancelButton) {
        [_cancelLoadingButton removeFromSuperview];
        [_splitView removeFromSuperview];
        [_btnView removeFromSuperview];
        self.view.frame = CGRectMake(0, 0, 200, 160-44-1);
    }
    
    if (_recoveryData) {
        // 数据恢复专有提示页面
        ProgressView *progressView = [[ProgressView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        progressView.hiddenCenter = YES;
        _progressView = progressView;
        progressView.center = _juhuaFlag.center;
        progressView.progress = 0;
        progressView.drawColor = kTextLightGrayColor;
        [progressView setNeedsDisplay];
        progressView.backgroundColor = [UIColor whiteColor];
        [_juhuaFlag.superview addSubview:progressView];
        _juhuaFlag.hidden = YES;
    }
}

- (IBAction)cancelClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
        self.splitView.hidden = YES;
    }
}

- (IBAction)retryClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(retryButtnClicked:)]) {
        [self reset];
        [self.delegate retryButtnClicked:self];
    }
}

- (IBAction)cancelLoadingButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickCancelLoadingButton)]) {
        [self.delegate didClickCancelLoadingButton];
    }
}

- (void)reset {
    if (_loadingMessage) {
        self.errMsg.text = _loadingMessage;
    } else {
        self.errMsg.text = DEFAULT_INFO_LOADING;
    }
    self.btnView.hidden = YES;
    self.splitView.hidden = !_showCancelButton;
    _cancelLoadingButton.hidden = !_showCancelButton;
}

- (void)changeErrState:(NSString*)msg{
    self.errMsg.text = msg;
    self.btnView.hidden = NO;
    self.splitView.hidden = NO;
}



@end
