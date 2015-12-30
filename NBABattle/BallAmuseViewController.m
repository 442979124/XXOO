//
//  BallAmuseViewController.m
//  NBABattle
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 高歌. All rights reserved.
//

#import "BallAmuseViewController.h"
#import "FeiJiViewController.h"
#import "DIShuViewController.h"
#import "PinTuViewController.h"

@interface BallAmuseViewController (){
    UIImageView *_imageView;
}

@end

@implementation BallAmuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createImage];
    [self createButton];
    // Do any additional setup after loading the view.
}
- (void)createImage{
    UIImage *image = [UIImage imageNamed:@"艾弗森02"];
    _imageView = [[UIImageView alloc]initWithImage:image];
    _imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_imageView];
    
}
- (void)createButton{
    
    NSArray *marr = @[@"詹姆斯打飞机🐒",@"科比和你拼🐍",@"你敢打乔丹🙀"];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    for(NSInteger i=0;i<marr.count;i++){
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame =CGRectMake(width/3+50, height-300+i*(50+10),width/4+100 ,50);
        [button setTitle:marr[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
        button.layer.cornerRadius = 15;
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
}
- (void)buttonAction1:(UIButton *)button{
    
    switch (button.tag) {
        case 100:
        {
            FeiJiViewController *feijeVC = [[FeiJiViewController alloc]init];
            [self.navigationController pushViewController:feijeVC animated:YES];
        }
            break;
        case 101:{
            PinTuViewController *pintuVC = [[PinTuViewController alloc]init];
            [self.navigationController pushViewController:pintuVC animated:YES];
            
        }
            break;
        case 102:{
            
            DIShuViewController *dishuVC = [[DIShuViewController alloc]init];
            [self.navigationController pushViewController:dishuVC animated:YES];
            
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
