//
//  ViewController.h
//  Fmdb
//
//  Created by matsu on 2016/03/30.
//  Copyright © 2016年 sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbController.h"
#import "ShowViewController.h"

@interface ViewController : UIViewController<UITextFieldDelegate>{
//    UIDatePicker *datep;
}
@property (weak, nonatomic) IBOutlet UITextField *teTitle;
@property (weak, nonatomic) IBOutlet UITextField *teContents;
@property (weak, nonatomic) IBOutlet UITextField *teLimit;
- (IBAction)insert:(UIButton *)sender;
- (IBAction)show:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datep;

@end

