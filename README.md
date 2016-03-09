# WJDropDownMenu
fast dropdwon menu

    // 如果是有导航栏请清除自动适应设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *fourMenuTitleArray =  @[@"菜单A",@"菜单B",@"菜单C",@"菜单D"];
    
    
    //  创建第一个菜单的first数据second数据
    NSArray *firstArrOne = [NSArray arrayWithObjects:@"A一级菜单1",@"A一级菜单2",@"A一级菜单3", nil];
    
    /*  -------------------------------2016.03.07 修复了无二级菜单直接点击一级菜单响应的功能-------------------------------
     NSArray *secondArrOne = @[@[@"A二级菜单11",@"A二级菜单12"],@[@"A二级菜单21",@"A二级菜单22",@"A二级菜单23"],@[@"A二级菜单31",@"A二级菜单32",@"A二级菜单33",@"A二级菜单34"]];
     -------------------------------2016.03.07 修复了无二级菜单直接点击一级菜单响应的功能-------------------------------
     */
    
    NSArray *firstMenu = [NSArray arrayWithObject:firstArrOne];
    
    
    
    
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
    
    
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 64, 0, 0)];//  size已固定可以随便填已固定
    menu.caverAnimationTime = 0.2;//  增加了遮盖层动画时间设置 不设置默认是 0.15
    menu.menuTitleFont = 12;      //  设置menuTitle字体大小 默认不设置是  11
    menu.tableTitleFont = 11;     //  设置tableTitle字体大小 默认不设置是 10
    menu.delegate = self;         //  设置代理
    
    [self.view addSubview:menu];
    
    // 一组菜单调用方法
    //[self createOneMenuTitleArray:oneMenuTitleArray FirstArray:firstMenu];
    
    // 二组菜单调用方法
    //[menu createTwoMenuTitleArray:twoMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu];
    
    // 三组菜单调用方法
    //[menu createThreeMenuTitleArray:threeMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu threeArr:threeMenu];
    
    // 四组菜单调用方法
    [menu createFourMenuTitleArray:fourMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu threeArr:threeMenu fourArr:fourMenu];
    
}
- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex andSecondIndex:(NSInteger)secondIndex{
      NSLog(@"菜单数:%ld          一级菜单数:%ld      二级子菜单数:%ld",MenuTitleIndex,firstIndex,secondIndex);
}
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent andSecondContent:(NSString *)secondContent{
      NSLog(@"菜单title:%@       一级菜单:%@         二级子菜单:%@",MenuTitle,firstContent,secondContent);
}
