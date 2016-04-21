#import <UIKit/UIKit.h>


typedef enum:NSInteger{
    menuArrowStyleSolid  = 0,
    menuArrowStyleHollow = 1,
}menuArrowStyle;

@protocol WJMenuDelegate <NSObject>


@optional
/**
 * 代理方法返回 菜单标题index:MenuTitleIndex  一级菜单index:firstIndex  二级菜单index:secondIndex
 */
- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex andSecondIndex:(NSInteger)secondIndex;

/**
 * 代理方法返回 菜单标题:MenuTitle  一级菜单内容:firstContent  二级菜单内容:secondContent
 */
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent andSecondContent:(NSString *)secondContent;


/**
 * 代理方法返回 菜单标题index:MenuTitleIndex  一级菜单index:firstIndex  二级菜单index:secondIndex  三级菜单index:thirdIndex
 */
- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex secondIndex:(NSInteger)secondIndex thirdIndex:(NSInteger)thirdIndex;

/**
 * 代理方法返回 菜单标题:MenuTitle  一级菜单内容:firstContent  三级菜单内容:thirdContent
 */
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent secondContent:(NSString *)secondContent thirdContent:(NSString *)thirdContent;


#pragma mark -- 一级一级点击网络获取数据的代理方法
- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle;

- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle FirstIndex:(NSInteger)FirstIndex firstContent:(NSString *)firstContent;

@end



@interface WJDropdownMenu : UIView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

/**
 * 关闭遮盖功能
 */
@property (nonatomic,strong)UIColor *CarverViewColor;

/**
 * 遮盖的动画时间
 */
@property (nonatomic,assign)CGFloat caverAnimationTime;

/**
 * 菜单title的字体大小
 */
@property (nonatomic,assign)CGFloat menuTitleFont;

/**
 * 下拉菜单的的字体大小
 */
@property (nonatomic,assign)CGFloat tableTitleFont;

/**
 * 下拉菜单的的字体大小
 */
@property (nonatomic,assign)CGFloat menuHeight;

/**
 * 下拉菜单cell的高度
 */
@property (nonatomic,assign)CGFloat cellHeight;

/**
 * 旋转箭头的样式
 */
@property (nonatomic,assign)menuArrowStyle menuArrowStyle;


@property (nonatomic,assign) id<WJMenuDelegate>delegate;


/**
 * 创建一组下拉菜单
 */
- (void)createOneMenuTitleArray:(NSArray *)menuTitleArray FirstArray:(NSArray *)FirstArray;

/**
 * 创建两组下拉菜单
 */
- (void)createTwoMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr;

/**
 * 创建三组下拉菜单
 */
- (void)createThreeMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr threeArr:(NSArray *)threeArr;

/**
 * 创建四组下拉菜单
 */
- (void)createFourMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr threeArr:(NSArray *)threeArr fourArr:(NSArray *)fourArr;

/**
 * 收缩菜单
 */
- (void)drawBackMenu;


#pragma mark -- 一级一级点击网络获取数据创建
- (void)netCreateThreeMenuTitleArray:(NSArray *)menuTitleArray;
- (void)netLoadFirstArray:(NSArray *)firstArray;
- (void)netLoadSecondArray:(NSArray *)SecondArray;


@end
