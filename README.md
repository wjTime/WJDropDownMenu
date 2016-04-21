# WJDropDownMenu
fast dropdwon menu
效果图如下:
![ABC](http://g.recordit.co/zge0aMZwnU.gif)

    //  平时工作需要有个下拉菜单，所以简单的封装了一个菜单功能，不需要遵循类似tableView的代理方法，直接导入数据就可以用，大家可以做一个参考使用,以下是demo
    //  如有任何bug或不足之处请在github不上找我，我会第一时间回复修正。
    效果图：
    
    

    //  如果是有导航栏请清除自动适应设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *threeMenuTitleArray =  @[@"菜单A",@"菜单B",@"菜单C"];

    
    // 创建menu
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    menu.delegate = self;         //  设置代理
    [self.view addSubview:menu];
    
    // 设置属性(可不设置)
    menu.caverAnimationTime = 0.2;//  增加了遮盖层动画时间设置   不设置默认是  0.15
    menu.menuTitleFont = 12;      //  设置menuTitle字体大小    不设置默认是  11
    menu.tableTitleFont = 11;     //  设置tableTitle字体大小   不设置默认是  10
    menu.cellHeight = 50;         //  设置tableViewcell高度   不设置默认是   30
    menu.menuArrowStyle = menuArrowStyleHollow;// 设置菜单的旋转箭头的样式
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    
    /* 此处有两种方法导入数据 
    1.第一种是直接导入菜单一级子菜单二级子菜单三级子菜单的所有数据  2.第二种是根据每次点击index的请求数据后返回下一菜单的数据时导入数据一级一级联动的网络请求数据所有的方法都是以net开头
    */
    
    // 第一种方法一次性导入所有菜单数据
    [self createAllMenuData];

    // 第二中方法net网络请求一级一级导入数据，先在此导入菜单数据，然后分别再后面的net开头的代理方法中导入一级一级子菜单的数据
    //[menu netCreateThreeMenuTitleArray:threeMenuTitleArray];
    
    // 代理方法返回点击时对应的index
    //(void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex andSecondIndex:(NSInteger)secondIndex{}
    //  代理方法返回点击时对应的内容
    //(void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent andSecondContent:(NSString *)secondContent{}
    
    // 点击收缩menu
    [menu drawBackMenu];
    
    #pragma mark -- net网络获取数据代理方法返回点击时菜单对应的index(导入子菜单数据)
    - (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle;
    - (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle FirstIndex:(NSInteger)FirstIndex firstContent:(NSString *)firstContent;
    
    
    
    
    
    


