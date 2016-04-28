//
//  ShowViewController.m
//  Fmdb
//
//  Created by 松尾 慎治 on 2016/03/31.
//  Copyright © 2016年 sample. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowViewController.h"

@interface ShowViewController () <UITableViewDelegate,UITableViewDataSource>
@property NSArray *dataValues;
@property IBOutlet UITableView *tableView;
@end

@implementation ShowViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //DBからデータを取得
    DbController *dc = [[DbController alloc]init];
    self.dataValues = [dc selectTable];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//セルの数を指定
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataValues.count;
}

//セルの値を指定
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    DbController *data = [self.dataValues objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat : @"%@ %@ %@",data.todo_title,data.todo_contents,data.limited];
    return cell;
}


@end

