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
    
    self.title = @"WJDropdownMenu";
    
    //  平时工作需要有个下拉菜单，所以简单的封装了一个菜单功能，不需要遵循类似tableView的代理方法，直接导入数据就可以用，大家可以做一个参考使用,以下是demo

    //  如果是有导航栏请清除自动适应设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *threeMenuTitleArray =  @[@"菜单A",@"菜单B",@"菜单C"];

    //  创建第一个菜单的first数据second数据
    NSArray *firstArrOne = [NSArray arrayWithObjects:@"A一级菜单1",@"A一级菜单2",@"A一级菜单3", nil];
    NSArray *firstMenu = [NSArray arrayWithObject:firstArrOne];
    
    //  创建第二个菜单的first数据second数据
    NSArray *firstArrTwo = [NSArray arrayWithObjects:@"B一级菜单1",@"B一级菜单2", nil];
    NSArray *secondArrTwo = @[@[@"B二级菜单11",@"B二级菜单12"],@[@"B二级菜单21",@"B二级菜单22"]];
    NSArray *secondMenu = [NSArray arrayWithObjects:firstArrTwo,secondArrTwo, nil];
    
    //  创建第三个菜单的first数据second数据
    NSArray *firstArrThree = [NSArray arrayWithObjects:@"C一级菜单1",@"C一级菜单2", nil];
    NSArray *secondArrThree = @[@[@"C二级菜单11",@"C二级菜单12"],@[@"C二级菜单21",@"C二级菜单22",@"C二级菜单23",@"C二级菜单24"]];
    NSArray *threeMenu = [NSArray arrayWithObjects:firstArrThree,secondArrThree, nil];
    
    // 创建menu
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    menu.delegate = self;         //  设置代理
    [self.view addSubview:menu];
    
    // 设置属性(可不设置)
    menu.caverAnimationTime = 0.2;//  增加了遮盖层动画时间设置   不设置默认是  0.15
    menu.menuTitleFont = 12;      //  设置menuTitle字体大小    不设置默认是  11
    menu.tableTitleFont = 11;     //  设置tableTitle字体大小   不设置默认是  10
    menu.cellHeight = 50;         //  设置tableViewcell高度   不设置默认是   30
    menu.menuArrowStyle = menuArrowStyleHollow; // 设置菜单旋转箭头的样式 实心三角形 或 空心箭头
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    
    // 三组菜单的数据导入方法
    [menu createThreeMenuTitleArray:threeMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu threeArr:threeMenu];
    
    
    
    
    
}
#pragma mark -- 代理方法返回点击时对应的index
- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex andSecondIndex:(NSInteger)secondIndex{
    NSLog(@"菜单数:%ld          一级菜单数:%ld      二级子菜单数:%ld",MenuTitleIndex,firstIndex,secondIndex);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = [NSString stringWithFormat:@"菜单数:%ld,一级菜单数:%ld,二级子菜单数:%ld",MenuTitleIndex,firstIndex,secondIndex];
    [self.view addSubview:label];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-122, self.view.frame.size.width, 40)];
    label2.backgroundColor = [UIColor lightGrayColor];
    label2.font = [UIFont systemFontOfSize:12];
    label2.text = @"点击返回的结果:";
    [self.view addSubview:label2];
    
}

#pragma mark -- 代理方法返回点击时对应的内容
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent andSecondContent:(NSString *)secondContent{
    NSLog(@"菜单title:%@       一级菜单:%@         二级子菜单:%@",MenuTitle,firstContent,secondContent);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-81, self.view.frame.size.width, 40)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = [NSString stringWithFormat:@"菜单title:%@,一级菜单:%@,二级子菜单:%@",MenuTitle,firstContent,secondContent];
    [self.view addSubview:label];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
