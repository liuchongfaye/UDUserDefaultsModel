//
//  LCUserDefaultsModel.m
//  UDUserDefaultsModel
//
//  Created by 刘冲 on 2018/7/19.
//  Copyright © 2018年 lc. All rights reserved.
//

#import "LCUserDefaultsModel.h"

@implementation LCUserDefaultsModel

@dynamic name;
@dynamic gender;
@dynamic age;
@dynamic floatNumber;
@dynamic doubleNumber;
@dynamic isMan;

#pragma mark - Init

- (NSDictionary *)setupDefaultValues {
    return @{@"name": @"lc",
             @"gender": @1,
             @"age": @20,
             @"floatNumber": @11.1,
             @"doubleNumber": @22.2,
             @"isMan": @YES,
             };
}

- (NSString *)_suiteName {
    return @"lc.UserDefatults";
}

@end
