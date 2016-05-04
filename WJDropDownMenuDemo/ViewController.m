#import "ViewController.h"
#import "WJDropdownMenu.h"

@interface ViewController () <WJMenuDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic,weak)WJDropdownMenu *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WJDropdownMenu";
    [self createTableView];
    
    //  平时工作需要有个下拉菜单，所以简单的封装了一个菜单功能，不需要遵循类似tableView的代理方法，直接导入数据就可以用，大家可以做一个参考使用,以下是demo，
    //  如有任何bug、不足、功能不全之处请在github不上找我，我会第一时间回复并修正，github:https://github.com/wjTime/WJDropDownMenu.git 实时更新中...
    
    //  如果是有导航栏请清除自动适应设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //NSArray *threeMenuTitleArray =  @[@"菜单A",@"菜单B"];
    
    // 创建menu
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    menu.delegate = self;         //  设置代理
    [self.view addSubview:menu];
    self.menu = menu;
    
    // 设置属性(可不设置)
    menu.caverAnimationTime = 0.2;//  增加了遮盖层动画时间设置   不设置默认是  0.15
    menu.menuTitleFont = 12;      //  设置menuTitle字体大小    不设置默认是  11
    menu.tableTitleFont = 11;     //  设置tableTitle字体大小   不设置默认是  10
    menu.cellHeight = 38;         //  设置tableViewcell高度   不设置默认是  40
    menu.menuArrowStyle = menuArrowStyleSolid; // 旋转箭头的样式(空心箭头 or 实心箭头)
    menu.tableViewMaxHeight = 200; // tableView的最大高度(超过此高度就可以滑动显示)
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    
#warning 此处有两种方法导入数据 1.第一种是直接导入菜单一级子菜单二级子菜单三级子菜单的所有数据  2.第二种是根据每次点击index的请求数据后返回下一菜单的数据时导入数据一级一级联动的网络请求数据所有的方法都是以net开头
    // 第一种方法一次性导入所有菜单数据
    [self createAllMenuData];

    // 第二中方法net网络请求一级一级导入数据，先在此导入菜单数据，然后分别再后面的net开头的代理方法中导入一级一级子菜单的数据
    //[menu netCreateMenuTitleArray:threeMenuTitleArray];
    
    // 设置rightItem点击收缩menu
    [self createRightNav];
    
    
    
}

- (void)createAllMenuData{
    NSArray *threeMenuTitleArray =  @[@"菜单A",@"菜单B",@"菜单C"];
    //  创建第一个菜单的first数据second数据
    NSArray *firstArrOne = [NSArray arrayWithObjects:@"A一级菜单1",@"A一级菜单2",@"A一级菜单3", nil];
    NSArray *firstMenu = [NSArray arrayWithObject:firstArrOne];
    
    //  创建第二个菜单的first数据second数据
    NSArray *firstArrTwo = [NSArray arrayWithObjects:@"B一级菜单1",@"B一级菜单2", nil];
    NSArray *secondArrTwo = @[@[@"B二级菜单11",@"B二级菜单12"],@[@"B二级菜单21",@"B二级菜单22"]];
    NSArray *thirdArrTwo = @[@[@"B三级菜单11-1",@"B三级菜单11-2",@"B三级菜单11-3"],@[@"B三级菜单12-1",@"B三级菜单12-2"],@[@"B三级菜单21-1",@"B三级菜单21-2"],@[@"B三级菜单21-1",@"B三级菜单21-2"],@[@"B三级菜单22-1",@"B三级菜单22-2"]];
    NSArray *secondMenu = [NSArray arrayWithObjects:firstArrTwo,secondArrTwo,thirdArrTwo, nil];
    
    //  创建第三个菜单的first数据second数据
    NSArray *firstArrThree = [NSArray arrayWithObjects:@"C一级菜单1",@"C一级菜单2", nil];
    NSArray *secondArrThree = @[@[@"C二级菜单11",@"C二级菜单12"],@[@"C二级菜单21",@"C二级菜单22",@"C二级菜单23",@"C二级菜单24"]];
    NSArray *threeMenu = [NSArray arrayWithObjects:firstArrThree,secondArrThree, nil];
    
    [self.menu createThreeMenuTitleArray:threeMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu threeArr:threeMenu];
}

- (void)createRightNav{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn setTitle:@"收缩menu" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hideMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)hideMenu{
    //  点击收缩menu
    [self.menu drawBackMenu];
}

#pragma mark -- 代理方法返回点击时对应的index

- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex secondIndex:(NSInteger)secondIndex thirdIndex:(NSInteger)thirdIndex{
    NSLog(@"菜单数:%ld      一级菜单数:%ld      二级子菜单数:%ld  三级子菜单:%ld",MenuTitleIndex,firstIndex,secondIndex,thirdIndex);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:10];
    label.text = [NSString stringWithFormat:@"菜单数:%ld,  一级菜单数:%ld,   二级子菜单数:%ld  三级菜单:%ld",MenuTitleIndex,firstIndex,secondIndex,thirdIndex];
    label.numberOfLines = 2;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-122-100, self.view.frame.size.width, 40+100)];
    label2.backgroundColor = [UIColor lightGrayColor];
    label2.font = [UIFont systemFontOfSize:15];
    label2.numberOfLines = 0;
    label2.lineBreakMode = NSLineBreakByCharWrapping;
    label2.textColor = [UIColor redColor];
    //label2.text = @"此方法是新增的net网络点击加载数据，即子菜单的数据还没有出来，需要点击上级带单时加载网络请求后返回数据再导入一级一级联动的效果，因此模拟了网络加载延迟的效果";
    label2.text = @"第一种方法返回的结果:";
    [self.view addSubview:label2];
    
    
};


