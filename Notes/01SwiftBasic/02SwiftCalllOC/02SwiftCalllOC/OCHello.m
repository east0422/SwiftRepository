//
//  OCHello.m
//  02SwiftCalllOC
//
//  Created by dfang on 2020-9-1.
//  Copyright © 2020 east. All rights reserved.
//

#import "OCHello.h"

@implementation OCHello

- (void)say {
    NSLog(@"Swift call OC say");
}

- (void)print:(NSString *)str {
    NSLog(@"Swict call OC print: with %@", str);
}

@end
