
// 如有任何bug、不足、功能不全之处请在github不上找我



#define cell_h                      40
#define carverAnimationDefalutTime  0.15
#define hideAnimationDefalutTime    0.15
#define tableViewMaxHeightDefalut   300
#define menuButtonDefalutTag        700

#define window_h [UIScreen mainScreen].bounds.size.height
#define menuTitleDefalutFont  [UIFont systemFontOfSize:12]
#define TableTitleDefalutFont [UIFont systemFontOfSize:10]


#import "WJDropdownMenu.h"
#import <UIKit/UIKit.h>


@interface WJDropdownMenu ()

@property (nonatomic,strong) UIView         *backView;
@property (nonatomic,strong) UITableView    *tableFirst;
@property (nonatomic,strong) UITableView    *tableSecond;
@property (nonatomic,strong) UITableView    *tableThird;

@property (nonatomic,strong) NSMutableArray *bgLayers;
@property (nonatomic,strong) NSMutableArray *dataSourceFirst;
@property (nonatomic,strong) NSMutableArray *dataSourceSecond;
@property (nonatomic,strong) NSMutableArray *dataSourceThird;

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSMutableArray *allData;
@property (nonatomic,strong) NSMutableArray *allDataSource;

@property (nonatomic,assign) BOOL           firstTableViewShow;
@property (nonatomic,assign) BOOL           secondTableViewShow;
@property (nonatomic,assign) BOOL           thirdTableViewShow;

@property (nonatomic,assign) NSInteger      lastSelectedIndex;
@property (nonatomic,assign) NSInteger      lastSelectedCellIndex;
@property (nonatomic,assign) NSInteger      lastSecondCellIndex;
@property (nonatomic,assign) NSInteger      num;

@property (nonatomic,assign) CGFloat        tableViewWith;
@property (nonatomic,assign) CGFloat        menuBaseHeight;

@property (nonatomic,assign) BOOL           isNet;


@end


@implementation WJDropdownMenu



- (void)createOneMenuTitleArray:(NSArray *)menuTitleArray FirstArray:(NSArray *)FirstArray{
    self.menuBaseHeight = self.frame.size.height;
    [self createMenuViewWithData:menuTitleArray];
    [self.allDataSource addObject:FirstArray];
    
    [self createThreeTableView];
}
- (void)createTwoMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr{
    self.menuBaseHeight = self.frame.size.height;
    [self createMenuViewWithData:menuTitleArray];
    [self.allDataSource addObject:firstArr];
    [self.allDataSource addObject:secondArr];
    
    [self createThreeTableView];
    
}

- (void)createThreeMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr threeArr:(NSArray *)threeArr{
    self.menuBaseHeight = self.frame.size.height;
    [self createMenuViewWithData:menuTitleArray];
    [self.allDataSource addObject:firstArr];
    [self.allDataSource addObject:secondArr];
    [self.allDataSource addObject:threeArr];
    
    [self createThreeTableView];
    
}


- (void)createThreeTableView{
    
    [self createTableViewFirst];
    [self createTableViewSecond];
    [self createTableViewThird];
}

- (void)createFourMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr threeArr:(NSArray *)threeArr fourArr:(NSArray *)fourArr{
    self.menuBaseHeight = self.frame.size.height;
    [self createMenuViewWithData:menuTitleArray];
    [self.allDataSource addObject:firstArr];
    [self.allDataSource addObject:secondArr];
    [self.allDataSource addObject:threeArr];
    [self.allDataSource addObject:fourArr];
    
    [self createTableViewFirst];
    [self createTableViewSecond];
}

