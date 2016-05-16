//
//  ViewController.m
//  全面知识点Tableview
//
//  Created by 侯英格 on 16/5/16.
//  Copyright © 2016年 侯英格. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "MyCellInfo.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

-(void)creatUI{
    //设置了代理 属性就不起作用
    self.tableView.rowHeight=200;
    self.tableView.sectionHeaderHeight=100;
    self.tableView.sectionFooterHeight=100;
    
    self.tableView.separatorInset=UIEdgeInsetsMake(0, 80, 0, 0);
    self.tableView.backgroundView=[[UIView alloc] init];
    self.tableView.backgroundView.backgroundColor=[UIColor redColor];
    
    self.dataArray=[NSMutableArray array];
    [self addArray];
    
    //右边缩略条 最小的数量
    self.tableView.sectionIndexMinimumDisplayRowCount=0;
    
    
    
    self.tableView.sectionIndexColor=[UIColor redColor];
    self.tableView.sectionIndexBackgroundColor=[UIColor yellowColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    self.tableView.separatorColor=[UIColor greenColor];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    self.tableView.separatorEffect=vibrancyEffect;
    
    UIView*headerView=[UIView new];
    headerView.frame=CGRectMake(0, 0, 0,300);
    headerView.backgroundColor=[UIColor purpleColor];
    self.tableView.tableHeaderView=headerView;
    
    UIView*footerView=[UIView new];
    footerView.frame=CGRectMake(0, 0, 0,300);
    footerView.backgroundColor=[UIColor brownColor];
    self.tableView.tableFooterView=footerView;
    //xib 注册cell
    //- (void)registerNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(5_0);
    //class 注册cell
    //- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);
    
    //xib 注册header footer
    //- (void)registerNib:(nullable UINib *)nib forHeaderFooterViewReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);
    //class 注册header footer
    //- (void)registerClass:(nullable Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);
    
}



#pragma mark -----------tableView-delegate-----------
//-----------------------tableview headerView-------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView*header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header=[[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
        header.textLabel.text=@"textLabel";
        header.contentView.backgroundColor=[UIColor greenColor];
    }
    return header;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"我是第%ld个headerView",(long)section];
}

//------------------------tableview footerView----------------------

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView*header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    if (!header) {
        header=[[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footer"];
        header.textLabel.text=@"textLabel";
        header.contentView.backgroundColor=[UIColor blueColor];
    }
    return header;
}



- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;{
    return [NSString stringWithFormat:@"我是第%ld个footerView",(long)section];
}

//------------------------tableview number---------------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray*array=[self.dataArray objectAtIndex:section];
    return array.count;
}

//------------------------tableview cell-----------------------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray*array=[self.dataArray objectAtIndex:indexPath.section];
    MyCellInfo*info=[array objectAtIndex:indexPath.row];
    return info.height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCell*cell=[tableView dequeueReusableCellWithIdentifier:@"mycell"];
    cell.textLabel.text=[NSString stringWithFormat:@"我是第%ld个cell",indexPath.row];
    return cell;
}

//------------------------tableview cell select-----------------------

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //反选cell
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//右边缩略图的内容 
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray*titleArray=[NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titleArray addObject:[NSString stringWithFormat:@"%ld",idx]];
    }];
    return titleArray;
}

//右边辅助视图的类型
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row%5;
}

//副主视图的事件
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"将要展示cell");
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
    NSLog(@"将要展示headerView");
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
    NSLog(@"将要展示footerView");
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0){
    NSLog(@"已经显示cell");
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
    NSLog(@"已经显示headerView");
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
    NSLog(@"已经显示footerView");
}


