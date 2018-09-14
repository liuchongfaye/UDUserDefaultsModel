# NSUserDefaultsModel
 统一管理那些使用NSUserdefaults保存的值.  
 Blog:https://www.jianshu.com/p/681ef055f716  **注意:好多人跟我说以“NS”开头不好，我仔细想了想的确是有待改善，后续的库我会稍加注意。**

## How to use

Create a subclass of 'NSUserDefaultsModel' and declare some properties in '.h', like this:
```
// .h
@property (nonatomic, copy)    NSString *name;
@property (nonatomic, assign)  NSInteger gender;
@property (nonatomic, assign)  long age;
@property (nonatomic, assign)  float floatNumber;
@property (nonatomic, assign)  double doubleNumber;
@property (nonatomic, assign)  BOOL isMan;
```
Next,you must make those properties `@dynamic` in the .m file,like this:
```
// .m
@dynamic name;
@dynamic gender;
@dynamic age;
@dynamic floatNumber;
@dynamic doubleNumber;
@dynamic isMan;
```
If you want to get the 'name', you just use `[Subclass userDefaultsModel].name`.
If you want to set the 'name' and save it, you just use `[Subclass userDefaultsModel].name = @"nickname"`.

### Setup default values
If you want to set some default values, you just override the method `setupDefaultValues` in .m file,like this:
```
// Setup default values
- (NSDictionary *)setupDefaultValues {
    //@propertyString: @defaultValue
    return @{@"name": @"lc",
             @"gender": @1,
             @"age": @20,
             @"floatNumber": @11.1,
             @"doubleNumber": @22.2,
             @"isMan": @YES,
             };
}
```
#### Installation
You can download this project and drag the code in the 'iOS-Objc' folder to your project.
Of course，you can use Cocoapods.To install it simply add the following line to your Podfile:
```
pod 'NSUserDefaultsModel'
```

