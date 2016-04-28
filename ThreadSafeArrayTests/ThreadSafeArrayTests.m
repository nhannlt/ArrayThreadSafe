//
//  ThreadSafeArrayTests.m
//  ThreadSafeArrayTests
//
//  Created by Nguyen Le Trong Nhan on 4/26/16.
//  Copyright © 2016 Trong Nhan Nguyen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArrayThreadSafe.h"


@interface ThreadSafeArrayTests : XCTestCase
{
    
    ArrayThreadSafe *arrayList;
    NSMutableArray *mutableArray;
    NSArray *array;
}



@end

@implementation ThreadSafeArrayTests

- (void)setUp {
    [super setUp];
    mutableArray = [NSMutableArray new];
    for (int i = 0; i< 100000; i++) {
        
        [mutableArray addObject:[NSNumber numberWithInt:0]];
    }
    arrayList = [[ArrayThreadSafe alloc] init];
    array = [NSArray new];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCrashCase{

    // Crash when multi READ
    {
        //mutableArray = [NSMutableArray new];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_apply(100000, queue, ^(size_t index) {
            [mutableArray objectAtIndex:index];
           
        });
        
    }
    
    {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        for (int i = 0; i < 100000; i++) {
            dispatch_async(queue, ^{
                [mutableArray addObject:[NSNumber numberWithInt:0]];
                [mutableArray objectAtIndex:i];
            });
        };
    }
    // Crash when multi WRITE
    {
        mutableArray = [NSMutableArray new];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_apply(10000, queue, ^(size_t index) {
            [mutableArray addObject:[NSNumber numberWithInt:index]];
        });
 
    }
    
}
- (void)testMultiWrite{
    
    // Test multi WRITE.
    
        arrayList = [[ArrayThreadSafe alloc] init];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_apply(10000, queue, ^(size_t index) {
            [arrayList addObject:[NSNumber numberWithInt:index]];
        });
        XCTAssertTrue([[arrayList getAllObject] count] == 10000, @"All Items should be 10000");
        

};
- (void)testMultiReadAndSingleWrite{
    // Test support multi READ adn single WRITE.
    {
        arrayList = [[ArrayThreadSafe alloc] init];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_apply(10000, queue, ^(size_t index) {
            [arrayList addObject:[NSNumber numberWithInt:index]];
            [[arrayList getObjectAtIndex:index] integerValue];
            //[[arrayList getAllObject] count];
            
        });
        XCTAssertTrue([[arrayList getAllObject] count] == 10000, @"All Items should be 10000");
    }
}
- (void)testAddAndRemove{
    // Test Add and Remove
    {
        arrayList = [[ArrayThreadSafe alloc] init];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_apply(10000, queue, ^(size_t index) {
            [arrayList addObject:[NSNumber numberWithInt:index]];
            [[arrayList getObjectAtIndex:index] integerValue];
            [arrayList removObjectAtIndex:0];
            
            
        });
        XCTAssertTrue([[arrayList getAllObject] count] == 0, @"All Items should be 0");
    }
}




- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
