//
//  DAO.m
//  NavCtrl
//
//  Created by Aditya Narayan on 1/8/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO

+(id) sharedManager {
    static DAO *theManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theManager = [[self alloc] init];
    });
    return theManager;
}

-(id) init{
    self = [super init];
    if(self){
    Company *apple = [[Company alloc]initWithName:@"Apple Mobile Devices" Icon:[UIImage imageNamed:@"AppleIcon.png"]];
    Company *samsung = [[Company alloc]initWithName:@"Samsung Mobile Devices"Icon:[UIImage imageNamed:@"SamsungIcon.png"]];
    Company *lg = [[Company alloc]initWithName:@"LG Electronics"Icon:[UIImage imageNamed:@"LGIcon.png"]];
    Company *pantech = [[Company alloc]initWithName:@"Pantech"Icon:[UIImage imageNamed:@"pantechicon.png"]];
  //
    Product *iPad = [[Product alloc]initWithName:@"iPad" SiteURL:@"http://www.apple.com/ipad/" Icon:[UIImage imageNamed:@"iPadLogo.jpeg"]];
    Product *iPodTouch = [[Product alloc]initWithName:@"iPod Touch" SiteURL:@"http://www.apple.com/ipod-touch/" Icon:[UIImage imageNamed:@"iPodTouchLogo.jpeg"]];
    Product *iPhone = [[Product alloc]initWithName:@"iPhone" SiteURL:@"http://www.apple.com/iphone/"Icon:[UIImage imageNamed:@"iPhoneLogo.png"]];
    Product *s4 = [[Product alloc]initWithName:@"Galaxy S4" SiteURL:@"http://www.samsung.com/global/microsite/galaxys4/" Icon:[UIImage imageNamed:@"GalaxyS4logo.jpeg"]];
    Product *note = [[Product alloc]initWithName:@"Galaxy Note" SiteURL:@"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find" Icon:[UIImage imageNamed:@"GalaxyNoteLogo.jpeg"]];
    Product *tab = [[Product alloc]initWithName:@"Galaxy Tab" SiteURL:@"http://www.samsung.com/global/microsite/galaxytab/10.1/index.html"Icon:[UIImage imageNamed:@"GalaxyTabLogo.jpeg"]];
    Product *g4 = [[Product alloc]initWithName:@"G4" SiteURL:@"http://www.lg.com/us/mobile-phones/g4" Icon:[UIImage imageNamed:@"G4Logo.jpeg"]];
    Product *gWatch = [[Product alloc]initWithName:@"G Watch" SiteURL:@"http://www.lg.com/global/gwatch/index.html#main" Icon:[UIImage imageNamed:@"GWatchLogo.jpeg"]];
    Product *gFlex = [[Product alloc]initWithName:@"G Flex" SiteURL:@"http://www.lg.com/us/lg-g-flex-phones" Icon:[UIImage imageNamed:@"GFlexLogo.jpeg"]];
    Product *breakout = [[Product alloc]initWithName:@"Breakout" SiteURL:@"http://www.pantechusa.com/phones/breakout"Icon:[UIImage imageNamed:@"BreakoutLogo.jpeg"]];
    Product *hotshot = [[Product alloc]initWithName:@"Hotshot" SiteURL:@"http://www.gsmarena.com/pantech_breakout-4294.php"Icon:[UIImage imageNamed:@"EaseLogo.jpeg"]];
    Product *ease = [[Product alloc]initWithName:@"Ease" SiteURL:@"http://www.gsmarena.com/pantech_ease-3405.php"Icon:[UIImage imageNamed:@"HotshotLogo.jpeg"]];
  //
    apple.productList = [NSMutableArray arrayWithObjects:iPad, iPodTouch, iPhone, nil];
    samsung.productList= [NSMutableArray arrayWithObjects:s4, note, tab, nil];
    lg.productList = [NSMutableArray arrayWithObjects:g4,gWatch, gFlex, nil];
    pantech.productList = [NSMutableArray arrayWithObjects:breakout, hotshot, ease, nil];
    
    self.companies = [NSMutableArray arrayWithObjects:apple, samsung, lg, pantech, nil];
    
    }
    return self;
}

-(NSMutableArray*) getCompanyData{
    return self.companies;
}

@end
