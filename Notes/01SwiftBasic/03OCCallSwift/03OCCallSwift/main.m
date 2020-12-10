//
//  main.m
//  03OCCallSwift
//
//  Created by dfang on 2020-9-1.
//  Copyright © 2020 east. All rights reserved.
//

#import <Foundation/Foundation.h>
// 工程名首个标识符0被转为_
//#import "03OCCallSwift-Swift.h"
#import "_3OCCallSwift-Swift.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        SwiftHello *hello = [[SwiftHello alloc] init];
        [hello hi];
        [hello sayWithParams:@"OC call Swift"];
    }
    return 0;
}