- (void)changeMenuDataWithIndex:(NSInteger)index{
    
    
    [self createWithFirstData:self.allDataSource[index][0]];
    if ([self.allDataSource[index] count] ==1) {
        self.tableViewWith = self.frame.size.width;
        self.allData = nil;
    }else if ([self.allDataSource[index] count] == 2){
        self.tableViewWith = self.frame.size.width/2;
        [self createWithSecondData:self.allDataSource[index][1]];
    }else if ([self.allDataSource[index] count] == 3){
        self.tableViewWith = self.frame.size.width/3;
        [self createWithSecondData:self.allDataSource[index][1]];
        [self createWithThirdData:self.allDataSource[index][2]];
    }
    
    
}
- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    
    if (self.menuArrowStyle == menuArrowStyleSolid) {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(8, 0)];
        [path addLineToPoint:CGPointMake(4, 5)];
        
    }else{
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(5, 5)];
        [path moveToPoint:CGPointMake(5, 5)];
        [path addLineToPoint:CGPointMake(10, 0)];
    }
    
    
    [path closePath];
    layer.path = path.CGPath;
    
    layer.lineWidth = 0.8;
    if (self.menuArrowStyle == menuArrowStyleSolid) {
        layer.fillColor = [UIColor colorWithRed:0xcc/255.0 green:0xcc/255.0 blue:0xcc/255.0 alpha:0xcc/255.0].CGColor;
    }else{
        layer.strokeColor = [UIColor colorWithRed:0xcc/255.0 green:0xcc/255.0 blue:0xcc/255.0 alpha:0xcc/255.0].CGColor;
        layer.fillColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:255/255.0].CGColor;
    }
    
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position = point;
    return layer;
}


