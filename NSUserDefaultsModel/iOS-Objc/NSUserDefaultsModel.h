//
//  NSUserDefaultsModel.h
//  NSUserDefaultsModel
//
//  Created by liuchong on 2018/7/19.
//  Copyright © 2018年 lc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultsModel : NSObject

// Value types
typedef NS_ENUM(NSInteger, NSUserDefaultsValueType) {
    NSUserDefaultsValueTypeInteger,         // NSInteger
    NSUserDefaultsValueTypeLong,            // Include:long,long long,short and unsigned
    NSUserDefaultsValueTypeFloat,
    NSUserDefaultsValueTypeDouble,
    NSUserDefaultsValueTypeBool,
    NSUserDefaultsValueTypeObject,
    NSUserDefaultsValueTypeUnknown
};

// Init
+ (instancetype)userDefaultsModel;

// Set default values
/**
 * Override this method,you can setup default values
 * Description: If the object has two properties such as 'name' and 'gender',you should return @{@"name": @"defaultName", @"gender": @defaultGender}
 */
- (NSDictionary *)setupDefaultValues;

/**
 * Override this method,you can setup NSUserDefaults‘ suiteName.
 */
- (NSString *)_suiteName;

@end
