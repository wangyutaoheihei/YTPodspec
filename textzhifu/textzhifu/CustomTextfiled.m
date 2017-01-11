//
//  CustomTextfiled.m
//  textzhifu
//
//  Created by ZhiCheng on 2017/1/5.
//  Copyright © 2017年 玉涛. All rights reserved.
//

#import "CustomTextfiled.h"

@interface CustomTextfiled ()

@property (assign, nonatomic) NSInteger intcount;
@end

@implementation CustomTextfiled
static NSString  * const MONEYNUMBERS = @"0123456789";

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupBorder];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupBorder];
    }
    return self;
}
- (void)setupBorder {
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4.0;
    [self becomeFirstResponder];
    self.textStore = [NSMutableString string];
}
/**
 *  设置正方形的边长
 */
- (void)setSquareWidth:(CGFloat)squareWidth {
    _squareWidth = squareWidth;
    [self setNeedsDisplay];
}
- (BOOL)becomeFirstResponder {
       return [super becomeFirstResponder];
}
//点击成为第一响应者
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}
//键盘类型
- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)setTextFieldCount:(NSInteger)textFieldCount {
    self.intcount = textFieldCount;
}
//重绘
- (void)drawRect:(CGRect)rect {
   
     self.squareWidth = self.frame.size.width/self.intcount;
        for (int i = 0; i < self.intcount; i ++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        //设置线条样式
        CGContextSetLineCap(context, kCGLineCapSquare);
        //设置线条粗细宽度
        CGContextSetLineWidth(context, 1.0);
        
        //设置颜色
        CGContextSetRGBStrokeColor(context, 0.6, 0.6, 0.6, 1);
        //开始一个起始路径
        CGContextBeginPath(context);
        if (i != 0 ) {
           //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
        CGContextMoveToPoint(context, self.squareWidth*i, 0);
        //设置下一个坐标点
        CGContextAddLineToPoint(context, self.squareWidth*i,self.frame.size.height);
        }
        //连接上面定义的坐标点
        CGContextStrokePath(context);
    }
    

   
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i< self.textStore.length; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i * (self.squareWidth)+1, 0,self.squareWidth-1, self.frame.size.height)];
        NSString *code;
        if (self.textStore.length > 0) {
            code = [self.textStore substringWithRange:NSMakeRange(i,1)];
        }
        
        label.text = code;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
    }

}
//删除按钮
- (void)cleanNum {
    for (UILabel *lab in self.subviews) {
        lab.text = @"";
    }
    self.textStore = nil;
    self.textStore = [NSMutableString string];
    [self becomeFirstResponder];
}

#pragma mark ------UIKeyInput的系统方法
//删除
- (void)deleteBackward {
    if (self.textStore.length > 0) {
        [self.textStore deleteCharactersInRange:NSMakeRange(self.textStore.length - 1, 1)];
        if ([self.delegate respondsToSelector:@selector(passWordDidChange:)]) {
            [self.delegate passWordDidChange:self];
        }
           }
    [self setNeedsDisplay];

}
//输入
- (void)insertText:(NSString *)text {
    if (self.textStore.length < self.intcount) {
        //判断是否是数字
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:MONEYNUMBERS] invertedSet];
        NSString*filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [text isEqualToString:filtered];
        
        if(basicTest) {
            [self.textStore appendString:text];
            
          
            if ([self.delegate respondsToSelector:@selector(passWordDidChange:)]) {
                [self.delegate passWordDidChange:self];
            }
            
            if (self.textStore.length == self.intcount) {
                [self resignFirstResponder];
            if ([self.delegate respondsToSelector:@selector(passWordCompleteInput:)]) {
                    [self.delegate passWordCompleteInput:self];
                }
            }
            
            
            
           }
        
        
               [self setNeedsDisplay];
        
        
    }

}
- (BOOL)hasText {
    return self.textStore.length > 0;
}
@end
