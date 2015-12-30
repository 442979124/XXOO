//
//  BallBasePicViewController.m
//  NBABattle
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 高歌. All rights reserved.
//

#import "BallBasePicViewController.h"
#import "BallSkimViewController.h"

@interface BallBasePicViewController (){
    NSArray *_imageNames;
    UIScrollView *_scrollView;
    NSString *_title;
}

@end

@implementation BallBasePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置导航条上的标题
    self.navigationItem.title = [NSString stringWithFormat:@"%@(%lu)",_title,_imageNames.count];
    //创建滚动视图
    [self createScrollView];
}
- (instancetype)initWithImageNames:(NSArray *)imageNames titleName:(NSString *)title
{
    if (self = [super init]) {
        _imageNames = [[NSArray alloc] initWithArray:imageNames];
        _title = [NSString stringWithString:title];
    }
    return self;
}
- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    CGSize size = self.view.frame.size;
    _scrollView.frame = CGRectMake(0, 64, size.width, size.height-64-49);
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_scrollView];
    //贴图
    [self createScrollImages];
}

- (void)createScrollImages
{
    CGSize size = _scrollView.frame.size;
    CGFloat gap = 3;
    CGFloat width = (size.width-5*gap)/4;
    CGFloat height = width*3/2;
    for (NSUInteger i=0; i<_imageNames.count; i++) {
        UIImage *image = [UIImage imageNamed:_imageNames[i]];
        UIImageView *view = [[UIImageView alloc] initWithImage:image];
        view.frame = CGRectMake(gap+i%4*(gap+width), gap+i/4*(gap+height), width, height);
        //使用tag记录图片序号
        view.tag = i;
        //添加点击手势，用于切换到浏览视图
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
        [view addGestureRecognizer:tgr];
        [_scrollView addSubview:view];
    }
    //设置滚动视图内容尺寸
    _scrollView.contentSize = CGSizeMake(size.width, (_imageNames.count+3)/4*(gap+height)+gap);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tapGestureHandle:(UITapGestureRecognizer *)tgr
{
    //获取点击的图片序号
    NSInteger index = tgr.view.tag;
    BallSkimViewController *svc = [[BallSkimViewController alloc]initWithImageNames:_imageNames index:index];
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
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
