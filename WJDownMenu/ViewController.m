//
//  ViewController.m
//  WJDownMenu
//
//  Created by 高文杰 on 16/1/24.
//  Copyright © 2016年 高文杰. All rights reserved.
//

#import "ViewController.h"
#import "WJDropdownMenu.h"

@interface ViewController () <WJMenuDelegate>



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 平时工作需要有个下拉菜单所以简单的封装了一个菜单功能很简单也没有优化可为大家做一个参考,以下是demo
    
    //  创建标题菜单
//    NSArray *oneMenuTitleArray =   @[@"菜单A"];
//    NSArray *twoMenuTitleArray =   @[@"菜单A",@"菜单B"];
//    NSArray *threeMenuTitleArray = @[@"菜单A",@"菜单B",@"菜单C"];
    NSArray *fourMenuTitleArray =  @[@"菜单A",@"菜单B",@"菜单C",@"菜单D"];
    
    
    //  创建第一个菜单的first数据second数据
    NSArray *firstArrOne = [NSArray arrayWithObjects:@"A一级菜单1",@"A一级菜单2",@"A一级菜单3", nil];
    NSArray *secondArrOne = @[@[@"A二级菜单11",@"A二级菜单12"],@[@"A二级菜单21",@"A二级菜单22",@"A二级菜单23"],@[@"A二级菜单31",@"A二级菜单32",@"A二级菜单33",@"A二级菜单34"]];
    NSArray *firstMenu = [NSArray arrayWithObjects:firstArrOne,secondArrOne, nil];
    
    //  创建第二个菜单的first数据second数据
    NSArray *firstArrTwo = [NSArray arrayWithObjects:@"B一级菜单1",@"B一级菜单2", nil];
    NSArray *secondArrTwo = @[@[@"B二级菜单11",@"B二级菜单12"],@[@"B二级菜单21",@"B二级菜单22"]];
    NSArray *secondMenu = [NSArray arrayWithObjects:firstArrTwo,secondArrTwo, nil];
    
    //  创建第三个菜单的first数据second数据
    NSArray *firstArrThree = [NSArray arrayWithObjects:@"C一级菜单1",@"C一级菜单2", nil];
    NSArray *secondArrThree = @[@[@"C二级菜单11",@"C二级菜单12"],@[@"C二级菜单21",@"C二级菜单22"]];
    NSArray *threeMenu = [NSArray arrayWithObjects:firstArrThree,secondArrThree, nil];
    
    //  创建第四个菜单的first数据second数据
    NSArray *firstArrFour = [NSArray arrayWithObjects:@"D一级菜单1",@"D一级菜单2", nil];
    NSArray *secondArrFour = @[@[@"D二级菜单11",@"D二级菜单12"],@[@"D二级菜单21",@"D二级菜单22"]];
    NSArray *fourMenu = [NSArray arrayWithObjects:firstArrFour,secondArrFour, nil];
    
    //  size已固定可以随便填已固定
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 100, 0, 0)];
    
    
    menu.delegate = self;
    
    [self.view addSubview:menu];
    
    // 一组菜单
    //[self createOneMenuTitleArray:oneMenuTitleArray FirstArray:firstMenu];
    
    // 二组菜单
    //[menu createTwoMenuTitleArray:twoMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu];
    
    // 三组菜单
    //[menu createThreeMenuTitleArray:threeMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu threeArr:threeMenu];
    
    // 四组菜单
    [menu createFourMenuTitleArray:fourMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu threeArr:threeMenu fourArr:fourMenu];
    
}
- (void)menuCellDidSelected:(NSInteger)MenuIndex andDetailIndex:(NSInteger)DetailIndex{
    NSLog(@"菜单数:%ld 子菜单数:%ld",MenuIndex,DetailIndex);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
