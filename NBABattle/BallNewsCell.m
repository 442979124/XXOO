//
//  BallNewsCell.m
//  NBABattle
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 高歌. All rights reserved.
//

#import "BallNewsCell.h"
#import "BallNewsModel.h"
#import <UIImageView+WebCache.h>

@implementation BallNewsCell{
    UILabel *_titleLable;
    UILabel *_summary;
    UIImageView *_imgView;
    UILabel *_repliesLable;
    UIImageView *_repliesView;
    DataModel *_dataModel;
    
}

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self customSubView];
    }
    return self;
}
- (void)customSubView{
    _titleLable = [UILabel new];
    _titleLable.numberOfLines = 0;
    [self.contentView addSubview:_titleLable];
    _imgView = [UIImageView new];
    [self.contentView addSubview:_imgView];
    _summary = [UILabel new];
    _summary.font = [UIFont systemFontOfSize:15];
    _summary.numberOfLines = 0;
    _summary.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_summary];
    _repliesView = [UIImageView new];
    _repliesView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nba7"]];
    [self.contentView addSubview:_repliesView];
    _repliesLable = [UILabel new];
    _repliesLable.font = [UIFont systemFontOfSize:13];
    _repliesLable.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_repliesLable];
}
- (void)layoutSubviews{
    CGFloat gap = 10;
    CGFloat size = self.contentView.frame.size.width;
    _imgView.frame = CGRectMake(gap, gap, size/4, size/4);
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_dataModel.img]];
    _titleLable.frame = CGRectMake(CGRectGetMaxX(_imgView.frame)+10, gap/2, size-size/4-2*gap, 5*gap);
   _summary.frame = CGRectMake(CGRectGetMaxX(_imgView.frame)+10,gap*3+gap , size-size/4-2*gap, 5*gap);
    _repliesView .frame = CGRectMake(size-3*gap, 8*gap, 2*gap, 2*gap);
    _repliesLable.frame = CGRectMake(size-6*gap, 8*gap, 3*gap, 2*gap);
    
    
    
    
}
- (void)initWithDataWith:(DataModel *)model{
   _titleLable.text  = model.title;
    _summary.text = model.summary;
    _repliesLable.text = model.replies;
    _dataModel = model;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
