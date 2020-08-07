//
//  LCChildViewController.m
//  LCRouter_Example
//
//  Created by 刘彬 on 2020/8/6.
//  Copyright © 2020 liubin. All rights reserved.
//

#import "LCChildViewController.h"

@interface LCChildViewController ()

@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UILabel *ageLab;
@property (nonatomic, strong) UILabel *nameLab;

@end

@implementation LCChildViewController

- (void)dealloc {
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (kIsValidStr(self.age)) {
        self.ageLab.text = [self.ageLab.text stringByAppendingString:self.age];
    }
    if (kIsValidStr(self.name)) {
        self.nameLab.text = [self.nameLab.text stringByAppendingString:self.name];
    }
    
}
#pragma mark - private

- (void)initView {
    self.title = @"孩子";
    [self.view addSubview:self.ageLab];
    [self.view addSubview:self.nameLab];
}

#pragma mark - Lazy

- (UILabel *)ageLab {
    if (!_ageLab) {
        _ageLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, 200, 30)];
        [_ageLab setFont:[UIFont systemFontOfSize:20]];
        [_ageLab setText:@"年龄："];
        [_ageLab setTextColor:[UIColor blackColor]];
    }
    return _ageLab;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 340, 200, 30)];
        [_nameLab setFont:[UIFont systemFontOfSize:20]];
        [_nameLab setText:@"姓名："];
        [_nameLab setTextColor:[UIColor blackColor]];
    }
    return _nameLab;
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
