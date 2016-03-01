//
//  WJDropdownMenu.m
//  WJDropDownMenu
//
//  Created by 文杰 on 16/1/23.
//  Copyright © 2016年 wj. All rights reserved.
//


#define window_w [UIScreen mainScreen].bounds.size.width
#define cell_h   30
#define menu_h   40
#define window_h [UIScreen mainScreen].bounds.size.height

#import "WJDropdownMenu.h"
#import <UIKit/UIKit.h>





@interface WJDropdownMenu () 

@property (nonatomic,strong) UIView         *backView;
@property (nonatomic,strong) UITableView    *tableFirst;
@property (nonatomic,strong) UITableView    *tableSecond;
@property (nonatomic,strong) NSMutableArray *dataSourceFirst;
@property (nonatomic,strong) NSMutableArray *dataSourceSecond;
@property (nonatomic,strong) NSMutableArray *allData;
@property (nonatomic,strong) NSMutableArray *allDataSource;
@property (nonatomic,assign) BOOL           firstTableViewShow;
@property (nonatomic,assign) BOOL           secondTableViewShow;
@property (nonatomic,assign) NSInteger      lastSelectedIndex;
@property (nonatomic,strong) NSMutableArray *bgLayers;



@end



@implementation WJDropdownMenu



- (void)createOneMenuTitleArray:(NSArray *)menuTitleArray FirstArray:(NSArray *)FirstArray{

    [self createMenuViewWithData:menuTitleArray];
    [self.allDataSource addObject:FirstArray];
    
    [self createTableViewFirst];
    [self createTableViewSecond];
}
- (void)createTwoMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr{
 
    [self createMenuViewWithData:menuTitleArray];
    [self.allDataSource addObject:firstArr];
    [self.allDataSource addObject:secondArr];
    
    [self createTableViewFirst];
    [self createTableViewSecond];
}

- (void)createThreeMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr threeArr:(NSArray *)threeArr{

    [self createMenuViewWithData:menuTitleArray];
    [self.allDataSource addObject:firstArr];
    [self.allDataSource addObject:secondArr];
    [self.allDataSource addObject:threeArr];
    
    [self createTableViewFirst];
    [self createTableViewSecond];
}

