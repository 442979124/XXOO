//
//  PinTuViewController.m
//  NBABattle
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 高歌. All rights reserved.
//

#import "PinTuViewController.h"


@interface PinTuViewController ()<UIAlertViewDelegate>{
    UIImageView *_emptyView;
    UILabel *_timeLable;
    UILabel *_timeBar;
    NSTimer *_timer;
    BOOL start;
    int _number;


}

@end

@implementation PinTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    _number = 12;
    [self createJigsaw];
    [self createImage];
    [self createLabel];
    [self createTimeBar];
    [self createTimer];

}
- (void)createJigsaw {
    
    UIImage *myGirl = [UIImage imageNamed:@"kebi24.jpg"];
    int a = 4;
    int b =4;
    for (NSUInteger i = 0; i < a*b-1; i++) {
        
        //点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeFrame:)];
        
        CGRect rect = CGRectMake(i%a*(300/a), i/a*(300/a), (300/a), (300/a));
        UIImage *gril = [self clipImage:myGirl withRect:rect];
        
        
        UIImageView *grilView = [[UIImageView alloc] initWithImage:gril];
        grilView.frame = CGRectMake(self.view.center.x-150+i%a*(300/a), self.view.center.y-250+i/a*(300/a), (300/a), (300/a));
        grilView.layer.borderWidth = 1;
        grilView.layer.cornerRadius = 5;
        grilView.clipsToBounds = YES;
        grilView.userInteractionEnabled = YES;
        [grilView addGestureRecognizer:tapGesture];
        grilView.tag = 100 + i;
        
        
        
        [self.view addSubview:grilView];
    }
    
    _emptyView = [[UIImageView alloc] init];
    _emptyView.frame = CGRectMake(self.view.center.x-150+(a-1)*(300/a), self.view.center.y-250+(a-1)*(300/a), (300/a), (300/a));
    _emptyView.tag = 108;
    [self.view addSubview:_emptyView];
    
    
    
}
- (void)changeFrame:(UITapGestureRecognizer *)tap {
    
    NSLog(@"tag = %lu",tap.view.tag);
    NSLog(@"点击了");
    int b=4;
    if ((fabs(tap.view.center.x-_emptyView.center.x) == (300/b)&&tap.view.center.y==_emptyView.center.y)||(fabs(tap.view.center.y-_emptyView.center.y)== (300/b)&&tap.view.center.x==_emptyView.center.x )) {
        
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect = tap.view.frame;
            tap.view.frame = _emptyView.frame;
            _emptyView.frame = rect;
        }];
        
        if (!start) {
            [self fireTimer];
        }
    }
    
    
}

- (void)createTimer {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [self stopTimer];
    start = NO;
    
}

- (void)fireTimer {
    
    [_timer setFireDate:[NSDate distantPast]];
    start = YES;
    
}

- (void)stopTimer {
    
    [_timer setFireDate:[NSDate distantFuture]];
    start = NO;
}
- (void)createLabel {
    _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    _timeLable.center = CGPointMake(self.view.center.x, 50);
    _timeLable.text = @"0";
    _timeLable.font = [UIFont systemFontOfSize:20];
    _timeLable.adjustsFontSizeToFitWidth = YES;
    _timeLable.textAlignment = 1;
    _timeLable.textColor = [UIColor redColor];
    [self.view addSubview:_timeLable ];
    
}
- (void)updateTime {
    
    int c= 12;
    if (_number == 0) {
        [self stopTimer];
        [self createAlertView];
    }
    
    [_timeLable setText:[NSString stringWithFormat:@"%d",_number]];
    [UIView animateWithDuration:0.8 animations:^{
        if (_number) {
            //            _timeBar.frame = CGRectMake(0, (self.view.frame.size.height/TIME_NUM)*(_number-1), 10, self.view.frame.size.height-_number*10+10);
            _timeBar.frame = CGRectMake(0, (self.view.frame.size.height/c)*(c-_number+1), 10, self.view.frame.size.height);
            if (_number <= 10) {
                _timeLable.transform = CGAffineTransformMakeScale(2, 2);
                _timeLable.alpha = 0;
            }
        }
        
        
    } completion:^(BOOL finished) {
        if (_number <= 10) {
            _timeLable.transform = CGAffineTransformMakeScale(1, 1);
            _timeLable.alpha = 1;
            
        }
    }];
    _number -= 1 ;
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        exit(0);
    }else if (buttonIndex == 1){
        _number = 12;
        _timeBar.frame = CGRectMake(0, 0, 10, self.view.frame.size.height);
    }
    
}

- (void)createAlertView {
    
    UIAlertView *altert = [[UIAlertView alloc] initWithTitle:@"游戏结束了!😒" message:@"还玩不玩?" delegate:self cancelButtonTitle:@"不玩了" otherButtonTitles:@"再来一次", nil];
    [altert show];
}
- (void)createTimeBar {
    
    //    _timeBar = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-10, 10, 10)];
    _timeBar = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, self.view.frame.size.height)];
    _timeBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:_timeBar];
    
}

- (void)createImage {
    
    UIImageView *girlView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kebi24.jpg"]];
    
    girlView.frame = CGRectMake(0, 0, 150, 150);
    girlView.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 150);
    
    [self.view addSubview:girlView];
}

//切图
- (UIImage *)clipImage:(UIImage *)image withRect:(CGRect)rect
{
    CGImageRef CGImage = CGImageCreateWithImageInRect(image.CGImage, rect);
    return [UIImage imageWithCGImage:CGImage];
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
