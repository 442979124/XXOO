//
//  BallNewsModel.h
//  NBABattle
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 高歌. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol DataModel
@end
@interface DataModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *nid;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *summary;
@property (nonatomic, copy) NSString<Optional> *uptime;
@property (nonatomic, copy) NSString<Optional> *img;
@property (nonatomic, copy) NSString<Optional> *type;
@property (nonatomic, copy) NSString<Optional> *lights;
@property (nonatomic, copy) NSString<Optional> *replies;
@property (nonatomic, copy) NSString<Optional>*read;
@end

@interface ResultModel : JSONModel
@property (nonatomic, copy)NSString<Optional> *nextDataExists;
@property (nonatomic, strong) NSMutableArray<Optional,DataModel> *data;

@end


@interface BallNewsModel : JSONModel
@property (nonatomic, strong) ResultModel<Optional> *result;
@property (nonatomic, copy) NSString<Optional> *is_login;


@end
