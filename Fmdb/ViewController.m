//
//  ViewController.m
//  Fmdb
//
//  Created by 松尾 慎治 on 2016/03/30.
//  Copyright © 2016年 sample. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"

@interface ViewController ()
@property NSArray *dataValues;
@property IBOutlet UITableView *tableView;
@end

@implementation ViewController

@synthesize teLimit;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.teLimit setDelegate:self];
    
    // パスとDBファイル名を指定
    self.teTitle.delegate = self;
    self.teContents.delegate = self;
    //    self.teLimit.delegate = self;
    [self.teLimit setDelegate:self];
    
    NSArray  *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    NSString *db_path  = [dir stringByAppendingPathComponent:@"/todo.sql"];
    NSLog(@"%@", db_path );
    
    FMDatabase *db = [FMDatabase databaseWithPath:db_path];
    // テーブルを作成
    NSString *sql = @"CREATE TABLE IF NOT EXISTS tr_todo(todo_id INTEGER PRIMARY KEY AUTOINCREMENT,todo_title,todo_contents,created,modifed,limit_date);";
    [db open];
    // SQLを実行
    [db executeUpdate:sql];
    [db close];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // キーボードを非表示にする
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)insert:(UIButton *)sender {
    //現在日付取得
    NSDate *datetime = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy/MM/dd";
    NSString *result = [fmt stringFromDate:datetime];
    
    //todo_title,todo_contents,created,modified,limited
    NSArray *dataValues = @[self.teTitle.text
                            ,self.teContents.text
                            ,result
                            ,@"not"
                            ,self.teLimit.text];
    DbController *dc = [[DbController alloc]init];
    //DBにデータをInsert
    NSLog(@"%@",[dataValues objectAtIndex:0]);
    NSLog(@"%@",[dataValues objectAtIndex:1]);
    NSLog(@"%@",[dataValues objectAtIndex:2]);
    NSLog(@"%@",[dataValues objectAtIndex:3]);
    NSLog(@"%@",[dataValues objectAtIndex:4]);
    
    [dc insertTable:dataValues];
}


- (IBAction)show:(UIButton *)sender {
    ShowViewController *sc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowViewController"];
    [self presentViewController:sc animated:YES completion:nil];
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

//DatePickerを表示
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if([self.teLimit isEqual:textField]){
        //キーボードは表示しない
        [textField resignFirstResponder];
        //datePickerのメソッド設定
        [self.datep addTarget:self
                       action:@selector(datePickerValueChanged:)
             forControlEvents:UIControlEventValueChanged];
        //datePickerの表示
        self.datep.hidden = NO;
    }
}


//DatePickerの値が変更されたとき処理
- (void)datePickerValueChanged:(id)sender{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy/MM/dd";
    
    teLimit.text = [fmt stringFromDate:self.datep.date];
    [teLimit resignFirstResponder];
    self.datep.hidden = YES;
}




@end
