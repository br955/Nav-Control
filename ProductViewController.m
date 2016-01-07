//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.apple = [NSMutableArray arrayWithObjects:@"iPad", @"iPod Touch",@"iPhone", nil];
    self.samsung= [NSMutableArray arrayWithObjects:@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab", nil];
    self.lg = [NSMutableArray arrayWithObjects:@"G4",@"G Watch", @"G Flex", nil];
    self.pantech = [NSMutableArray arrayWithObjects:@"Breakout", @"Hotshot", @"Ease", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
        self.products = self.apple;
    }
    else if ([self.title isEqualToString:@"Samsung mobile devices"]){
        self.products = self.samsung;
    }
    else if ([self.title isEqualToString:@"LG Electronics"]){
        self.products = self.lg;
    }
    else {
        self.products = self.pantech;
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [self.products objectAtIndex:[indexPath row]];
    if ([cell.textLabel.text isEqualToString:@"iPad"]) {
        cell.imageView.image = [UIImage imageNamed:@"iPadLogo.jpeg"];
    }
    else if ([cell.textLabel.text isEqualToString:@"iPod Touch"]){
        cell.imageView.image = [UIImage imageNamed:@"iPodTouchLogo.jpeg"];
    }
    else if ([cell.textLabel.text isEqualToString:@"iPhone"]){
        cell.imageView.image = [UIImage imageNamed:@"iPhoneLogo.png"];
    }
    else if ([cell.textLabel.text isEqualToString:@"Galaxy S4"]){
        cell.imageView.image = [UIImage imageNamed:@"GalaxyS4logo.jpeg"];
    }
    else if ([cell.textLabel.text isEqualToString:@"Galaxy Note"]){
        cell.imageView.image = [UIImage imageNamed:@"GalaxyNoteLogo.jpeg"];
    }
    else if ([cell.textLabel.text isEqualToString:@"Galaxy Tab"]){
        cell.imageView.image = [UIImage imageNamed:@"GalaxyNoteLogo.jpeg"];
    }
    else if([cell.textLabel.text isEqualToString:@"G4"]){
        cell.imageView.image = [UIImage imageNamed:@"G4Logo.jpeg"];
    }
    else if ([cell.textLabel.text isEqualToString:@"G Watch"]){
        cell.imageView.image = [UIImage imageNamed:@"GWatchLogo.jpeg"];
    }
    else if ([cell.textLabel.text isEqualToString:@"G Flex"]){
        cell.imageView.image = [UIImage imageNamed:@"GFlexLogo.jpeg"];
    }
    else if ([cell.textLabel.text isEqualToString:@"Breakout"]){
        cell.imageView.image = [UIImage imageNamed:@"BreakoutLogo.jpeg"];
    }
    else if ([cell.textLabel.text isEqualToString:@"Ease"]){
        cell.imageView.image = [UIImage imageNamed:@"EaseLogo.jpeg"];
    }
    else if ([cell.textLabel.text isEqualToString:@"Hotshot"]){
        cell.imageView.image = [UIImage imageNamed:@"HotshotLogo.jpeg"];
    }
    return cell;
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    NSString *stringToMove = [self.products objectAtIndex:fromIndexPath.row];
    [self.products removeObjectAtIndex:fromIndexPath.row];
    [self.products insertObject:stringToMove atIndex:toIndexPath.row];

}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:

    // Create the next view controller.
    //if (self.page == nil) {
        ProductWebViewViewController *temp = [[ProductWebViewViewController alloc] initWithNibName:@"ProductWebViewViewController" bundle:[NSBundle mainBundle]];
        self.page = temp;
        [temp release];
    //}
    if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"iPad"]) {
        self.page.URLName = @"http://www.apple.com/ipad/";
    }
    else if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"iPhone"]) {
        self.page.URLName = @"http://www.apple.com/iphone/";
    }
    else if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"iPod Touch"]) {
        self.page.URLName = @"http://www.apple.com/ipod-touch/";
    }
    else if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"Galaxy S4"]) {
        self.page.URLName = @"http://www.samsung.com/global/microsite/galaxys4/";
    }
    else if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"Galaxy Note"]) {
        self.page.URLName = @"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find";
    }
    else if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"Galaxy Tab"]) {
        self.page.URLName = @"http://www.samsung.com/global/microsite/galaxytab/10.1/index.html";
    }
    else if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"G4"]) {
        self.page.URLName = @"http://www.lg.com/us/mobile-phones/g4";
    }
    else if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"G Watch"]) {
        self.page.URLName = @"http://www.lg.com/global/gwatch/index.html#main";
    }
    else if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"G Flex"]) {
        self.page.URLName = @"http://www.lg.com/us/lg-g-flex-phones";
    }
    else if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"Breakout"]) {
        self.page.URLName = @"http://www.pantechusa.com/phones/breakout";
    }
    else if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"Ease"]) {
        self.page.URLName = @"http://www.gsmarena.com/pantech_ease-3405.php";
    }
    else if ([[self.products objectAtIndex:[indexPath row]] isEqualToString:@"Hotshot"]) {
        self.page.URLName = @"http://www.gsmarena.com/pantech_breakout-4294.php";
    }
   
    
    [self.navigationController pushViewController: self.page animated:YES];

    // Pass the selected object to the new view controller.

    // Push the view controller.

}

- (void)dealloc {
    [self.page release];
    [super dealloc];
}

@end











