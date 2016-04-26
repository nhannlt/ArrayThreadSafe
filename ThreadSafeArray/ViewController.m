//
//  ViewController.m
//  ThreadSafeArray
//
//  Created by Nguyen Le Trong Nhan on 4/26/16.
//  Copyright © 2016 Trong Nhan Nguyen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    ArrayThreadSafe *arrayList;
}

@property (nonatomic) NSThread *searchThread;
@property (weak, nonatomic) ArrayThreadSafe *mutableArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    arrayList = [[ArrayThreadSafe alloc] init];
    for (int i = 0; i< 1000; i++) {
        
        [arrayList addObject:[NSNumber numberWithInt:i]];
    }


    
    
}
- (void)viewDidAppear:(BOOL)animated {

   [self testArray];

}



- (void) testArray{
    NSString *name = @"das.adsd.ads";
    dispatch_queue_t queue = dispatch_queue_create([name UTF8String], DISPATCH_QUEUE_CONCURRENT);
    

    
    dispatch_async(queue, ^{
        for (int i = 0; i< 1000; i++) {
            
//            
//           // if (arrayList.count > i) {
//                id num = [arrayList objectAtIndex:i];
//                NSLog(@"index2: %li",(long)[num integerValue]);
//           // }
            
           // NSLog(@"LOG2_1: %li",[arrayList[i] integerValue]);
            
            //arrayList[i] = [NSNumber numberWithInt:8888888];
            
            NSLog(@"LOG queue 2: %i",[(NSNumber*)[arrayList getObjectAtIndex:i] intValue]);
            
            
        };
    });
    dispatch_async(queue, ^{
        
        // for (int i = 0; i< 1000; i++) {
        
        //            [arrayList removeObjectAtIndex:i];
        //            [arrayList insertObject:[NSNumber numberWithInt:999999] atIndex:i];
        
        // NSLog(@"LOG1_1: %li",[arrayList[i] integerValue]);
        
        // arrayList[i] = [NSNumber numberWithInt:999999];
        
        [arrayList replaceObjectWithObjectAtIndex:[NSNumber numberWithInt:999999] AtIndex:10];
        
        // NSLog(@"LOG queue 1: %i",[(NSNumber*)[arrayList getObjectAtIndex:i] intValue]);
        //  };
        
    });
    
    
};




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
