//
//  BallSkimViewController.m
//  NBABattle
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 高歌. All rights reserved.
//

#import "BallSkimViewController.h"

@interface BallSkimViewController ()<UIScrollViewDelegate>{
    NSInteger _index;
    NSArray *_imageNames;
    NSMutableArray *_imageViews;
    UIScrollView *_scrollView;
}

@end

@implementation BallSkimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建滚动视图
    [self createScrollView];
    //创建循环复用的三个图片视图
    [self createScrollImageViews];
    //刷新标题
    [self refreshTitle];

    // Do any additional setup after loading the view.
}
- (instancetype)initWithImageNames:(NSArray *)imageNames index:(NSInteger)index
{
    if (self = [super init]) {
        _index = index;
        _imageNames = [[NSArray alloc] initWithArray:imageNames];
    }
    return self;
}

- (void)createScrollView
{
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = self.view.frame;
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    //设置代理
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
}
- (void)createScrollImageViews
{
    _imageViews = [[NSMutableArray alloc] init];
    
    CGSize size = _scrollView.frame.size;
    //创建三个图片视图
    for (NSUInteger i=0; i<3; i++) {
        UIImageView *view = [[UIImageView alloc] init];
        view.frame = CGRectMake(i*size.width, 0, size.width, size.height);
        //设置填充模式
        view.backgroundColor = [UIColor blackColor];
        view.contentMode = UIViewContentModeScaleAspectFit;
        //计算贴图的序号
        view.tag = (_index+i-1+_imageNames.count)%_imageNames.count;
        //贴图
        [self setImageToView:view];
        
        if (i != 1) {
            //添加到滚动视图上
            [_scrollView addSubview:view];
        } else {
            //创建新的滚动视图
            UIScrollView *sv = [[UIScrollView alloc] init];
            sv.frame = view.frame;
            view.frame = CGRectMake(0, 0, size.width, size.height);
            //允许交互
            view.userInteractionEnabled = YES;
            //添加手势
            //单击
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
            [view addGestureRecognizer:singleTap];
            //双击
            UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
            doubleTap.numberOfTapsRequired = 2;
            [view addGestureRecognizer:doubleTap];
            
            //双击手势识别失败才能识别单击手势
            [singleTap requireGestureRecognizerToFail:doubleTap];
            [sv addSubview:view];
            
            //缩放设置
            sv.minimumZoomScale = 0.2;
            sv.maximumZoomScale = 2.0;
            //设置代理
            sv.delegate = self;
            
            [_scrollView addSubview:sv];
        }
        //保存到数组中
        [_imageViews addObject:view];
    }
    //设置内容尺寸
    _scrollView.contentSize = CGSizeMake(3*size.width, size.height);
    //设置内容偏移
    _scrollView.contentOffset = CGPointMake(size.width, 0);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden
{
    //与导航条状态一致
    return self.navigationController.navigationBarHidden;
}

- (void)tapGestureHandle:(UITapGestureRecognizer *)tgr
{
    if (tgr.numberOfTapsRequired == 1) {
        //单击
        BOOL flag = !self.navigationController.navigationBarHidden;
        [self.navigationController setNavigationBarHidden:flag animated:YES];
        [self setNeedsStatusBarAppearanceUpdate];
    } else if (tgr.numberOfTapsRequired == 2) {
        //双击
        //找到用于缩放的滚动视图
        UIScrollView *sv = (UIScrollView *)[tgr.view superview];
        CGFloat maximumScale = sv.maximumZoomScale;
        if (sv.zoomScale != 1.0) {
            [sv setZoomScale:1.0 animated:YES];
        } else {
            [sv setZoomScale:maximumScale animated:YES];
        }
    }
}

- (void)setImageToView:(UIImageView *)view
{
    NSString *name = _imageNames[view.tag];
    NSArray *array = [name componentsSeparatedByString:@"."];
    NSString *path = [[NSBundle mainBundle] pathForResource:array[0] ofType:array[1]];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    view.image = image;
}

- (void)cycleReuse
{
    int flag = 0;
    //获取滚动视图尺寸
    CGSize size = _scrollView.frame.size;
    //获取偏移量
    CGFloat offsetX = _scrollView.contentOffset.x;
    if (offsetX == 2*size.width) {
        //向左滑
        flag = 1;
    } else if (offsetX == 0) {
        //向右滑
        flag = -1;
    } else {
        return;
    }
    //更新每张视图的图片
    for (UIImageView *view in _imageViews) {
        view.tag = (view.tag+flag+_imageNames.count)%_imageNames.count;
        [self setImageToView:view];
    }
    //无动画的设置偏移量为原始位置
    _scrollView.contentOffset = CGPointMake(size.width, 0);
    //刷新标题
    [self refreshTitle];
    //还原滚动视图的缩放比例
    UIScrollView *sv = (UIScrollView *)[_imageViews[1] superview];
    sv.zoomScale = 1.0;
}

- (void)refreshTitle
{
    self.navigationItem.title = [NSString stringWithFormat:@"%lu/%lu", [_imageViews[1] tag]+1, _imageNames.count];
}

#pragma mark - 代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self cycleReuse];
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageViews[1];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    //当缩放比例 < 0.5时，自动回到上一视图控制器
    if (scale < 0.5) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
