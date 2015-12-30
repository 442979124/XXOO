//
//  BallNewsViewController.m
//  NBABattle
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 高歌. All rights reserved.
//

#import "BallNewsViewController.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "BallNewsCell.h"
#import "BallNewsModel.h"
#import "BallSubjectViewController.h"

@interface BallNewsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    BallNewsModel *newsModel;
    ResultModel *resultModel;
    
    
}

@end

@implementation BallNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    [self createTableView];
    [self loadDataForNet];

    
}
- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorStyle = NO;
    _tableView.delegate = self;
    _tableView.dataSource =self;
    
    UIImage *image = [UIImage imageNamed:@"nba6"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-44-64);
    _tableView.backgroundView = imageView;
    [self.view addSubview:_tableView];
}
- (void)loadDataForNet{
    NSString *url = @"http://games.mobileapi.hupu.com/1/7.0.5/nba/getNews?client=357139052148058&night=0";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
        newsModel = [[BallNewsModel alloc]initWithData:responseObject error:nil];
        
        [_dataArray addObjectsFromArray:newsModel.result.data];
        [_tableView reloadData];
        NSLog(@"%@",_dataArray);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idntifier = @"cellId";
    BallNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:idntifier];
    if(cell == nil){
        cell = [[BallNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idntifier];
    }
    [cell initWithDataWith:_dataArray[indexPath.row]];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BallSubjectViewController *ballsubjectVC = [[BallSubjectViewController alloc]init];
    ballsubjectVC.model  =  _dataArray[indexPath.row];
    [self.navigationController pushViewController:ballsubjectVC animated:YES];
    
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
