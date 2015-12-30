//
//  BallPictureViewController.m
//  NBABattle
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 高歌. All rights reserved.
//

#import "BallPictureViewController.h"
#import "BallBasePicViewController.h"

@interface BallPictureViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    NSMutableArray *_imageNames;
    
}


@end

@implementation BallPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createtableView];
    [self createdataSource];
    [self cut];
    self.navigationItem.title = @"一览明星风采";

    // Do any additional setup after loading the view.
}

- (void)createdataSource {
    NSArray *array = @[@"篮球之神",@"当’艾‘成为往事",@"黑曼巴24号毒蛇"];
    _dataSource = [[NSMutableArray alloc] initWithArray:array];
    _imageNames =[[NSMutableArray alloc] init];
}

- (void)createtableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGSize size = self.view.frame.size;
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 64, size.width, size.height-64);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImage *iamge = [UIImage imageNamed:@"nba9"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:iamge];
    imageView.frame = self.view.bounds;
    _tableView.backgroundView = imageView;
    
    // [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    [self.view addSubview:_tableView];
}
- (void)cut {
    NSArray *plists = [[NSBundle mainBundle] pathsForResourcesOfType:@"plist" inDirectory:nil];
    
    for (NSString *plist in plists) {
        
        NSRange range = [plist rangeOfString:@"/" options:NSBackwardsSearch];
        
        NSString *name = [plist substringFromIndex:range.location+1];
        
        if ([name isEqualToString:@"Info.plist"]) {
            continue;
        }
        NSMutableArray *imageNames = [NSMutableArray array];
        NSArray *array = [NSArray arrayWithContentsOfFile:plist];
        for (NSDictionary *dic in array) {
            [imageNames addObject:dic[@"imageName"]];
        }
        [_imageNames addObject:imageNames];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    NSArray *images = @[@"nba8",@"nba8",@"nba8"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [[UIImage imageNamed:images[indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSString *detailTextLabel = [NSString stringWithFormat:@"%@共%lu张图片",_dataSource[indexPath.row],[_imageNames[indexPath.row] count]];
    cell.detailTextLabel.text = detailTextLabel;
    cell.textLabel.text = _dataSource[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BallBasePicViewController *bvc = [[BallBasePicViewController alloc] initWithImageNames:_imageNames[indexPath.row] titleName:_dataSource[indexPath.row]];
    [self.navigationController pushViewController:bvc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
