//
//  LCUserDefaultsModel.h
//  UserDefaultsModel
//
//  Created by 刘冲 on 2018/7/19.
//  Copyright © 2018年 lc. All rights reserved.
//

#import "NSUserDefaultsModel.h"

@interface LCUserDefaultsModel : NSUserDefaultsModel

@property (nonatomic, copy)    NSString *name;
@property (nonatomic, assign)  NSInteger gender;
@property (nonatomic, assign)  long age;
@property (nonatomic, assign)  float floatNumber;
@property (nonatomic, assign)  double doubleNumber;
@property (nonatomic, assign)  BOOL isMan;

@end
