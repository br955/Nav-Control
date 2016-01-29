//
//  ProductWebViewViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 1/6/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "ProductWebViewViewController.h"
#import "CompanyViewController.h"

@interface ProductWebViewViewController ()

@end

@implementation ProductWebViewViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    webView.navigationDelegate = self;
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    NSURL *nsurl=[NSURL URLWithString:self.URLName];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    
    [webView loadRequest:nsrequest];
    [self.view addSubview:webView];
    [webView release];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [super dealloc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