- (void)createFourMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr threeArr:(NSArray *)threeArr fourArr:(NSArray *)fourArr{
    
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
    [self createWithSecondData:self.allDataSource[index][1]];
    
}
- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.8;
    layer.fillColor = [UIColor colorWithRed:0xcc/255.0 green:0xcc/255.0 blue:0xcc/255.0 alpha:0xcc/255.0].CGColor;
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
    if ([touch.view isKindOfClass:[UIButton class]] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] ) {
        return NO;
    }
    return YES;
}
- (void)remover{
    CALayer *layer = self.bgLayers[self.lastSelectedIndex-100];
    layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
    
    self.firstTableViewShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), window_w/2, 0);
    }];
    self.secondTableViewShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableSecond.frame = CGRectMake(window_w/2,CGRectGetMaxY(self.backView.frame), window_w/2, 0);
    }];
    [self hideCarverView];
}
- (void)createMenuViewWithData:(NSArray *)data{
    
    self.lastSelectedIndex = -1;
    self.backgroundColor =[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, window_w, 40);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remover)];
    [self addGestureRecognizer:tap];
    tap.delegate = self;
    
    self.bgLayers = [[NSMutableArray alloc]init];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, window_w, menu_h)];
    
    self.backView.userInteractionEnabled = YES;
    
    self.backView.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.backView];
    NSInteger num = data.count;
    for (int i = 0; i < num; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(window_w/num*i, 0, window_w/num-1, menu_h)];

        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = 100+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:data[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showFirstTableView:) forControlEvents:UIControlEventTouchUpInside];
        
        CGPoint bgLayerPoint = CGPointMake(window_w/num-10, menu_h/2);
        CALayer *bgLayer = [self createBgLayerWithColor:[UIColor clearColor] andPosition:bgLayerPoint];
        CGPoint indicatorPoint = CGPointMake(10, 10);
        CAShapeLayer *indicator = [self createIndicatorWithColor:[UIColor lightGrayColor] andPosition:indicatorPoint];
        [bgLayer addSublayer:indicator];
        
        [self.bgLayers addObject:bgLayer];
        
        [btn.layer addSublayer:bgLayer];
        UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), 8, 1, 24)];
        lineLb.backgroundColor = [UIColor lightGrayColor];
        if (i == num - 1) {
            lineLb.hidden = YES;
        }
        
        
        [self.backView addSubview:btn];
        [self.backView insertSubview:lineLb aboveSubview:btn];
    }
    UILabel *VlineLbTop = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, 1)];
    VlineLbTop.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *VlineLbBom = [[UILabel alloc]initWithFrame:CGRectMake(0, menu_h, self.backView.frame.size.width, 1)];
    VlineLbBom.backgroundColor = [UIColor lightGrayColor];
    
    [self.backView addSubview:VlineLbTop];
    [self.backView addSubview:VlineLbBom];
}
- (void)showFirstAndSecondTableView:(NSInteger)index{
    
    [self changeMenuDataWithIndex:index-100];
    
    if (self.firstTableViewShow == NO) {

        self.firstTableViewShow = YES;
        [self showCarverView];
        CALayer *layer = self.bgLayers[index-100];
        layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        
        [UIView animateWithDuration:0.2 animations:^{
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), window_w/2, cell_h*self.dataSourceFirst.count);
        }];
        
    }else{

        CALayer *layer = self.bgLayers[index-100];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        self.firstTableViewShow = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), window_w/2, 0);
        }];
        self.secondTableViewShow = NO;
        [UIView animateWithDuration:0.2 animations:^{

            self.tableSecond.frame = CGRectMake(window_w/2, CGRectGetMaxY(self.backView.frame), window_w/2, 0);
        }];
        [self hideCarverView];
        
    }
    self.lastSelectedIndex = index;
}
- (void)showCarverView{

    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, window_w, window_h-self.frame.origin.y);
        
    }];
}
- (void)hideCarverView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, window_w, menu_h);
        
    }];
    
}
- (void)showFirstTableView:(UIButton *)btn{
    
    
    if (self.lastSelectedIndex != btn.tag && self.lastSelectedIndex !=-1) {
        CALayer *layer = self.bgLayers[self.lastSelectedIndex-100];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), window_w/2, 0);
            self.tableSecond.frame = CGRectMake(window_w/2, CGRectGetMaxY(self.backView.frame), window_w/2, 0);
            
        }completion:^(BOOL finished) {
            
            self.firstTableViewShow = NO;
            self.secondTableViewShow = NO;
            [self showFirstAndSecondTableView:btn.tag];
            
            
        }];
        
    }else{
        [self showFirstAndSecondTableView:btn.tag];
    }
    
    
}
- (void)showSecondTabelView:(BOOL)secondTableViewShow{
    if (self.secondTableViewShow == YES) {
        [self showCarverView];
        [UIView animateWithDuration:0.2 animations:^{
            self.tableSecond.frame = CGRectMake(window_w/2, CGRectGetMaxY(self.backView.frame), window_w/2, cell_h*self.dataSourceSecond.count);
        }];
    }else{
        [self showCarverView];
        self.secondTableViewShow = YES;
        self.tableSecond.frame = CGRectMake(window_w/2, CGRectGetMaxY(self.backView.frame), window_w/2, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableSecond.frame = CGRectMake(window_w/2, CGRectGetMaxY(self.backView.frame), window_w/2, cell_h*self.dataSourceSecond.count);
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

- (void)createTableViewFirst{
    
    
    
    self.tableFirst = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backView.frame),window_w/2, 0) style:UITableViewStylePlain];
    self.tableFirst.scrollEnabled = NO;
    self.tableFirst.delegate = self;
    self.tableFirst.dataSource = self;
    [self insertSubview:self.tableFirst belowSubview:self.backView];
    
}
- (void)createTableViewSecond{
    self.tableSecond = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backView.frame), window_w/2, 0) style:UITableViewStylePlain];
    self.tableSecond.scrollEnabled = NO;
    self.tableSecond.delegate = self;
    self.tableSecond.dataSource = self;
    [self insertSubview:self.tableSecond belowSubview:self.backView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableFirst) {
        return self.dataSourceFirst.count;
    }else{
        return self.dataSourceSecond.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableFirst) {
        static NSString *cellID = @"cellFirst";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        cell1.textLabel.text = self.dataSourceFirst[indexPath.row];
        cell1.textLabel.font = [UIFont systemFontOfSize:12];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell1;
        
    }else{
        static NSString *cellIde = @"cellSecond";
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
        }
        cell2.textLabel.text = self.dataSourceSecond[indexPath.row];
        cell2.textLabel.font = [UIFont systemFontOfSize:12];
        return cell2;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.tableFirst) {
        NSLog(@"tableview点击");
        NSInteger i = indexPath.row;
        self.dataSourceSecond = self.allData[i];
        [self.tableSecond reloadData];
        [self showSecondTabelView:self.secondTableViewShow];
    }else{
        CALayer *layer = self.bgLayers[self.lastSelectedIndex-100];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        
        UIButton *btn = (id)[self viewWithTag:self.lastSelectedIndex];
        [btn setTitle:self.dataSourceSecond[indexPath.row] forState:UIControlStateNormal];
        self.firstTableViewShow = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), window_w/2, 0);
        }];
        self.secondTableViewShow = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.tableSecond.frame = CGRectMake(window_w/2,CGRectGetMaxY(self.backView.frame), window_w/2, 0);
        }];
        [self hideCarverView];
        [_delegate menuCellDidSelected:self.lastSelectedIndex-100 andDetailIndex:indexPath.row];
        
    }
}
- (NSMutableArray *)allDataSource{
    if (_allDataSource == nil) {
        _allDataSource = [NSMutableArray array];
    }
    return _allDataSource;
}

@end
