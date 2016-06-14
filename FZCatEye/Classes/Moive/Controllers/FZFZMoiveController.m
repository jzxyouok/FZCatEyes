//
//  FZFZMoiveController.m
//  FZCatEye
//
//  Created by 李忠 on 6/14/16.
//  Copyright © 2016 李忠. All rights reserved.
//

#import "FZFZMoiveController.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "FZNavTitleView.h"
#import "FZHotLineController.h"
#import "FZToReflect Controller.h"
#import "FZAbroadController.h"
#import "UIView+FZExtension.h"

@interface FZFZMoiveController ()<UIScrollViewDelegate,FZNavTitleViewDelegate>

@property (weak,nonatomic) UIScrollView *scrollView;

//用于控制是否滚动视图滚动带来的backView滚动
@property (assign, nonatomic) BOOL exDelegate;
@property (weak, nonatomic) FZNavTitleView *navTitleView;

@end

@implementation FZFZMoiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupLayout];
}

- (void)setupUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //MARK: 添加Navigation的titleView
    FZNavTitleView *navTitleView = [FZNavTitleView navTitleView];
    _navTitleView = navTitleView;
    navTitleView.delegate = self;
    self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    [self.navigationItem.titleView addSubview:navTitleView];
    
    //MARK: 添加一个滚动视图到View上
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView = scrollView;
    _scrollView.backgroundColor = [UIColor blueColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //MARK: 添加子控件
    [self addChildViewController:[[FZHotLineController alloc] init]];
    [self addChildViewController:[[FZToReflect_Controller alloc] init]];
    [self addChildViewController:[[FZAbroadController alloc] init]];
    
    //MARK: 把子控件的视图添加到scrollView上
    [_scrollView addSubview:self.childViewControllers[0].view];
    [self.childViewControllers[0].view setBackgroundColor:[UIColor yellowColor]];
    [_scrollView addSubview:self.childViewControllers[1].view];
    [self.childViewControllers[1].view setBackgroundColor:[UIColor magentaColor]];
    [_scrollView addSubview:self.childViewControllers[2].view];
    [self.childViewControllers[2].view setBackgroundColor:[UIColor greenColor]];
    
}

- (void)setupLayout{
    
    //MARK: scrollView布局,距离上不内编剧设置64，这样可以靠近导航栏
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    //MARK: 设置子控件在scrollView上的布局
    [self.childViewControllers[0].view makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.leading.bottom.trailing.equalTo(0);
        make.width.equalTo(self.scrollView.width);
        make.height.equalTo(self.scrollView.height);
        
    }];
    
    [self.childViewControllers[1].view makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(0);
        make.leading.equalTo(self.childViewControllers[0].view.trailing);
        make.width.equalTo(self.scrollView.width);
        make.height.equalTo(self.scrollView.height);
    }];
    
    [self.childViewControllers[2].view makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.leading.equalTo(self.childViewControllers[1].view.trailing);
        make.width.equalTo(self.scrollView.width);
        make.height.equalTo(self.scrollView.height);
    }];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.navigationItem.titleView.frame = CGRectMake(0, 0, 150, 30);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //MARK: -设置scrollView的contentSize，因为使用了autolayout技术，所以在这里设置最安全
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3.0, 0);
}

#pragma mark
#pragma mark - FZNavTitleView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (!_exDelegate) {
        
        CGFloat offset = (self.scrollView.contentOffset.x / (3*self.view.fzWidth)) * _navTitleView.fzWidth;
        [_navTitleView scrollCoverView:offset];
        _exDelegate = NO;
        
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _exDelegate = NO;
    CGFloat offset = (self.scrollView.contentOffset.x / (3*self.view.fzWidth)) * _navTitleView.fzWidth;
    
    [_navTitleView scrollEndCoverView:CGPointMake(offset, 0)];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    _exDelegate = NO;
    CGFloat offset = (self.scrollView.contentOffset.x / (3*self.view.fzWidth)) * _navTitleView.fzWidth;
    [_navTitleView scrollEndCoverView:CGPointMake(offset, 0)];
    
}


- (void)beginScroll:(CGFloat)offset{
    
    _exDelegate = YES;
    
    [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
}


@end
