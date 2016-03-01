# WJDropDownMenu
fast dropdwon menu

//  创建一级数据
NSArray *fourMenuTitleArray =  @[@"菜单A",@"菜单B",@"菜单C",@"菜单D"];

//  创建二级数据
NSArray *firstArrFour = [NSArray arrayWithObjects:@"D1级菜单1",@"D1级菜单2", nil];
NSArray *secondArrFour = @[@[@"D2级菜单11",@"D2级菜单12"],@[@"D2级菜单21",@"D2级菜单22"]];
NSArray *fourMenu = [NSArray arrayWithObjects:firstArrFour,secondArrFour, nil];

//  size已固定可以随便填已固定
WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 100, 0, 0)];

// 设置代理
menu.delegate = self;

// 添加到视图
[self.view addSubview:menu];
