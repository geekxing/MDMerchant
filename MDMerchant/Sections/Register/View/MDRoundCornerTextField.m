//
//  MDRoundCornerTextField.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDRoundCornerTextField.h"

@implementation MDRoundCornerTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = UIFontMake(11);
        self.background = [UIImage imageNamed:@"register_round_field"];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGFloat gap = UIWidthRatio(18);
    return CGRectMake(bounds.origin.x+gap, 0, bounds.size.width - 2*gap, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGFloat gap = UIWidthRatio(17);
    return CGRectMake(bounds.origin.x+gap, 0, bounds.size.width - 2*gap, bounds.size.height);
}

-(void)drawPlaceholderInRect:(CGRect)rect {
    // 计算占位文字的 Size
    CGSize placeholderSize = [self.placeholder sizeWithAttributes:
                              @{NSFontAttributeName : self.font}];
    
    [self.placeholder drawInRect:CGRectMake(0, (rect.size.height - placeholderSize.height)/2, rect.size.width, rect.size.height) withAttributes:
     @{NSForegroundColorAttributeName : [UIColor blackColor],
       NSFontAttributeName : self.font}];
}

@end
