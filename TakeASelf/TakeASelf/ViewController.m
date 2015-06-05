//Normal :
//- Tap a filter cell to change the main photo
//- Add a slider that changes the intensity of the current filter
//- fix orientation
//- make filtering run on a background thread
//
//Hard :
//- add a collection view that has all of the filter categories
//- tap a category cell to change filters

#import "ViewController.h"
#import "FilterCollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *filterCollectionView;

@property (nonatomic) NSString * currentFiler;
@property (nonatomic) CGFloat currentIntensity; 

@end

@implementation ViewController
{
    NSArray * filters;
    UIImage * resizedImage;
}

- (void)setCurrentIntensity:(CGFloat)currentIntensity {
    
    self.imageView.alpha = currentIntensity;
    
    _currentIntensity = currentIntensity;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.image = self.original;
    self.unFilteredImageView.image = self.original; 
    resizedImage = [self resizeImage:self.original withSize:CGSizeMake(200, 200)];

    self.currentIntensity = 1.0;
    
    filters = [CIFilter filterNamesInCategory:kCICategoryColorEffect];

    self.filterCollectionView.dataSource = self;
    self.filterCollectionView.delegate = self;
    
}

//this one has to be first for a view controller
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return filters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FilterCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"filterCell" forIndexPath:indexPath];
    
    NSString * filterName = filters[indexPath.item];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        UIImage * filteredImage = [self filterImage:resizedImage withName:filterName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.imageView.image = filteredImage;
            
        });
        
    });
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * filterName = filters[indexPath.item];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        UIImage * resetImage = [self resizeImage:self.original withSize:self.original.size];
        
        UIImage * filteredImage = [self filterImage:resetImage withName:filterName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            UIImageView * rotatedImage = [[UIImageView alloc] initWithImage:filteredImage];
            
            self.imageView.image = filteredImage;
            
//            self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        });
        
    });
    

    
}

- (IBAction)filterSliderValue:(UISlider *)sender {
    
    self.currentIntensity = sender.value;

//    NSNumber * valueFloat = [NSNumber numberWithFloat:value];
//    
//    NSLog(valueFloat);
    
//    NSString * valueFloat = [NSString stringWithFormat:@"%f", value];
    
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    
    CGRect scaleImageRect = CGRectMake(0, 0, size.width, size.height);
    
    if (size.height / size.width != image.size.height / image.size.width) {
        
        //fix ratio size
        
        if (image.size.height > image.size.width) {
            
            //portrait
            
            CGFloat ratio = size.width / image.size.width;
            CGFloat newHeight = ratio * image.size.height;
            CGFloat newY = (size.height - newHeight) / 2;
            scaleImageRect = CGRectMake(0, newY, size.width, newHeight);
            
            
        } else {
            
            //landscape
            
            CGFloat ratio = size.height / image.size.height;
            CGFloat newWidth = ratio * image.size.width;
            CGFloat newX = (size.width - newWidth) / 2;
            scaleImageRect = CGRectMake(newX, 0, newWidth, size.height);
        }
    
    }

    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

//- (void)adjustFilterValue {
//    
//    if contains(inputKeys, kCIInputIntensityKey) { [currentFilter.setValue([self.filterSliderValue.value forKey: kCIInputIntensityKey]) }
//    
//    
//}

- (UIImage *)filterImage:(UIImage *)originalImage withName:(NSString *)filterName {
    
    CIContext * context = [CIContext contextWithOptions:nil];               // 1
    
    CIImage * image = [CIImage imageWithCGImage:originalImage.CGImage];               // 2
    
    CIFilter *filter = [CIFilter filterWithName:filterName];               // 3
    
    [filter setValue:image forKey:kCIInputImageKey];

//    NSNumber * sliderValue = [NSNumber numberWithFloat: self.filterSliderValue.value];
    
//    [filter setValue:@0.8f forKey:kCIInputIntensityKey];
    
    CIImage * result = [filter valueForKey:kCIOutputImageKey];             // 4
    
    CGRect extent = [result extent];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:extent];    // 5

    return [UIImage imageWithCGImage:cgImage];
    
}


- (IBAction)goBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
