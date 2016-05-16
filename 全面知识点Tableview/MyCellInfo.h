//
//  MyCellInfo.h
//  全面知识点Tableview
//
//  Created by 侯英格 on 16/5/16.
//  Copyright © 2016年 侯英格. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCellInfo : NSObject

@property(nonatomic,assign)float height;
@property(nonatomic,strong)NSIndexPath*indexPath;

@property(nonatomic,copy)NSString*title;
@property(nonatomic,copy)NSString*content;
@property(nonatomic,copy)NSString*imageUrl;

@end
