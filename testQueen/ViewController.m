//
//  ViewController.m
//  testQueen
//
//  Created by zhangtao on 16/4/21.
//  Copyright © 2016年 zt.td. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)UIImage *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSString *urlStr = @"http://g.hiphotos.baidu.com/zhidao/pic/item/cc11728b4710b912f6e3451dc7fdfc0392452236.jpg";
        _image  =   [UIImage imageWithData:
                   [NSData dataWithContentsOfURL:
                   [NSURL URLWithString:urlStr]]];
    });
    dispatch_group_async(group, queue, ^{
        
        _images = [UIImage imageWithData:
                  [NSData dataWithContentsOfURL:
                  [NSURL URLWithString:
                     @"http://d.hiphotos.baidu.com/zhidao/pic/item/810a19d8bc3eb135e85952c6a51ea8d3fd1f4435.jpg"]]];
        
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 50, 50)];
        UIImageView *imageVs = [[UIImageView alloc]initWithFrame:CGRectMake(110, 100, 50, 50)];
        imageV.image = _image;
        imageVs.image = _images;
        [self.view addSubview:imageVs];
        [self.view addSubview:imageV];
        CGSize size = _image.size;
        NSLog(@"%lf,%lf",size.height,size.width);
    });
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 160, 50)];
    lab.numberOfLines = 0;
    lab.text = @"异步加载，全部加载完之后再进行处理";
//    lab.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lab];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
