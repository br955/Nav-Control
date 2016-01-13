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
    Company *apple = [[Company alloc]initWithName:@"Apple Mobile Devices" Icon:@"AppleIcon.png"];
    Company *samsung = [[Company alloc]initWithName:@"Samsung Mobile Devices"Icon:@"SamsungIcon.png"];
    Company *lg = [[Company alloc]initWithName:@"LG Electronics"Icon:@"LGIcon.png"];
    Company *pantech = [[Company alloc]initWithName:@"Pantech"Icon:@"pantechicon.png"];
  //
    Product *iPad = [[Product alloc]initWithName:@"iPad" SiteURL:@"http://www.apple.com/ipad/" Icon:@"iPadLogo.jpeg"];
    Product *iPodTouch = [[Product alloc]initWithName:@"iPod Touch" SiteURL:@"http://www.apple.com/ipod-touch/" Icon:@"iPodTouchLogo.jpeg"];
    Product *iPhone = [[Product alloc]initWithName:@"iPhone" SiteURL:@"http://www.apple.com/iphone/"Icon:@"iPhoneLogo.png"];
    Product *s4 = [[Product alloc]initWithName:@"Galaxy S4" SiteURL:@"http://www.samsung.com/global/microsite/galaxys4/" Icon:@"GalaxyS4logo.jpeg"];
    Product *note = [[Product alloc]initWithName:@"Galaxy Note" SiteURL:@"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find" Icon:@"GalaxyNoteLogo.jpeg"];
    Product *tab = [[Product alloc]initWithName:@"Galaxy Tab" SiteURL:@"http://www.samsung.com/global/microsite/galaxytab/10.1/index.html"Icon:@"GalaxyTabLogo.jpeg"];
    Product *g4 = [[Product alloc]initWithName:@"G4" SiteURL:@"http://www.lg.com/us/mobile-phones/g4" Icon: @"G4Logo.jpeg"];
    Product *gWatch = [[Product alloc]initWithName:@"G Watch" SiteURL:@"http://www.lg.com/global/gwatch/index.html#main" Icon:@"GWatchLogo.jpeg"];
    Product *gFlex = [[Product alloc]initWithName:@"G Flex" SiteURL:@"http://www.lg.com/us/lg-g-flex-phones" Icon:@"GFlexLogo.jpeg"];
    Product *breakout = [[Product alloc]initWithName:@"Breakout" SiteURL:@"http://www.pantechusa.com/phones/breakout"Icon:@"BreakoutLogo.jpeg"];
    Product *hotshot = [[Product alloc]initWithName:@"Hotshot" SiteURL:@"http://www.gsmarena.com/pantech_breakout-4294.php"Icon:@"EaseLogo.jpeg"];
    Product *ease = [[Product alloc]initWithName:@"Ease" SiteURL:@"http://www.gsmarena.com/pantech_ease-3405.php"Icon:@"HotshotLogo.jpeg"];
  //
    apple.productList = [NSMutableArray arrayWithObjects:iPad, iPodTouch, iPhone, nil];
    samsung.productList= [NSMutableArray arrayWithObjects:s4, note, tab, nil];
    lg.productList = [NSMutableArray arrayWithObjects:g4,gWatch, gFlex, nil];
    pantech.productList = [NSMutableArray arrayWithObjects:breakout, hotshot, ease, nil];
    
    self.companies = [NSMutableArray arrayWithObjects:apple, samsung, lg, pantech, nil];
    }
    return self;
}

-(NSMutableArray*) addCompany: (NSString*) name{
    Company *newCompany = [[Company alloc] init];
    newCompany.name = name;
    [self.companies addObject: newCompany];
    return self.companies;
}

-(NSMutableArray*) addProduct: (NSString*) name forCompany: (NSString*) company{
    Product *newProduct = [[Product alloc]init];
    newProduct.name = name;
    int i = 0;
    while(i<self.companies.count){
        if([[[self.companies objectAtIndex:i] valueForKey:@"name"] isEqualToString:company]){
            Company *temp = [self.companies objectAtIndex:i];
            [temp.productList addObject:newProduct];
            self.companies[i] = temp;
        }
        i++;
    }
    return self.companies;
}

-(NSMutableArray*) getCompanyData{
    return self.companies;
}

@end








