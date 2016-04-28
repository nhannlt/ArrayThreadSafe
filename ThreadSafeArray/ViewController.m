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
    NSMutableArray *arrTmp;
}

@property (strong, nonatomic) NSMutableArray *mutableArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
- (void)viewDidAppear:(BOOL)animated {


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
