//
//  DbController.m
//  Fmdb
//
//  Created by 松尾 慎治 on 2016/03/3//  Copyright © 2016年 sample. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbController.h"

@implementation DbController : NSObject


- (void)createTable{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    NSString *db_path  = [dir stringByAppendingPathComponent:@"/todo.sql"];
    NSLog(@"%@", db_path );
    
    FMDatabase *db = [FMDatabase databaseWithPath:db_path];
    // テーブルを作成2
    NSString *sql = @"CREATE TABLE IF NOT EXISTS weather2(id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT,tenki TEXT,tenki,icon TEXT);";
    [db open];
    // SQLを実行
    [db executeUpdate:sql];
    [db close];
}




//DBのPathを取得する
+ (NSString*)getDataBasePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directry = [paths objectAtIndex:0];
    //    NSLog(@"path=%@",directry);
    return directry;
}



//tabelにINSERTする
- (void)insertTable : (NSArray *)insertValues{
    NSString *path = [[DbController getDataBasePath] stringByAppendingString:@"/todo.sql"];
    FMDatabase *fmDataBase = [FMDatabase databaseWithPath:path];
    NSString *sql = @"INSERT INTO tr_todo(todo_title,todo_contents,created,modifed,limit_date) VALUES (?,?,?,?,?)";
    [fmDataBase open];
    [fmDataBase executeUpdate:sql,
    [insertValues objectAtIndex:0],
    [insertValues objectAtIndex:1],
    [insertValues objectAtIndex:2],
    [insertValues objectAtIndex:3],
    [insertValues objectAtIndex:4]];
    
    [fmDataBase close];
}



//tabelからSelectする
- (NSArray*)selectTable{
    NSString *path = [[DbController getDataBasePath] stringByAppendingString:@"/todo.sql"];
    FMDatabase *fmDataBase = [FMDatabase databaseWithPath:path];
    NSString *sql = @"SELECT todo_title,todo_contents,limit_date FROM tr_todo ORDER BY limit_date;";
    
    [fmDataBase open];
    FMResultSet *result = [fmDataBase executeQuery:sql];
    NSMutableArray *dataValues = [[NSMutableArray alloc]init];
    while ([result next]) {
        DbController *data = [[DbController alloc]init];
        data.todo_title = [result stringForColumnIndex:0];
        data.todo_contents = [result stringForColumnIndex:1];
        data.limited = [result stringForColumnIndex:2];
        [dataValues addObject:data];
    }
    [fmDataBase close];
    return  dataValues;
}


@end

