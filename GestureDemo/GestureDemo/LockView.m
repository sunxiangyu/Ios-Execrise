//
//  LockView.m
//  GestureDemo
//
//  Created by 孙翔宇 on 15/6/23.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "LockView.h"

@interface LockView()

@property(nonatomic, strong) NSMutableArray *buttons;

@property(nonatomic, assign) CGPoint currentPoint;

@end

@implementation LockView


-(NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
    
}

-(void)setup
{
    
    for (int i = 0; i < 9; i++) {
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        [self addSubview:btn];
        
        btn.userInteractionEnabled = NO;
        
        btn.tag = i;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        
        CGFloat btnW = 74;
        CGFloat btnH = 74;
        
        CGFloat margin = (self.frame.size.width - 3 * btnW) / 4;
        CGFloat col = i % 3;
        CGFloat row = i / 3;
        CGFloat btnX = margin + col * (btnW + margin);
        CGFloat btnY = margin + row * (btnH + margin);
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint startPoint = [self getCurrentTouchPoint:touches];
    
    UIButton *btn = [self getCurrentBtnWithPoint:startPoint];
    
    if (btn) {
        btn.selected = YES;
        
        [self.buttons addObject:btn];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint movePoint = [self getCurrentTouchPoint:touches];
    
    UIButton *btn = [self getCurrentBtnWithPoint:movePoint];
    
    if (btn && btn.selected != YES) {
        btn.selected = YES;
        
        [self.buttons addObject:btn];
    }
    
    self.currentPoint = movePoint;
    
    [self setNeedsDisplay];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableString *result = [NSMutableString string];
    
    for (UIButton *btn in self.buttons) {
        [result appendFormat:@"%ld", (long)btn.tag];
    }
    
    if ([self.delegate respondsToSelector:@selector(lockViewDidClick:andPwd:)]) {
        [self.delegate lockViewDidClick:self andPwd:result];
    }
    
    [self.buttons makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    
    [self.buttons removeAllObjects];
    [self setNeedsDisplay];
}

-(CGPoint)getCurrentTouchPoint:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:touch.view];
    return startPoint;
}

-(UIButton *)getCurrentBtnWithPoint:(CGPoint)point
{
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *btn = self.buttons[i];
        if (i == 0) {
            CGContextMoveToPoint(ctx, btn.center.x, btn.center.y);
        }else {
            CGContextAddLineToPoint(ctx, btn.center.x, btn.center.y);
        }
    }
    
    if (self.buttons.count != 0) {
        CGContextAddLineToPoint(ctx, self.currentPoint.x, self.currentPoint.y);
    }
    
    [[UIColor greenColor] set];
    CGContextSetLineWidth(ctx, 10);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextStrokePath(ctx);
}

@end
