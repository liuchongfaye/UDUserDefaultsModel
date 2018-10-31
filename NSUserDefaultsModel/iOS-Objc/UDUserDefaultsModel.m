//
//  UDUserDefaultsModel.m
//  UDUserDefaultsModel
//
//  Created by liuchong on 2018/7/19.
//  Copyright © 2018年 lc. All rights reserved.
//

#import "UDUserDefaultsModel.h"
#import <objc/runtime.h>

@interface UDUserDefaultsModel ()

@property (nonatomic, strong) NSMutableDictionary *properties;
@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation UDUserDefaultsModel

#pragma mark - Init

+ (instancetype)userDefaultsModel {
    static id model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[[self class] alloc] init];
    });
    
    return model;
}

- (instancetype)init {
    if (self = [super init]) {
        if ([self respondsToSelector:@selector(setupDefaultValues)]) {
            NSDictionary *defaults = [self setupDefaultValues];
            if (defaults) {
                [self.userDefaults registerDefaults:defaults];
                [self exchangeAccessMethods];
            }
        }
    }
    
    return self;
}

- (NSDictionary *)setupDefaultValues {
    return nil;
}

- (NSString *)_suiteName {
    return nil;
}

#pragma mark - Processing Data

- (void)exchangeAccessMethods {
    unsigned int count = 0;

    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int index = 0; index < count; index++) {
        objc_property_t property = propertyList[index];
        const char *propertyName = property_getName(property);
        const char *propertyAttributes = property_getAttributes(property);
        
        NSString *getterKey = [NSString stringWithFormat:@"%s", propertyName];
        NSString *setterKey = [NSString stringWithFormat:@"set%@%@:", [[getterKey substringToIndex:1] uppercaseString], [getterKey substringFromIndex:1]];
        if (getterKey && getterKey.length > 0) {
            SEL getterSelector = NSSelectorFromString(getterKey);
            SEL setterSelector = NSSelectorFromString(setterKey);
            self.properties[getterKey] = getterKey;
            self.properties[setterKey] = getterKey;
            
            IMP getterImp = NULL;
            IMP setterImp = NULL;
            // Data type
            char type = propertyAttributes[1];
            if (type == '@') {
                getterImp = (IMP)getObgectValue;
                setterImp = (IMP)setObjectValue;
            }else if (type == 'B') {
                getterImp = (IMP)getBoolValue;
                setterImp = (IMP)setBoolValue;
            } else if (type == 'i') {
                getterImp = (IMP)getIntegerValue;
                setterImp = (IMP)setIntegerValue;
            } else if (type == 'd') {
                getterImp = (IMP)getDoubleValue;
                setterImp = (IMP)setDoubleValue;
            } else if (type == 'f') {
                getterImp = (IMP)getFloatValue;
                setterImp = (IMP)setFloatValue;
            } else if (type == 's' || type == 'l' || type == 'q' || type == 'S' || type == 'I' || type == 'L' || type == 'Q') {
                getterImp = (IMP)getLongValue;
                setterImp = (IMP)setLongValue;
            } else {
                NSLog(@"Warning:Unsupported type ,property = '%@'", getterKey);
                break;
            }
            
            char getterYypes[3] = "v@:";
            getterYypes[0] = type;
            class_addMethod([self class], getterSelector, getterImp, getterYypes);

            char setterTypes[4] = "v@:";
            setterTypes[3] = type;
            class_addMethod([self class], setterSelector, setterImp, setterTypes);
        }
    }
    free(propertyList); // release
}

#pragma mark - Override Methods

- (NSMutableDictionary *)properties {
    if (!_properties) {
        _properties = [NSMutableDictionary dictionary];
    }
    return _properties;
}

- (NSUserDefaults *)userDefaults {
    if (!_userDefaults) {
        // iOS6.0
        NSString *suiteName = nil;
        if ([NSUserDefaults instancesRespondToSelector:@selector(initWithSuiteName:)]) {
            suiteName = [self _suiteName];
        }
        
        if (suiteName && suiteName.length > 0) {
            _userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
        } else {
            _userDefaults = [NSUserDefaults standardUserDefaults];
        }
    }
    
    return _userDefaults;
}

#pragma mark - Private Methods

/**
 * Setter And Getter Methods
 */

// Object
static id getObgectValue(UDUserDefaultsModel *model, SEL sel) {
    NSUserDefaults *userDefaults = model.userDefaults;
    return [userDefaults objectForKey:model.properties[NSStringFromSelector(sel)]];
}

static void setObjectValue(UDUserDefaultsModel *model, SEL sel, id value) {
    NSUserDefaults *userDefaults = model.userDefaults;
    if (value) {
        [userDefaults setObject:value forKey:model.properties[NSStringFromSelector(sel)]];
    } else {
        [userDefaults removeObjectForKey:model.properties[NSStringFromSelector(sel)]];
    }
    [userDefaults synchronize];
}

// Bool
static BOOL getBoolValue(UDUserDefaultsModel *model, SEL sel) {
    NSUserDefaults *userDefaults = model.userDefaults;
    return [userDefaults boolForKey:model.properties[NSStringFromSelector(sel)]];
}

static void setBoolValue(UDUserDefaultsModel *model, SEL sel, BOOL value) {
    NSUserDefaults *userDefaults = model.userDefaults;
    [userDefaults setBool:value forKey:model.properties[NSStringFromSelector(sel)]];
    [userDefaults synchronize];
}

// Integer
static NSInteger getIntegerValue(UDUserDefaultsModel *model, SEL sel) {
    NSUserDefaults *userDefaults = model.userDefaults;
    return [userDefaults integerForKey:model.properties[NSStringFromSelector(sel)]];
}

static void setIntegerValue(UDUserDefaultsModel *model, SEL sel, NSInteger value) {
    NSUserDefaults *userDefaults = model.userDefaults;
    [userDefaults setInteger:value forKey:model.properties[NSStringFromSelector(sel)]];
    [userDefaults synchronize];
}

// Double
static double getDoubleValue(UDUserDefaultsModel *model, SEL sel) {
    NSUserDefaults *userDefaults = model.userDefaults;
    return [userDefaults doubleForKey:model.properties[NSStringFromSelector(sel)]];
}

static void setDoubleValue(UDUserDefaultsModel *model, SEL sel, double value) {
    NSUserDefaults *userDefaults = model.userDefaults;
    [userDefaults setDouble:value forKey:model.properties[NSStringFromSelector(sel)]];
    [userDefaults synchronize];
}

// Float
static float getFloatValue(UDUserDefaultsModel *model, SEL sel) {
    NSUserDefaults *userDefaults = model.userDefaults;
    return [userDefaults doubleForKey:model.properties[NSStringFromSelector(sel)]];
}

static void setFloatValue(UDUserDefaultsModel *model, SEL sel, float value) {
    NSUserDefaults *userDefaults = model.userDefaults;
    [userDefaults setFloat:value forKey:model.properties[NSStringFromSelector(sel)]];
    [userDefaults synchronize];
}

// Long
static long long getLongValue(UDUserDefaultsModel *model, SEL sel) {
    NSUserDefaults *userDefaults = model.userDefaults;
    return [[userDefaults objectForKey:model.properties[NSStringFromSelector(sel)]] longLongValue];
}

static void setLongValue(UDUserDefaultsModel *model, SEL sel, long long value) {
    NSUserDefaults *userDefaults = model.userDefaults;
    [userDefaults setObject:@(value) forKey:model.properties[NSStringFromSelector(sel)]];
    [userDefaults synchronize];
}

@end
