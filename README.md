# WJDropDownMenu
fast dropdwon menu

    //  不需要遵循类似tableView的代理方法，直接导入数据就可以用，大家可以做一个参考使用

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
    NSArray *secondArrThree = @[@[@"C二级菜单11",@"C二级菜单12"],@[@"C二级菜单21",@"C二级菜单22"]];
    NSArray *threeMenu = [NSArray arrayWithObjects:firstArrThree,secondArrThree, nil];
    
    // 创建menu
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    [self.view addSubview:menu];
    
    // 设置属性(可不设置)
    menu.caverAnimationTime = 0.2;//  增加了遮盖层动画时间设置 不设置默认是 0.15
    menu.menuTitleFont = 12;      //  设置menuTitle字体大小 默认不设置是  11
    menu.tableTitleFont = 11;     //  设置tableTitle字体大小 默认不设置是 10
    menu.delegate = self;         //  设置代理
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    
    // 三组菜单调用方法
    [menu createThreeMenuTitleArray:threeMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu threeArr:threeMenu];
    
    
}
#pragma mark -- 代理方法返回点击时对应的index
- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex andSecondIndex:(NSInteger)secondIndex{

    NSLog(@"菜单数:%ld     一级菜单数:%ld      二级子菜单数:%ld",MenuTitleIndex,firstIndex,secondIndex);
    
}

#pragma mark -- 代理方法返回点击时对应的内容
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent andSecondContent:(NSString *)secondContent{

    NSLog(@"菜单title:%@   一级菜单:%@         二级子菜单:%@",MenuTitle,firstContent,secondContent);
  
}


