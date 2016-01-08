//
//  ProductWebViewViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 1/6/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "DAO.h"

@interface ProductWebViewViewController : UIViewController <WKNavigationDelegate>

//@property (nonatomic, retain) IBOutlet UIWebView *productPage;
@property (nonatomic, retain) NSString *URLName;




@end
