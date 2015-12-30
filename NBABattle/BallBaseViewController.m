//
//  BallBaseViewController.m
//  NBABattle
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 高歌. All rights reserved.
//

#import "BallBaseViewController.h"
#import "BallGameViewController.h"
#import "BallNewsViewController.h"
#import "BallAmuseViewController.h"
#import "BallPictureViewController.h"
@interface BallBaseViewController (){
     UIImageView *_imageView;
}

@end

@implementation BallBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customTaBar];
    [self customButton];
    [self createImage];
//    [self createToolView];

    // Do any additional setup after loading the view.
}
//- (void)createToolView{
//    UINavigationBar *bar = self.navigationController.navigationBar;
//    UIImage *imageBar = [UIImage imageNamed:@"nbadaohang"];
//    [bar setBackgroundImage:imageBar forBarMetrics:UIBarMetricsDefault];
//    
//}

- (void)createImage{
    UIImage *image = [UIImage imageNamed:@"back.jpg"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-44-64);
    [self.view addSubview:imageView];
}
- (void)customTaBar{
    UIImage *image = [[UIImage imageNamed:@"点击效果@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _imageView = [[UIImageView alloc]initWithImage:image];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    _imageView.frame = CGRectMake(0,height-70 , width, 70);
    [self.view addSubview:_imageView];
}
- (void)customButton{
    
    NSArray *arr = @[@"看球",@"新闻",@"美图",@"娱乐"];
    for(NSInteger i=0;i<arr.count;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        CGFloat size = self.view.frame.size.width/4 - 50;
        CGFloat height = self.view.frame.size.height;
        button.frame = CGRectMake((size+50)*i,height-38 , size+40, 50);
        UIImage *faceimage = [UIImage imageNamed:@"lanqiu"];
        UIImageView *faceView = [[UIImageView alloc]initWithImage:faceimage];
        faceView.frame = CGRectMake((size+50)*i+25, height-48, 25, 25);
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self.view addSubview:faceView];
        
    }
}
- (void)buttonAction:(UIButton *)button{
    switch (button.tag) {
        case 100:{
            BallGameViewController *gameVC = [[BallGameViewController alloc]init];
            [self presentViewController:gameVC animated:YES completion:nil];
            
            
        }
            break;
        case 101:{
            BallNewsViewController *newsVC = [[BallNewsViewController alloc]init];
            [self.navigationController pushViewController:newsVC animated:YES];
            
        }
            break;
        case 102:{
            BallPictureViewController *pictureVCC = [[BallPictureViewController alloc]init];
            [self.navigationController pushViewController:pictureVCC animated:YES];
        }
            break;
        case 103:{
            BallAmuseViewController *amuseVC = [[BallAmuseViewController alloc]init];
            [self.navigationController pushViewController:amuseVC animated:YES];
            
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