#pragma mark -- 代理方法返回点击时对应的内容
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent secondContent:(NSString *)secondContent thirdContent:(NSString *)thirdContent{
    NSLog(@"菜单title:%@       一级菜单:%@         二级子菜单:%@    三级子菜单:%@",MenuTitle,firstContent,secondContent,thirdContent);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-81, self.view.frame.size.width, 40)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:10];
    label.numberOfLines = 2;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = [NSString stringWithFormat:@"菜单title:%@,  一级菜单:%@,   二级子菜单:%@   三级子菜单:%@",MenuTitle,firstContent,secondContent,thirdContent];
    [self.view addSubview:label];
    
    self.data = [NSMutableArray array];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 1",secondContent]];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 2",secondContent]];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 3",secondContent]];
    [self.tableView reloadData];
    
};

#pragma mark -- 代理方法返回点击时对应的内容和index
- (void)menuCellDidSelected:(NSString *)MenuTitle menuIndex:(NSInteger)menuIndex firstContent:(NSString *)firstContent firstIndex:(NSInteger)firstIndex secondContent:(NSString *)secondContent secondIndex:(NSInteger)secondIndex thirdContent:(NSString *)thirdContent thirdIndex:(NSInteger)thirdIndex{
    NSLog(@"菜单title:%@  titleIndex:%ld,一级菜单:%@    一级菜单Index:%ld,     二级子菜单:%@   二级子菜单Index:%ld   三级子菜单:%@  三级子菜单Index:%ld",MenuTitle,menuIndex,firstContent,firstIndex,secondContent,secondIndex,thirdContent,thirdIndex);
}



#if 0

#pragma mark -- net网络获取数据代理方法返回点击时菜单对应的index(导入子菜单数据)
- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle{
    
    // 模拟网络加载数据延时0.5秒，相当于传一个menuIndex的参数返回数据之后 调用netLoadFirstArray方法，将网络请求返回数据导入一级数据到菜单
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (menuIndex == 0) {
            
            NSArray *firstArrTwo = [NSArray arrayWithObjects:@"A一级菜单1",@"A一级菜单2", nil];
            [self.menu netLoadFirstArray:firstArrTwo];
            
        }
        if (menuIndex == 1) {
            NSArray *firstArrTwo = [NSArray arrayWithObjects:@"B一级菜单1",@"B一级菜单2", nil];
            [self.menu netLoadFirstArray:firstArrTwo];
        }
        if (menuIndex == 2) {
            NSArray *firstArrTwo = [NSArray arrayWithObjects:@"C一级菜单1",@"C一级菜单2", nil];
            [self.menu netLoadFirstArray:firstArrTwo];
        }
    });
}


#pragma mark -- net网络获取数据代理方法返回点击时菜单和一级子菜单分别对应的index(导入子菜单数据)
- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle FirstIndex:(NSInteger)FirstIndex firstContent:(NSString *)firstContent{
    
    // 模拟网络加载数据延时0.5秒，相当于传menuIndex、FirstIndex的两个参数返回数据之后，调用 netLoadSecondArray 方法，将网络请求返回数据导入二级数据到菜单
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (menuIndex == 0) {
            if (FirstIndex == 0) {
                NSArray *secondArrTwo = @[@"A二级菜单11",@"A二级菜单12",@"A二级菜单13",@"A二级菜单14",@"A二级菜单15",@"A二级菜单16",@"A二级菜单17",@"A二级菜单18",@"A二级菜单19",@"A二级菜单20",@"A二级菜单11",@"A二级菜单12",@"A二级菜单13",@"A二级菜单14",@"A二级菜单15",@"A二级菜单16",@"A二级菜单17",@"A二级菜单18",@"A二级菜单19",@"A二级菜单20"];
                [self.menu netLoadSecondArray:secondArrTwo];
            }
            if (FirstIndex == 1) {
                NSArray *secondArrTwo = @[@"A二级菜单21",@"A二级菜单22"];
                [self.menu netLoadSecondArray:secondArrTwo];
            }
        }
        if (menuIndex == 1) {
            if (FirstIndex == 0) {
                NSArray *secondArrTwo = @[@"B二级菜单11",@"B二级菜单12"];
                [self.menu netLoadSecondArray:secondArrTwo];
            }
            if (FirstIndex == 1) {
                NSArray *secondArrTwo = @[@"B二级菜单21",@"B二级菜单22"];
                [self.menu netLoadSecondArray:secondArrTwo];
            }
        }
        if (menuIndex == 2) {
            if (FirstIndex == 0) {
                NSArray *secondArrTwo = @[@"C二级菜单11",@"C二级菜单12"];
                [self.menu netLoadSecondArray:secondArrTwo];
                
            }
            if (FirstIndex == 1) {
                NSArray *secondArrTwo = @[@"C二级菜单21",@"C二级菜单22"];
                [self.menu netLoadSecondArray:secondArrTwo];
            }
        }
        
    });
}




#endif

#pragma mark -- tableview

- (void)createTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-104-122) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.data[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
