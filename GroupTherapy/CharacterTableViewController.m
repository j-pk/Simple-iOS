//

#import "CharacterTableViewController.h"
#import <CommonCrypto/CommonDigest.h>

//
#define API_BASE @"http://gateway.marvel.com/v1/public/"
#define PUBLIC_KEY @"8954b10f8579696c76039c701fb23658" 
#define PRIVATE_KEY @"377a086a27bb149c7f787a42b4f097bfd7079363"

@interface CharacterTableViewController ()

@end

@implementation CharacterTableViewController
{
    NSArray * characters;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    int timeStamp = [NSDate date].timeIntervalSince1970;
    
    NSString * hash = [self MD5String:[NSString stringWithFormat:@"%d%@%@", timeStamp, PRIVATE_KEY, PUBLIC_KEY]];

    //connecting the base url with the endpoint
    NSString * endpoint = [NSString stringWithFormat:@"%@characters?ts=%d&apikey=%@&hash=%@", API_BASE, timeStamp, PUBLIC_KEY, hash];
    
    NSLog(@"%@", endpoint);
    
    //processing the URL as an URL
    NSURL * url = [NSURL URLWithString:endpoint];
    
    //send a request
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    //connect to the server
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
//        NSLog(@"%@", JSON);
        
        characters = JSON [@"data"][@"results"];
        
        NSLog(@"%@", characters);
        
        [self.tableView reloadData];
        
    }];
    
}

- (NSString *)MD5String:(NSString *)input {
    
    // Create pointer to the string as UTF8
    const char *ptr = [input UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
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
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return characters.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"charCell" forIndexPath:indexPath];
    //calling the key value from characters a
    cell.textLabel.text = characters[indexPath.row][@"name"];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
