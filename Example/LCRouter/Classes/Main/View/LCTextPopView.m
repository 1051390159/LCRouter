//
//  LCTextPopView.m
//  LCRouter_Example
//
//  Created by 刘彬 on 2020/8/6.
//  Copyright © 2020 liubin. All rights reserved.
//

#import "LCTextPopView.h"

@interface LCTextPopView ()

@property (nonatomic, strong) UIButton *showBtn;
@property (nonatomic, strong) UITextField *hostTextField;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *jumpBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation LCTextPopView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

+ (void)showTextPopView {
    LCTextPopView *textPopView = [[LCTextPopView alloc]initWithFrame:CGRectMake(-kScreenWidth+40, 80, kScreenWidth, kScreenHeight-160)];
    [[[UIApplication sharedApplication] windows].lastObject addSubview:textPopView];
}

#pragma mark - Private

- (void)initView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView)];
    [self.contentView addGestureRecognizer:tap];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.hostTextField];
    [self.contentView addSubview:self.jumpBtn];
    [self addSubview:self.showBtn];
}

- (void)showView {
    [UIView animateWithDuration:0.5 animations:^{
        [self setFrame:CGRectMake(0, 80, kScreenWidth, kScreenHeight-160)];
    } completion:^(BOOL finished) {
    }];
}

- (void)hiddenView {
    [UIView animateWithDuration:0.5 animations:^{
        [self setFrame:CGRectMake(-kScreenWidth+40, 80, kScreenWidth, kScreenHeight-160)];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - IBAction

- (IBAction)jumpAction:(id)sender {
    if (kIsValidStr(self.hostTextField.text)) {
        [[LCRouter sharedInstance] routeWithUri:[NSString stringWithFormat:@"shenZhen://%@",self.hostTextField.text]];
    }
    [self.hostTextField resignFirstResponder];
}

- (IBAction)showAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self showView];
    }
    else {
        [self hiddenView];
    }
    
}

#pragma mark - Lazy
 
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 200, 20)];
        [_nameLab setFont:[UIFont systemFontOfSize:14]];
        [_nameLab setText:@"shenZhen://"];
        [_nameLab setTextColor:[UIColor blackColor]];
    }
    return _nameLab;
}

- (UITextField *)hostTextField {
    if (!_hostTextField) {
        _hostTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 110, kScreenWidth-80, 44)];
        [_hostTextField setTextColor:[UIColor blackColor]];
        [_hostTextField setPlaceholder:@"输入host及参数(child?age=12&name=xiaoming)"];
    }
    return _hostTextField;
}

- (UIButton *)jumpBtn {
    if (!_jumpBtn) {
        _jumpBtn = [[UIButton alloc]initWithFrame:CGRectMake(80, 200, kScreenWidth-160 , 44)];
        [_jumpBtn setTitle:@"立即跳转" forState:UIControlStateNormal];
        [_jumpBtn addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jumpBtn;
}

- (UIButton *)showBtn {
    if (!_showBtn) {
        _showBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-40, (kScreenHeight-200)/2, 36, 44)];
        [_showBtn setTitle:@"<<" forState:UIControlStateSelected];
        [_showBtn setTitle:@">>" forState:UIControlStateNormal];
        [_showBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_showBtn setBackgroundColor:[UIColor blueColor]];
        [_showBtn addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
        _showBtn.selected = NO;
    }
    return _showBtn;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, kScreenHeight-160)];
        [_contentView setBackgroundColor: [UIColor grayColor]];
    }
    return _contentView;;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
