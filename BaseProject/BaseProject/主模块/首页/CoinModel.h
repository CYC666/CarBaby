//
//  CoinModel.h
//  BaseProject
//
//  Created by 曹老师 on 2019/2/25.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinModel : NSObject


@property (copy, nonatomic) NSString *commodityid;
@property (copy, nonatomic) NSString *fullname;
@property (copy, nonatomic) NSString *encode;
@property (copy, nonatomic) NSString *barcode;
@property (copy, nonatomic) NSString *issuedate;
@property (copy, nonatomic) NSString *lastreleaseyear;
@property (copy, nonatomic) NSString *synopsis;
@property (copy, nonatomic) NSString *composition;
@property (copy, nonatomic) NSString *shape;
@property (copy, nonatomic) NSString *weight;
@property (copy, nonatomic) NSString *size;
@property (copy, nonatomic) NSString *facevalue;
@property (copy, nonatomic) NSString *positive;
@property (copy, nonatomic) NSString *back;
@property (copy, nonatomic) NSString *filepath;
@property (copy, nonatomic) NSString *backfilepath;
@property (copy, nonatomic) NSString *des;
@property (copy, nonatomic) NSString *sortcode;
@property (copy, nonatomic) NSString *createdate;
@property (copy, nonatomic) NSString *iscollect;
@property (copy, nonatomic) NSString *currencytypename;

//CommodityId:钱币主键
//FullName：钱币名称
//EnCode：目录编号
//BarCode：国家
//IssueDate：发行日期
//LastReleaseYear：最后发行年份
//Synopsis：使用
//Composition：组成
//Shape：形状
//Weight：重量
//Size：尺寸(直径)
//FaceValue：面值
//Positive：正面
//Back：背面
//FilePath：正面图片
//BackFilePath：背面图片
//Description：备注
//SortCode：排序号
//CreateDate：创建时间
//IsCollect：是否收藏(大于0视为已收藏)
//CurrencyTypeName:币种类型名



@end

NS_ASSUME_NONNULL_END


//"commodityid": "9f77e9a25bf04ab1b8d6032c40fc9e5b",
//"fullname": "500 Ringgit 文莱元",
//"encode": "Pick 31",
//"barcode": "文莱",
//"issuedate": "2006",
//"lastreleaseyear": "--",
//"synopsis": "流通",
//"composition": "聚合物",
//"shape": "矩形",
//"weight": "--",
//"size": "175 X 80mm",
//"facevalue": "500 B$ - 文莱元",
//"positive": "文莱第28任苏丹奥玛尔·阿里·赛福鼎1950一1967年在任",
//"back": "清真寺，清真寺后面的四栋建筑物是购物中心",
//"filepath": "/Resource/Commodity/20180904/d368d6863eb149b3ab5739de94541ed8.png",
//"backfilepath": "/Resource/Commodity/20180904/31ebfe2a85a141baab3f5fd875aa89c8.png",
//"description": " ",
//"sortcode": 14,
//"createdate": "2018-09-04 16:18:29.120",
//"iscollect": 0,
//"currencytypename": "纸币"
