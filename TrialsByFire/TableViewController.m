//
//  TableViewController.m
//  TrialsByFire
//
//  Created by jpk on 6/1/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

#import "TableViewController.h"
#import "AddViewController.h"

//declares how you access
@interface TableViewController ()
//main file has private items
//@property (nonatomic) NSArray * privateItems;

@end

@implementation TableViewController

{   //no properties, no getter/setter, just an instance variable
    NSMutableArray * items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    items = [[NSMutableArray alloc] initWithArray:[[NSArray alloc] init]];
    items = [@[@"Fight a Robot", @"Kiss an Alien"] mutableCopy];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"itemCell"];
  
//                            //class, class method, instance method
//    NSArray * methodItems = [[NSArray alloc] init];
//                            //literal that is running the alloc, init @ is allocating and initing an object
//    NSArray * literalItems = @[];
//    
//    items = @[];
    
//    //is the property - a property gets/sets to the instance variable
//    self.publicItems = @[@"Item1",@"Item"];
//    //is the instance variable - directly accesses the value
//    _publicItems = @[@"Item3",@"Item4"];
//    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
    
}

- (void)setPublicItems:(NSMutableArray *)publicItems {
    //format string - string that is going to formatter inside of it that will be replaced
    NSLog(@"%@", publicItems);
    //if you override the property you must have the bottom line
    _publicItems = publicItems;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    
    cell.textLabel.text = items[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    AddViewController * addVC = segue.destinationViewController;
    
    addVC.items = items; 
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
