
[英文Readme](https://github.com/liuchongfaye/UDUserDefaultsModel/blob/master/README-EN.md)
# UDUserDefaultsModel
 统一管理那些使用NSUserdefaults保存的值.(原库名称：NSUserDefaultsModel)  
 Blog:https://www.jianshu.com/p/681ef055f716  
 YIIFMDB:https://github.com/liuchongfaye/YIIFMDB (FMDB改进方案)  
 **注意:最开始的版本此库是以"NS"开头,但是这样会让人误以为是iOS系统的代码，为此将其改为"UDUserDefaultsModel"**
 ```
 pod 'UDUserDefaultsModel'
 ```

## How to use

创建一个基于UDUserDefaultsModel的子类，并在.h文件里定义一些属性，这些属性就是用来保存数值的key值，如下:  
```
// .h
@property (nonatomic, copy)    NSString *name;
@property (nonatomic, assign)  NSInteger gender;
@property (nonatomic, assign)  long age;
@property (nonatomic, assign)  float floatNumber;
@property (nonatomic, assign)  double doubleNumber;
@property (nonatomic, assign)  BOOL isMan;
```
接下来，必须要在.m当中对每一个属性执行'@dynamic'操作：  
```
// .m
@dynamic name;
@dynamic gender;
@dynamic age;
@dynamic floatNumber;
@dynamic doubleNumber;
@dynamic isMan;
```
如果想获取'name'，只需要使用 `[Subclass userDefaultsModel].name`就行，里面会自动调用NSUserDefaults的方法去取值。如果想重置'name'，将数据进行更改只需要调用`[Subclass userDefaultsModel].name = @"nickname"`就可以，里面进行了

### 设置默认值
设置默认值：
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

如果想要设置NSUserDefaults的suiteName，那么要在子类里重写`_suiteName`方法,比如：
```
- (NSString *)_suiteName {
    return @"lc.UserDefatults";
}
```
#### 安装与使用
你可以下载下来此工程，随后将'iOS-Objc'文件夹下的类文件导入你的工程.
当然，你也可以使用Cocoapods，只需要在podfile里写入如下代码并执行pod install就可以:
```
pod 'UDUserDefaultsModel'
```