- (IBAction)showSomeWay:(id)sender {
    //拿到section的数量
    NSInteger numberOfSections=self.tableView.numberOfSections;
    NSLog(@"tableView.numberOfSections=%ld",numberOfSections);
    
    //拿到section的row的数量
    NSInteger numberOfRowsInSection=[self.tableView numberOfRowsInSection:0];
    NSLog(@"tableView.numberOfRowsInSection=%ld",numberOfRowsInSection);
    
    //拿到section的frame
    CGRect rectForSection= [self.tableView rectForSection:0];
    NSLog(@"tableView.rectForSection=%@",NSStringFromCGRect(rectForSection));
    
    //拿到header的frame
    CGRect rectForHeaderInSection= [self.tableView rectForHeaderInSection:0];
    NSLog(@"tableView.rectForHeaderInSection=%@",NSStringFromCGRect(rectForHeaderInSection));
    
    //拿到某一个path的cell的frame
    CGRect rectForRowAtIndexPath= [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:15 inSection:0]];
    NSLog(@"tableView.rectForRowAtIndexPath=%@",NSStringFromCGRect(rectForRowAtIndexPath));
    
    //拿到某一个point的index
    NSIndexPath*indexPathForRowAtPoint= [self.tableView indexPathForRowAtPoint:CGPointMake(200, 200)];
    NSLog(@"tableView.indexPathForRowAtPoint=%@",indexPathForRowAtPoint);
    
    
    //只能拿到屏幕里可见的cell  如果不在屏幕里那么获取到的cell是空
    UITableViewCell*cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    //拿到某一个cell的index
    NSIndexPath*indexPathForCell= [self.tableView indexPathForCell:cell];
    NSLog(@"tableView.indexPathForCell=%@",indexPathForCell);
    
    //拿到某一个rect里的若干index
    NSArray*indexPathArray= [self.tableView indexPathsForRowsInRect:CGRectMake(0, 0, 300, 300)];
    NSLog(@"tableView.indexPathsForRowsInRect=%@",indexPathArray);
    
    //拿到所有的可见cell
    NSArray*visibleCellArray=[self.tableView visibleCells];
    NSLog(@"%@",visibleCellArray);
    
    //拿到所有可见的cell的所有index
    NSArray*visibleCellIndexPathArray=[self.tableView indexPathsForVisibleRows];
    NSLog(@"%@",visibleCellIndexPathArray);

    //拿到某个section的header或者footer
    UIView*headerView=[self.tableView headerViewForSection:0];
    UIView*footerView=[self.tableView footerViewForSection:0];
    NSLog(@"%@/n%@",headerView,footerView);

    //滚动到指定的cell
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:15 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(void)addArray{
    NSMutableArray*array=[NSMutableArray array];
    for (int i=0; i<20; i++) {
        MyCellInfo*info=[MyCellInfo new];
        if (i%2==0) {
            info.height=80;
        }else{
            info.height=80;
        }
        [array addObject:info];
    }
    [self.dataArray insertObject:array atIndex:0];
}

- (void)insertSections:(id)sender {
    [self addArray];
    //在第一个section之后添加一个section
    NSIndexSet*set=[NSIndexSet indexSetWithIndex:0];
    [self.tableView insertSections:set withRowAnimation:UITableViewRowAnimationFade];
}

-(BOOL)deleteArray{
    if ([self.dataArray firstObject]) {
        [self.dataArray removeObjectAtIndex:0];
        return YES;
    }else{
        return NO;
    }
}

- (void)deleteSections:(id)sender {
    if ([self deleteArray]) {
        NSIndexSet*set=[NSIndexSet indexSetWithIndex:0];
        [self.tableView deleteSections:set withRowAnimation:UITableViewRowAnimationFade];
    };
}

- (void)reloadSections:(id)sender {
    if ([self.dataArray firstObject]) {
        NSIndexSet*set=[NSIndexSet indexSetWithIndex:0];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationRight];
    }
}

- (void)insertRowsAtIndexPaths:(id)sender {
    int i=0;
    int j=0;
    NSMutableArray*array=[self.dataArray objectAtIndex:i];
    MyCellInfo*info=[MyCellInfo new];
    info.height=80;
    [array addObject:info];
    NSIndexPath*indexPath=[NSIndexPath indexPathForRow:j inSection:i];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)deleteRowsAtIndexPaths:(id)sender {
    int i=0;
    int j=0;
    NSMutableArray*array=[self.dataArray objectAtIndex:i];
    if (array.count!=0) {
        [array removeObjectAtIndex:j];
        NSIndexPath*indexPath=[NSIndexPath indexPathForRow:j inSection:i];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

- (void)reloadRowsAtIndexPaths:(id)sender {
    if ([self.dataArray firstObject]) {
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

- (IBAction)cellAddAndDelete:(id)sender {
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"cell增删" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction*action=[UIAlertAction actionWithTitle:@"section增加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self insertSections:nil];
    }];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"section删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteSections:nil];
    }];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"section重新刷新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self reloadSections:nil];
    }];
    UIAlertAction*action3=[UIAlertAction actionWithTitle:@"row增加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self insertRowsAtIndexPaths:nil];
    }];
    UIAlertAction*action4=[UIAlertAction actionWithTitle:@"row删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteRowsAtIndexPaths:nil];
    }];
    UIAlertAction*action5=[UIAlertAction actionWithTitle:@"row重新刷新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self reloadRowsAtIndexPaths:nil];
    }];
    
    UIAlertAction*actionDismis=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action4];
    [alert addAction:action5];
    [alert addAction:actionDismis];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
