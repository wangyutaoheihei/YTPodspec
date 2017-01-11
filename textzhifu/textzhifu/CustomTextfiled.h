//
//  CustomTextfiled.h
//  textzhifu
//
//  Created by ZhiCheng on 2017/1/5.
//  Copyright © 2017年 玉涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTextfiled;
@protocol CustomTextDelegate <NSObject>
//输入的改变
- (void)passWordDidChange:(CustomTextfiled *)passWord;
//输入的完成
- (void)passWordCompleteInput:(CustomTextfiled *)passWord;

@end

@interface CustomTextfiled : UIView<UIKeyInput>
@property (weak, nonatomic) id<CustomTextDelegate>delegate;
@property(nonatomic, assign) NSInteger textFieldCount;
@property (assign, nonatomic) CGFloat squareWidth;//正方形的大小
@property (strong, nonatomic) NSMutableString *textStore;//保存密码的字符串

- (void)cleanNum;
@end
