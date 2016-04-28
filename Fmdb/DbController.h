//
//  DbController.h
//  Fmdb
//
//  Created by matsu on 2016/03/30.
//  Copyright © 2016年 sample. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"


@interface DbController : NSObject

+ (NSString*)getDataBasePath;
- (void)insertTable : (NSArray*)insertValues;
- (NSArray*)selectTable;

@property NSString *todo_title;
@property NSString *todo_contents;
@property NSString *created;
@property NSString *modified;
@property NSString *limited;
@end


