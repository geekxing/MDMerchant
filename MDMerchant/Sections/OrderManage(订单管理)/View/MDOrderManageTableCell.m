//
//  MDOrderManageTableCell.m
//  MDMerchant
//
//  Created by apple on 2017/8/12.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDOrderManageTableCell.h"
#import "MDSystemCallerUtil.h"
#import <YYTextAsyncLayer.h>
#define CELL_GRAY MDOpaqueColor(242, 244, 245)
#define TEXT_ORANGE MDOpaqueColor(238, 150, 0)
#define headerH         29.f
#define normalCellH     40.f
#define cellMargin      UIWidthRatio(30.f)
#define contentMargin   UIWidthRatio(13.f)
#define cornerRadi      4.f

@interface MDOrderManageTableCell()
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIButton *phoneView;
@property (nonatomic, strong) UIButton *expandButton;
@end

@implementation MDOrderManageTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _numberLabel = [UILabel new];
    _numberLabel.backgroundColor = MDThemeYellow;
    _numberLabel.font = UIFontMakeS(13);
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.layer.cornerRadius = 3;
    _numberLabel.layer.masksToBounds = YES;
    _numberLabel.size = CGSizeMake(20, 20);
    _numberLabel.left = cellMargin+contentMargin;
    _numberLabel.centerY = headerH / 2;
    [self.contentView addSubview:_numberLabel];
    
    UIImage *phone  =[UIImage imageNamed:@"order_phone"];
    _phoneView = [UIButton buttonTitle:nil font:nil textColor:nil image:phone image2:phone state:UIControlStateNormal target:self action:@selector(call)];
    [self.contentView addSubview:_phoneView];

    _expandButton = [UIButton buttonTitle:nil font:UIFontMakeS(10) textColor:nil image:[UIImage imageNamed:@"order_arrow_down"] image2:[UIImage imageNamed:@"order_arrow_up"] state:UIControlStateSelected target:self action:@selector(expandMoreInfos:)];
    [self.contentView addSubview:_expandButton];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _phoneView.right = self.width - cellMargin - UIWidthRatio(10);
    _phoneView.centerY = headerH+normalCellH/2;
    _expandButton.right = self.width - cellMargin - contentMargin;
    _expandButton.centerY = headerH+normalCellH*5/2;
}

#pragma mark - Private
- (void)call {
    [MDSystemCallerUtil makeCallWithPhoneNumber:_order.phone];
}

- (void)expandMoreInfos:(UIButton *)btn {
    _order.layout.isExpand = !_order.layout.isExpand;
    [_order calcModelAndLayout];
    if (_didClickExpandButton) {
        _didClickExpandButton();
    }
}

#pragma mark - setter & getter
- (void)setOrder:(MDOrder *)order {
    _order = order;
    _expandButton.selected = _order.layout.isExpand;
    [self.layer setNeedsDisplay];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    _numberLabel.text = @(index).stringValue;
}

+(Class)layerClass {
    return [YYTextAsyncLayer class];
}
#pragma mark Draw

- (YYTextAsyncLayerDisplayTask *)newAsyncDisplayTask {
    
    YYTextAsyncLayerDisplayTask *task = [YYTextAsyncLayerDisplayTask new];
    
    task.display = ^(CGContextRef context, CGSize size, BOOL(^isCancelled)(void)) {
        if (isCancelled()) return;
        NSString *nickname = @"用户昵称";
        NSString *totalPrice = [NSString stringWithFormat:@"%@",_order.realInCome];
        NSString *phone = [NSString stringWithFormat:@"手机号：%@", _order.phone];
        NSString *arrive = [NSString stringWithFormat:@"预计到店时间：%@",_order.time_arrive];
        NSString *goodsTitle = @"商品";
        NSArray <NSString *>*baseTitleArr = @[phone,arrive,goodsTitle];
        
        CGFloat leftMargin = cellMargin+contentMargin;
        CGFloat titleY = (normalCellH - 10)*.5;
        CGFloat rightTextRight = self.width-contentMargin-cellMargin;
        
        CGContextSaveGState(context);
        [CELL_GRAY set];
        UIBezierPath *headerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(cellMargin, 0, self.width - 2*cellMargin, headerH) cornerRadius:cornerRadi];
        [headerPath addClip];
        [headerPath fill];
        NSDictionary *blackAttr = @{NSFontAttributeName:UIFontMakeS(10),NSForegroundColorAttributeName:[UIColor blackColor]};
        [nickname drawAtPoint:CGPointMake(_numberLabel.right + 7, 9) withAttributes:blackAttr];
        NSDictionary *big_attr =@{NSFontAttributeName:UIFontMakeS(13),NSForegroundColorAttributeName:TEXT_ORANGE};
        [totalPrice drawAtPoint:CGPointMake(rightTextRight-_order.layout.real_income_big_width, 9) withAttributes:big_attr];
        CGContextRestoreGState(context);
        
        [[UIColor whiteColor] set];
        UIBezierPath *bodyPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(cellMargin, headerH, self.width - 2*cellMargin, self.height-10) cornerRadius:cornerRadi];
        [bodyPath addClip];
        [bodyPath fill];
        
        [baseTitleArr enumerateObjectsUsingBlock:^(NSString * str, NSUInteger idx, BOOL * _Nonnull stop) {
            [str drawAtPoint:CGPointMake(leftMargin, headerH+titleY+idx*normalCellH) withAttributes:blackAttr];
            if (idx < baseTitleArr.count-1) {
                CGContextSetStrokeColorWithColor(context, MDDefaultBgColor.CGColor);
                CGContextSetLineWidth(context, .34);
                CGFloat lineY = headerH+(idx+1)*normalCellH;
                CGContextMoveToPoint(context, leftMargin, lineY);
                CGContextAddLineToPoint(context, self.width - leftMargin, lineY);
                CGContextStrokePath(context);
            }
        }];
    };
    
    return task;
}


@end
