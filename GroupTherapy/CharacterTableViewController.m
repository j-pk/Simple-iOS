//Normal
//- Add an image for the character to each cell (use dispatch_async to make sure getting the image data is on a background thread)
//- A circle with a number of the total comics the character appears in.
//- Change the limit to 50
//
//Hard
//- When you scroll to end of table view run a request for more characters
//- You will need to set an offset of the amount of current characters you have collected
//- You will need to append the returned characters to the end of the characters array
//
//Nightmare
//- Add a loading spinner while waiting for request to finish
//- Add a searchbar at the top to search for a specific character name (this will change all queries including the ones to get extra characters as you scroll)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CharacterTableViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "CharacterTableViewCell.h"

//
#define API_BASE @"http://gateway.marvel.com/v1/public/"
#define PUBLIC_KEY @"8954b10f8579696c76039c701fb23658" 
#define PRIVATE_KEY @"377a086a27bb149c7f787a42b4f097bfd7079363"

@interface CharacterTableViewController () <UIScrollViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@end


@implementation CharacterTableViewController
{
    NSArray * characters;
}

@synthesize characterSearchBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    characterSearchBar.delegate = self;
    
    characters = @[];
    
    [self getCharacters];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

-(void)scrollViewDidScroll: (UIScrollView*)scrollView
{
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset == 0){ //no code - if it it all the top
    }
    else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
    {
        [self getCharacters];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    int timeStamp = [NSDate date].timeIntervalSince1970;
    
    NSString * hash = [self MD5String:[NSString stringWithFormat:@"%d%@%@", timeStamp, PRIVATE_KEY, PUBLIC_KEY]];
    
    NSString * searchString = [NSString stringWithFormat:@"%@", characterSearchBar.text];
    
    //connecting the base url with the endpoint
    NSString * endpoint = [NSString stringWithFormat:@"%@characters?name=%@&ts=%d&apikey=%@&hash=%@",searchString,API_BASE,timeStamp, PUBLIC_KEY, hash];
    
    NSLog(@"%@", endpoint);
    
    //processing the URL as an URL
    NSURL * url = [NSURL URLWithString:endpoint];
    
    //send a request
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    //connect to the server
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        //NSLog(@"%@", JSON);
        
        characters = JSON [@"data"][@"results"];
        
//      characters = [characters arrayByAddingObjectsFromArray:JSON [@"data"][@"results"]];
        
        NSLog(@"%@", characters);
        
        [self.tableView reloadData];
        
    }];

    
}

- (void)getCharacters {
    
    int timeStamp = [NSDate date].timeIntervalSince1970;
    
    NSString * hash = [self MD5String:[NSString stringWithFormat:@"%d%@%@", timeStamp, PRIVATE_KEY, PUBLIC_KEY]];
    
    //connecting the base url with the endpoint
    NSString * endpoint = [NSString stringWithFormat:@"%@characters?limit=50&offset=%d&ts=%d&apikey=%@&hash=%@", API_BASE,characters.count,timeStamp, PUBLIC_KEY, hash];
    
//    NSLog(@"%@", endpoint);
    
    //processing the URL as an URL
    NSURL * url = [NSURL URLWithString:endpoint];
    
    //send a request
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    //connect to the server
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        //NSLog(@"%@", JSON);
        
        //characters = JSON [@"data"][@"results"];
        
        characters = [characters arrayByAddingObjectsFromArray:JSON [@"data"][@"results"]];
        
//        NSLog(@"%@", characters);
        
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return characters.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CharacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"charCell" forIndexPath:indexPath];
    //calling the key value from characters a
    
    NSDictionary * character = characters[indexPath.row];
    
    cell.charNameTextLabel.text = character[@"name"];
    
    int comicBookCount = [character[@"comics"][@"available"] intValue];
    NSString * comicBookCountText = [NSString stringWithFormat:@"%i", comicBookCount];
    cell.charComicCountLabel.text = comicBookCountText;
    
//    NSURLRequest * imageUrlRequest = [NSURLRequest requestWithURL:imageUrl];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        if (character[@"thumbnail"] != nil && character[@"thumbnail"] != [NSNull null]) {
            
            NSArray * imagePath = character[@"thumbnail"][@"path"];
            NSString * imageSize = @"/portrait_small.";
            NSString * extension = character[@"thumbnail"][@"extension"];
          
            NSString * completeImagePath = [NSString stringWithFormat:@"%@%@%@",imagePath,imageSize,extension];
            
//            NSLog(@"%@",completeImagePath);
            
            NSURL * imageUrl = [NSURL URLWithString:completeImagePath];
            
            NSData * imageData = [[NSData alloc] initWithContentsOfURL:imageUrl];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage * cellImage = [UIImage imageWithData:imageData];
                cell.charImage.image = cellImage;
                
            });
        
        }
        
    });
    
    cell.charComicCountLabel.layer.cornerRadius = 30;
    cell.charComicCountLabel.layer.masksToBounds = YES;
    return cell;
}

@end
