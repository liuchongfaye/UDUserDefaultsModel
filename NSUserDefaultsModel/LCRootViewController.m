//
//  LCRootViewController.m
//  NSUserDefaultsModel
//
//  Created by 刘冲 on 2018/7/23.
//  Copyright © 2018年 lc. All rights reserved.
//

#import "LCRootViewController.h"
#import "LCUserDefaultsModel.h"

@interface LCRootViewController ()

@end

@implementation LCRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Init
    LCUserDefaultsModel *userDefaultsModel = [LCUserDefaultsModel userDefaultsModel];
    
    NSLog(@"name = %@", userDefaultsModel.name);
    userDefaultsModel.name = @"Near1sssss";
    NSLog(@"gender = %ld", (long)userDefaultsModel.gender);
    userDefaultsModel.gender += 1;
    NSLog(@"age = %ld", userDefaultsModel.age);
    userDefaultsModel.age += 1;
    NSLog(@"floatNumber = %f", userDefaultsModel.floatNumber);
    userDefaultsModel.floatNumber += 1;
    NSLog(@"doubleNumber = %f", userDefaultsModel.doubleNumber);
    userDefaultsModel.doubleNumber += 1;
    NSLog(@"isMan = %d", userDefaultsModel.isMan);
    userDefaultsModel.isMan = !userDefaultsModel.isMan;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
