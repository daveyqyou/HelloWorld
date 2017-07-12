//
//  YQAlertView.m
//  YQAlertView
//
//  Created by yongqiang.you on 2017/4/1.
//  Copyright © 2017年 yongqiang.you. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define UIColorFromHex(s)  ([UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0])
#import "YQAlertView.h"
@interface  YQAlertView()
@property(nonatomic,retain)UIView *alertView;

@property(nonatomic,retain)UIButton *boyBtn;
@property(nonatomic,retain)UIButton *girlBtn;

@property(nonatomic,copy)NSString *boy;
@property(nonatomic,copy)NSString *girl;

@property (nonatomic, strong) UIButton *confirmBtn;
@end
@implementation YQAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        //男孩按钮
        _boyBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 20, 80, 40)];

        [_boyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_boyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_boyBtn setImage:[UIImage imageNamed:@"weixuanzhong--xingbie"] forState:UIControlStateNormal];
        [_boyBtn setImage:[UIImage imageNamed:@"xingbie-xuanzhong"] forState:UIControlStateSelected];
        _boyBtn.selected = YES;
        [_boyBtn addTarget:self action:@selector(boyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_boyBtn];
 
        //女孩按钮
        _girlBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-120, 20, 80, 40)];

        [_girlBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_girlBtn setImage:[UIImage imageNamed:@"weixuanzhong--xingbie"] forState:UIControlStateNormal];
        [_girlBtn setImage:[UIImage imageNamed:@"xingbie-xuanzhong"] forState:UIControlStateSelected];
        _girlBtn.selected = NO;
        [_girlBtn addTarget:self action:@selector(girlBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_girlBtn];
        
        //确定按钮
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width/3, CGRectGetMaxY(self.frame)-60, self.bounds.size.width/3, 50)];
        
        [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_confirmBtn setImage:[UIImage imageNamed:@"ensure"] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_confirmBtn];
    }
    return self;
}
#pragma mark----实现类方法
+(instancetype)alterViewWithChooseBoy:(NSString *)boy girl:(NSString *)girl
{
    YQAlertView *alertView = [[YQAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-80, SCREEN_HEIGHT/4)];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.center =CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT*3/8);
    alertView.layer.cornerRadius = 10;
//    alertView.layer.masksToBounds = YES;
    //添加四边阴影
    alertView.layer.shadowColor = UIColorFromHex(0x666666).CGColor;//shadowColor阴影颜色
    alertView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    alertView.layer.shadowOpacity = 1;//阴影透明度，默认0
    alertView.layer.shadowRadius = 3;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = alertView.bounds.size.width;
    float height = alertView.bounds.size.height;
    float x = alertView.bounds.origin.x;
    float y = alertView.bounds.origin.y;
    float addWH = 10;
    
    CGPoint topLeft      = alertView.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);
    
    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);
    
    
    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
    
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    //设置阴影路径
    alertView.layer.shadowPath = path.CGPath;
    
    alertView.boy = boy;
    alertView.girl = girl;
    return alertView;
}
#pragma mark--给属性重新赋值

- (void)setBoy:(NSString *)boy {
    [_boyBtn setTitle:boy forState:UIControlStateNormal];
}

- (void)setGirl:(NSString *)girl {
    [_girlBtn setTitle:girl forState:UIControlStateNormal];
}

#pragma mark----男孩按钮点击事件
-(void)boyBtnClick:(UIButton *)sender {
    sender.selected = YES;
    self.girlBtn.selected = NO;
}
#pragma mark----女孩按钮点击事件
-(void)girlBtnClick:(UIButton *)sender {
    sender.selected = YES;
    self.boyBtn.selected = NO;

}
#pragma mark----确定按钮点击事件
-(void)confirmBtnClick:(UIButton *)sender {
    if (self.boyBtn.selected == YES) {
        NSLog(@"选择了男");
    }else {
        NSLog(@"选择了女");
    }
    [self removeFromSuperview];
}
@end