- (CALayer *)createBgLayerWithColor:(UIColor *)color andPosition:(CGPoint)position{
    CALayer *layer = [CALayer layer];
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, 20, 20);
    layer.backgroundColor = color.CGColor;
    return layer;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCell"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }else{
        return YES;
    }
   
    
}
- (void)remover{
     NSInteger tempTag = self.menuButtonTag ? self.menuButtonTag :menuButtonDefalutTag;
    CALayer *layer = self.bgLayers[self.lastSelectedIndex-tempTag];
    layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
    
    self.firstTableViewShow = NO;
    [UIView animateWithDuration:self.hideAnimationTime animations:^{
        self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    self.secondTableViewShow = NO;
    [UIView animateWithDuration:self.hideAnimationTime animations:^{
        self.tableSecond.frame = CGRectMake(self.tableViewWith,CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    self.thirdTableViewShow = NO;
    [UIView animateWithDuration:self.hideAnimationTime animations:^{
        self.tableThird.frame = CGRectMake(self.tableViewWith * 2,CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    
    [self hideCarverView];
    
    
}
- (void)createMenuViewWithData:(NSArray *)data{

    self.caverAnimationTime = self.caverAnimationTime ? self.caverAnimationTime : carverAnimationDefalutTime;
    self.hideAnimationTime = self.hideAnimationTime ? self.hideAnimationTime : hideAnimationDefalutTime;
    self.cellHeight = self.cellHeight ? self.cellHeight : cell_h;
    
    self.lastSelectedIndex = -1;
    self.backgroundColor = self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width
                            , self.menuBaseHeight);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remover)];
    [self addGestureRecognizer:tap];
    tap.delegate = self;
    self.bgLayers = [[NSMutableArray alloc]init];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width
                                                            , self.menuBaseHeight)];
    self.backView.userInteractionEnabled = YES;
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    NSInteger num = data.count;
    CGFloat btnW = (self.frame.size.width
                    -num+1)/num;
    for (int i = 0; i < num; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((btnW+1)*i, 0, btnW, self.menuBaseHeight)];
        btn.backgroundColor = [UIColor whiteColor];
        NSInteger tempTag = self.menuButtonTag ? self.menuButtonTag :menuButtonDefalutTag;
        btn.tag = tempTag+i;
        btn.titleLabel.font = self.menuTitleFont ? [UIFont systemFontOfSize:self.menuTitleFont] : menuTitleDefalutFont;
        
        
        UIColor *unSelectedColor = self.unSelectedColor ? self.unSelectedColor : [UIColor grayColor];
        UIColor *selectedColor = self.selectedColor ? self.selectedColor : [UIColor blackColor];
        
        
        [btn setTitleColor:unSelectedColor forState:UIControlStateNormal];
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
        
        [btn setTitle:data[i] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(showFirstTableView:) forControlEvents:UIControlEventTouchUpInside];
        
        CGPoint bgLayerPoint = CGPointMake(self.frame.size.width
                                           /num-10, self.menuBaseHeight/2);
        CALayer *bgLayer = [self createBgLayerWithColor:[UIColor clearColor] andPosition:bgLayerPoint];
        CGPoint indicatorPoint = CGPointMake(10, 10);
        CAShapeLayer *indicator = [self createIndicatorWithColor:[UIColor lightGrayColor] andPosition:indicatorPoint];
        [bgLayer addSublayer:indicator];
        [self.bgLayers addObject:bgLayer];
        [btn.layer addSublayer:bgLayer];
        [self.backView addSubview:btn];
    }
    
    for (int i = 0; i < num; i++) {
        UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake((btnW+1)*i+btnW, self.menuBaseHeight/10, 1, self.menuBaseHeight/10*8)];
        lineLb.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];// 分割线颜色
        if (i == num - 1) {
            lineLb.hidden = YES;
        }
        [self.backView addSubview:lineLb];
    }
    
    
    
    UILabel *VlineLbTop = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, 1)];
    VlineLbTop.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];// 顶部线的颜色
    
    UILabel *VlineLbBom = [[UILabel alloc]initWithFrame:CGRectMake(0, self.menuBaseHeight, self.backView.frame.size.width, 1)];
    VlineLbBom.backgroundColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];// 底部线颜色
    
    [self.backView addSubview:VlineLbTop];
    [self.backView addSubview:VlineLbBom];
}
- (void)showFirstAndSecondTableView:(NSInteger)index{
    NSInteger tempTag = self.menuButtonTag ? self.menuButtonTag :menuButtonDefalutTag;
    NSInteger templastSelecte = self.lastSelectedIndex;
    self.lastSelectedIndex = index;
    void(^compelte)() = ^{
        CGFloat TableViewW = self.cellHeight*self.dataSourceFirst.count;
        CGFloat MaxHeigth = self.tableViewMaxHeight ? self.tableViewMaxHeight : tableViewMaxHeightDefalut;
        if (TableViewW > MaxHeigth) {
            self.tableFirst.scrollEnabled = YES;
            TableViewW = MaxHeigth;
        }else{
            self.tableFirst.scrollEnabled = NO;
        }
        if (self.firstTableViewShow == NO) {
            [self showCarverView];
            CALayer *layer = self.bgLayers[index-tempTag];
            layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
            [UIView animateWithDuration:self.caverAnimationTime animations:^{
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, TableViewW);
            }completion:^(BOOL finished) {
            }];
        }else{
            CALayer *layer = self.bgLayers[index-tempTag];
            layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
            self.firstTableViewShow = NO;
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, TableViewW);
            [UIView animateWithDuration:self.hideAnimationTime animations:^{
                self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
            }];
            self.secondTableViewShow = NO;
            [UIView animateWithDuration:self.hideAnimationTime animations:^{
                self.tableSecond.frame = CGRectMake(self.tableViewWith, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
                self.tableThird.frame = CGRectMake(self.tableViewWith * 2, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
            }];
            [self hideCarverView];
        }
    };
    
    if (self.isNet) {
        if (templastSelecte == index && self.firstTableViewShow) {
            compelte();
        }else{
            UIButton *btn = (UIButton *)[self viewWithTag:index];
            if (_delegate && [_delegate respondsToSelector:@selector(netMenuClickMenuIndex: menuTitle:)]) {
                [_delegate netMenuClickMenuIndex:index - tempTag menuTitle:btn.titleLabel.text];
            }
        }
    }else{
        [self changeMenuDataWithIndex:index-tempTag];
        compelte();
    }
    
    
    
}
- (void)showCarverView{

    UIButton *btn = (UIButton *)[self viewWithTag:self.lastSelectedIndex];
    btn.selected = YES;
    
    self.firstTableViewShow = YES;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width
                            , window_h-self.frame.origin.y);
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.backgroundColor = self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }];
    
}
- (void)hideCarverView{
    
    UIButton *btn = (UIButton *)[self viewWithTag:self.lastSelectedIndex];
    btn.selected = NO;
    
    self.firstTableViewShow = NO;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width
                            , self.menuBaseHeight);
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.backgroundColor = self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }];
    
}
- (void)showFirstTableView:(UIButton *)btn{
    
    NSInteger tempTag = self.menuButtonTag ? self.menuButtonTag :menuButtonDefalutTag;
    self.allData = nil;
    self.data = nil;
    self.dataSourceSecond = nil;
    self.dataSourceThird = nil;
    
    if (self.lastSelectedIndex != btn.tag && self.lastSelectedIndex !=-1) {
        
        UIButton *TemBtn = (UIButton *)[self viewWithTag:self.lastSelectedIndex];
        TemBtn.selected = NO;
        
        
        CALayer *layer = self.bgLayers[self.lastSelectedIndex-tempTag];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        
        [UIView animateWithDuration:self.hideAnimationTime/2 animations:^{
            
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
            self.tableSecond.frame = CGRectMake(self.tableViewWith, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
            self.tableThird.frame = CGRectMake(self.tableViewWith * 2, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        }completion:^(BOOL finished) {
            
            self.firstTableViewShow = NO;
            self.secondTableViewShow = NO;
            self.thirdTableViewShow = NO;
            [self showFirstAndSecondTableView:btn.tag];
            
        }];
        
    }else{
        [self showFirstAndSecondTableView:btn.tag];
    }
    
    
}
- (void)showSecondTabelView:(BOOL)secondTableViewShow{
    CGFloat TableViewW = self.cellHeight*self.dataSourceSecond.count;
    CGFloat MaxHeigth = self.tableViewMaxHeight ? self.tableViewMaxHeight : tableViewMaxHeightDefalut;
    if (TableViewW > MaxHeigth) {
        self.tableSecond.scrollEnabled = YES;
        TableViewW = MaxHeigth;
    }else{
        self.tableSecond.scrollEnabled = NO;
    }
    if (self.secondTableViewShow == YES) {
        [self showCarverView];
        [UIView animateWithDuration:self.caverAnimationTime animations:^{
            self.tableSecond.frame = CGRectMake(self.tableViewWith, CGRectGetMaxY(self.backView.frame), self.tableViewWith, TableViewW);
        }];
    }else{
        [self showCarverView];
        self.secondTableViewShow = YES;
        self.tableSecond.frame = CGRectMake(self.tableViewWith, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        [UIView animateWithDuration:self.caverAnimationTime animations:^{
            self.tableSecond.frame = CGRectMake(self.tableViewWith, CGRectGetMaxY(self.backView.frame),self.tableViewWith, TableViewW);
        }];
    }
    
}

- (void)showThirdTabelView:(BOOL)thirdTableViewShow{
    CGFloat TableViewW = self.cellHeight*self.dataSourceThird.count;
    CGFloat MaxHeigth = self.tableViewMaxHeight ? self.tableViewMaxHeight : tableViewMaxHeightDefalut;
    if (TableViewW > MaxHeigth) {
        self.tableThird.scrollEnabled = YES;
        TableViewW = MaxHeigth;
    }else{
        self.tableThird.scrollEnabled = NO;
    }
    if (self.thirdTableViewShow == YES) {
        [self showCarverView];
        [UIView animateWithDuration:self.caverAnimationTime animations:^{
            self.tableThird.frame = CGRectMake(CGRectGetMaxX(self.tableSecond.frame), CGRectGetMaxY(self.backView.frame), self.tableViewWith, TableViewW);
        }];
    }else{
        [self showCarverView];
        self.thirdTableViewShow = YES;
        self.tableThird.frame = CGRectMake(CGRectGetMaxX(self.tableSecond.frame), CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        [UIView animateWithDuration:self.caverAnimationTime animations:^{
            self.tableThird.frame = CGRectMake(CGRectGetMaxX(self.tableSecond.frame), CGRectGetMaxY(self.backView.frame),self.tableViewWith, TableViewW);
        }];
    }
    
}

- (void)createWithFirstData:(NSArray *)dataFirst{
    self.dataSourceFirst = [NSMutableArray arrayWithArray:dataFirst];
    [self.tableFirst reloadData];
}

- (void)createWithSecondData:(NSArray *)dataSecond{
    self.allData = [NSMutableArray arrayWithArray:dataSecond];
    [self.tableSecond reloadData];
}

- (void)createWithThirdData:(NSArray *)dataThird{
    self.data = [NSMutableArray arrayWithArray:dataThird];
    [self.tableThird reloadData];
}


- (void)createTableViewFirst{
    
    
    self.tableFirst = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backView.frame),self.frame.size.width, 0) style:UITableViewStylePlain];
    self.tableFirst.scrollEnabled = NO;
    self.tableFirst.delegate = self;
    self.tableFirst.dataSource = self;
    
    [self insertSubview:self.tableFirst belowSubview:self.backView];
    
}
- (void)createTableViewSecond{
    self.tableSecond = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.frame.size.width
                                                                    /2, 0) style:UITableViewStylePlain];
    self.tableSecond.scrollEnabled = NO;
    self.tableSecond.delegate = self;
    self.tableSecond.dataSource = self;
    self.tableSecond.autoresizesSubviews = NO;
    [self insertSubview:self.tableSecond belowSubview:self.backView];
}

