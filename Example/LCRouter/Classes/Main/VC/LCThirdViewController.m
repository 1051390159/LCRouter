//
//  LCThirdViewController.m
//  LCRouter_Example
//
//  Created by 刘彬 on 2020/8/6.
//  Copyright © 2020 liubin. All rights reserved.
//

#import "LCThirdViewController.h"

@interface LCThirdViewController ()

@property (nonatomic, strong) UIButton *starBtn;

@end

@implementation LCThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

#pragma mark - IBActions

- (IBAction)showChildAction:(id)sender {
    
}

#pragma mark - Private

- (void)initView {
    [self.view addSubview:self.starBtn];
}

#pragma mark - Lazy

- (UIButton *)starBtn {
    if (!_starBtn) {
        _starBtn = [[UIButton alloc]initWithFrame:CGRectMake(300, 400, 100, 100)];
        [_starBtn setTitle:@"Push" forState:UIControlStateNormal];
        [_starBtn addTarget:self action:@selector(showChildAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _starBtn;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
