//
//  MDSystemCallerUtil.m
//  MDMerchant
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDSystemCallerUtil.h"

@implementation MDSystemCallerUtil

+ (void)makeCallWithPhoneNumber:(NSString *)phoneNumber {
    [self phoneCallConfirm:phoneNumber];
}

#pragma mark - Private

+ (void)phoneCallConfirm:(NSString *)phone {
    NSString *telUrl = [NSString stringWithFormat:@"tel://%@", phone];
    if (kSystemVersion >= 10.0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
    }
}

+ (void)copyText:(NSString *)text {
    if (text.length) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:text];
    }
}

@end