- (void)createTableViewThird{
    self.tableThird = [[UITableView alloc]initWithFrame:CGRectMake(self.tableViewWith*2, CGRectGetMaxY(self.backView.frame), self.frame.size.width
                                                                   /3, 0) style:UITableViewStylePlain];
    self.tableThird.scrollEnabled = NO;
    self.tableThird.delegate = self;
    self.tableThird.dataSource = self;
    self.tableThird.autoresizesSubviews = NO;
    [self insertSubview:self.tableThird belowSubview:self.backView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableFirst) {
        return self.dataSourceFirst.count;
    }else if (tableView == self.tableSecond) {
        return self.dataSourceSecond.count;
    }else if (tableView == self.tableThird){
        return self.dataSourceThird.count;
    }
    return 0;
}

- (void)changeCellTextStatueColorWith:(UITableViewCell *)cell{
    cell.textLabel.textColor = self.unSelectedColor ? self.unSelectedColor : [UIColor grayColor];
    cell.textLabel.highlightedTextColor = self.selectedColor ? self.selectedColor : [UIColor blackColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableFirst) {
        static NSString *cellID = @"cellFirst";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        cell1.textLabel.text = self.dataSourceFirst[indexPath.row];
        cell1.textLabel.font = self.tableTitleFont ? [UIFont systemFontOfSize:self.tableTitleFont] : TableTitleDefalutFont;
        
        if (!self.allData && !self.isNet) {
            //cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell1.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell1.selectionStyle = UITableViewCellSelectionStyleGray;
            cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        [self changeCellTextStatueColorWith:cell1];
        return cell1;
        
    }else if (tableView == self.tableSecond){
        static NSString *cellIde = @"cellSecond";
        
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
        }
        if (!self.data) {
            //cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell2.selectionStyle = UITableViewCellSelectionStyleGray;
            cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell2.textLabel.text = self.dataSourceSecond[indexPath.row];
        cell2.textLabel.font = self.tableTitleFont ? [UIFont systemFontOfSize:self.tableTitleFont] : TableTitleDefalutFont;
        [self changeCellTextStatueColorWith:cell2];
        return cell2;
        
    }else if (tableView == self.tableThird){
        static NSString *cellIde = @"cellThird";
        UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (cell3 == nil) {
            cell3 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
        }
        cell3.textLabel.text = self.dataSourceThird[indexPath.row];
        //cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        cell3.textLabel.font = self.tableTitleFont ? [UIFont systemFontOfSize:self.tableTitleFont] : TableTitleDefalutFont;
        [self changeCellTextStatueColorWith:cell3];
        return cell3;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSInteger tempTag = self.menuButtonTag ? self.menuButtonTag :menuButtonDefalutTag;

    __weak typeof(self)weakSelf = self;
    void (^complete)(void) = ^(void){
        CALayer *layer = weakSelf.bgLayers[weakSelf.lastSelectedIndex-tempTag];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        UIButton *btn = (id)[weakSelf viewWithTag:weakSelf.lastSelectedIndex];
        weakSelf.firstTableViewShow = NO;
        [UIView animateWithDuration:self.hideAnimationTime animations:^{
            weakSelf.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.backView.frame), weakSelf.tableViewWith, 0);
        }];
        weakSelf.secondTableViewShow = NO;
        [UIView animateWithDuration:weakSelf.hideAnimationTime animations:^{
            weakSelf.tableSecond.frame = CGRectMake(weakSelf.tableViewWith,CGRectGetMaxY(weakSelf.backView.frame), weakSelf.tableViewWith, 0);
        }];
        weakSelf.thirdTableViewShow = NO;
        [UIView animateWithDuration:weakSelf.hideAnimationTime animations:^{
            weakSelf.tableThird.frame = CGRectMake(weakSelf.tableViewWith * 2,CGRectGetMaxY(weakSelf.backView.frame), weakSelf.tableViewWith, 0);
        }];
        [weakSelf hideCarverView];
        if (weakSelf.dataSourceSecond && !weakSelf.dataSourceThird) {
            [btn setTitle:weakSelf.dataSourceSecond[indexPath.row] forState:UIControlStateNormal];
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:andSecondIndex:)]) {
                
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-tempTag firstIndex:weakSelf.lastSelectedCellIndex andSecondIndex:indexPath.row];
                
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:andSecondContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceSecond[indexPath.row]
                                  firstContent:weakSelf.dataSourceFirst[weakSelf.lastSelectedCellIndex]
                              andSecondContent:weakSelf.dataSourceSecond[indexPath.row]];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:secondIndex:thirdIndex:)]) {
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-tempTag firstIndex:weakSelf.lastSelectedCellIndex secondIndex:indexPath.row thirdIndex:-1];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:secondContent:thirdContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceSecond[indexPath.row] firstContent:weakSelf.dataSourceFirst[weakSelf.lastSelectedCellIndex] secondContent:weakSelf.dataSourceSecond[indexPath.row] thirdContent:nil];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:menuIndex:firstContent:firstIndex:secondContent:secondIndex:thirdContent:thirdIndex:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceSecond[indexPath.row] menuIndex:weakSelf.lastSelectedIndex-tempTag firstContent:weakSelf.dataSourceFirst[weakSelf.lastSelectedCellIndex] firstIndex:weakSelf.lastSelectedCellIndex secondContent:weakSelf.dataSourceSecond[indexPath.row] secondIndex:indexPath.row thirdContent:nil thirdIndex:-1];
            }
            
        }
        if (!weakSelf.dataSourceSecond && !weakSelf.dataSourceThird) {
            [btn setTitle:weakSelf.dataSourceFirst[indexPath.row] forState:UIControlStateNormal];
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:andSecondIndex:)]) {
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-tempTag firstIndex:indexPath.row andSecondIndex:-1];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:andSecondContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceFirst[indexPath.row] firstContent:weakSelf.dataSourceFirst[indexPath.row] andSecondContent:nil];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:secondIndex:thirdIndex:)]) {
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-tempTag firstIndex:indexPath.row secondIndex:-1 thirdIndex:-1];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:secondContent:thirdContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceFirst[indexPath.row] firstContent:weakSelf.dataSourceFirst[indexPath.row] secondContent:nil thirdContent:nil];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:menuIndex:firstContent:firstIndex:secondContent:secondIndex:thirdContent:thirdIndex:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceFirst[indexPath.row] menuIndex:weakSelf.lastSelectedIndex-tempTag firstContent:weakSelf.dataSourceFirst[indexPath.row] firstIndex:indexPath.row secondContent:nil secondIndex:-1 thirdContent:nil thirdIndex:-1];
            }
            
        }
        if (weakSelf.dataSourceSecond && weakSelf.dataSourceThird) {
            [btn setTitle:weakSelf.dataSourceThird[indexPath.row] forState:UIControlStateNormal];
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:andSecondIndex:)]) {
                
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-tempTag firstIndex:weakSelf.lastSelectedCellIndex andSecondIndex:weakSelf.lastSecondCellIndex];
                
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:andSecondContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceSecond[weakSelf.lastSecondCellIndex]
                                  firstContent:weakSelf.dataSourceFirst[weakSelf.lastSelectedCellIndex]
                              andSecondContent:weakSelf.dataSourceSecond[weakSelf.lastSecondCellIndex]];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:secondIndex:thirdIndex:)]) {
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-tempTag firstIndex:weakSelf.lastSelectedCellIndex secondIndex:weakSelf.lastSecondCellIndex thirdIndex:indexPath.row];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:secondContent:thirdContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceThird[indexPath.row] firstContent:weakSelf.dataSourceFirst[weakSelf.lastSelectedCellIndex] secondContent:weakSelf.dataSourceSecond[weakSelf.lastSecondCellIndex] thirdContent:weakSelf.dataSourceThird[indexPath.row]];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:menuIndex:firstContent:firstIndex:secondContent:secondIndex:thirdContent:thirdIndex:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceThird[indexPath.row] menuIndex:weakSelf.lastSelectedIndex-tempTag firstContent:weakSelf.dataSourceFirst[weakSelf.lastSelectedCellIndex] firstIndex:weakSelf.lastSelectedCellIndex secondContent:weakSelf.dataSourceSecond[weakSelf.lastSecondCellIndex] secondIndex:weakSelf.lastSecondCellIndex thirdContent:weakSelf.dataSourceThird[indexPath.row]thirdIndex:indexPath.row];
            }
        }
        weakSelf.allData = nil;
        weakSelf.data = nil;
        weakSelf.dataSourceFirst = nil;
        weakSelf.dataSourceSecond = nil;
        weakSelf.dataSourceThird = nil;
        
    };
    
    if (tableView == self.tableFirst) {
        NSInteger i = indexPath.row;
        self.lastSelectedCellIndex = indexPath.row;
        if (self.isNet) {
            UIButton *btn = (UIButton *)[self viewWithTag:self.lastSelectedIndex];
            if (_delegate && [_delegate respondsToSelector:@selector(netMenuClickMenuIndex:menuTitle:FirstIndex:firstContent:)]) {
                [_delegate netMenuClickMenuIndex:self.lastSelectedIndex-tempTag menuTitle:btn.titleLabel.text FirstIndex:i firstContent:self.dataSourceFirst[i]];
            }
        }else{
            weakSelf.dataSourceSecond = nil;
            if (self.allData[i] != nil && self.allData[i] != NULL && [self.allData[i] count] != 0) {
                self.dataSourceSecond = self.allData[i];
                self.num = 0;
                for (int j = 0; j < i; j++) {
                    self.num += [self.allData[j] count];
                }
                [self.tableSecond reloadData];
                [self showSecondTabelView:self.secondTableViewShow];
                
            }else{
                complete();
                
            }
        }
    }else if (tableView == self.tableSecond) {
        weakSelf.dataSourceThird = nil;
        NSInteger i = indexPath.row;
        if (self.data[i] != nil && self.data[i] != NULL && [self.data[self.num + i] count] != 0) {
            self.lastSecondCellIndex = indexPath.row;
            self.dataSourceThird = self.data[self.num + i];
            [self.tableThird reloadData];
            [self showThirdTabelView:self.thirdTableViewShow];
        }else{
            complete();
            
        }
    }else if (tableView == self.tableThird){
        complete();
        
    }
    
}


