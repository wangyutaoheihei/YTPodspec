//
//  ViewController.m
//  textzhifu
//
//  Created by ZhiCheng on 2017/1/5.
//  Copyright © 2017年 玉涛. All rights reserved.
//

#import "ViewController.h"
#import "CustomTextfiled.h"

@interface ViewController ()<CustomTextDelegate>
- (IBAction)puttext:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet CustomTextfiled *spacetextfied;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomTextfiled *text = [[CustomTextfiled alloc]initWithFrame:CGRectMake(30, 80, self.view.frame.size.width-60, 40)];
    text.backgroundColor = [UIColor whiteColor];
    text.textFieldCount = 8;
    [self.view addSubview:text];
    
    self.spacetextfied.textFieldCount = 6;
    self.spacetextfied.delegate = self;
}
- (IBAction)delegate:(id)sender {
    [self.spacetextfied cleanNum];
}

- (void)passWordDidChange:(CustomTextfiled *)passWord {
    NSLog(@"%@",passWord.textStore);
}

- (void)passWordCompleteInput:(CustomTextfiled *)passWord {
    NSLog(@"输入完成%@",passWord.textStore);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)puttext:(UIButton *)sender {
   
}
@end