- (void)drawBackMenu{
    if (!self.firstTableViewShow) {
        return;
    }
    [self netHideTable];
}



#pragma mark -- net

- (void)netHideTable{
     NSInteger tempTag = self.menuButtonTag ? self.menuButtonTag :menuButtonDefalutTag;
    CALayer *layer = self.bgLayers[self.lastSelectedIndex-tempTag];
    layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
    self.firstTableViewShow = NO;
    [UIView animateWithDuration:self.hideAnimationTime animations:^{
        self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    self.secondTableViewShow = NO;
    [UIView animateWithDuration:self.hideAnimationTime animations:^{
        self.tableSecond.frame = CGRectMake(self.tableViewWith,CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    self.thirdTableViewShow = NO;
    [UIView animateWithDuration:self.hideAnimationTime animations:^{
        self.tableThird.frame = CGRectMake(self.tableViewWith * 2,CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    [self hideCarverView];
    self.allData = nil;
    self.data = nil;
    self.dataSourceSecond = nil;
    self.dataSourceThird = nil;
}

- (NSMutableArray *)allDataSource{
    if (_allDataSource == nil) {
        _allDataSource = [NSMutableArray array];
    }
    return _allDataSource;
}



- (void)netCreateMenuTitleArray:(NSArray *)menuTitleArray{
    self.tableViewWith = self.frame.size.width/2;
    self.isNet = YES;
    self.menuBaseHeight = self.frame.size.height;
    [self createMenuViewWithData:menuTitleArray];
    [self createTableViewFirst];
    [self createTableViewSecond];
}

- (void)netLoadSecondArray:(NSArray *)SecondArray{
    self.dataSourceSecond = [NSMutableArray arrayWithArray:SecondArray];
    [self.tableSecond reloadData];
    [self showSecondTabelView:self.secondTableViewShow];
}

- (void)netLoadFirstArray:(NSArray *)firstArray{
    [self createWithFirstData:firstArray];
    [self netShowCommentTable];
}

- (void)netShowCommentTable{
     NSInteger tempTag = self.menuButtonTag ? self.menuButtonTag :menuButtonDefalutTag;
    NSInteger index = self.lastSelectedIndex;
    CGFloat TableViewW = self.cellHeight*self.dataSourceFirst.count;
    CGFloat MaxHeigth = self.tableViewMaxHeight ? self.tableViewMaxHeight : tableViewMaxHeightDefalut;
    if (TableViewW > MaxHeigth) {
        self.tableFirst.scrollEnabled = YES;
        TableViewW = MaxHeigth;
    }else{
        self.tableFirst.scrollEnabled = NO;
    }
    if (self.firstTableViewShow == NO) {
        [self showCarverView];
        CALayer *layer = self.bgLayers[index-tempTag];
        layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        [UIView animateWithDuration:self.caverAnimationTime animations:^{
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, TableViewW);
        }completion:^(BOOL finished) {
        }];
    }else{
        CALayer *layer = self.bgLayers[index-tempTag];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        self.firstTableViewShow = NO;
        self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, TableViewW);
        [UIView animateWithDuration:self.hideAnimationTime animations:^{
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        }];
        self.secondTableViewShow = NO;
        [UIView animateWithDuration:self.hideAnimationTime animations:^{
            self.tableSecond.frame = CGRectMake(self.tableViewWith, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
            self.tableThird.frame = CGRectMake(self.tableViewWith * 2, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        }];
        
        [self hideCarverView];
    }
}



@end
