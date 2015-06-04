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

@end

@implementation ViewController
{
    NSArray * filters;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.image = self.original;
    
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
//    

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        cell.imageVIew.image = [self filterImage:[self imageWithImage:self.original convertToSize:CGSizeMake(200, 200)] withName:filterName];
        
    });
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FilterCollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    NSString * filterName = filters[indexPath.item];
    
    UIImageView * rotatedImage = [[UIImageView alloc] initWithImage:self.original];
    
    self.imageView.image = [self filterImage:rotatedImage.image withName:filterName];
    
    self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
}

- (IBAction)filterSliderValue:(UISlider *)sender {
    
    float value = [sender value];
    
//    NSNumber * valueFloat = [NSNumber numberWithFloat:value];
//    
//    NSLog(valueFloat);
    
//    NSString * valueFloat = [NSString stringWithFormat:@"%f", value];
    
}

- (UIImage *)imageWithImage:(UIImage *)originalImage convertToSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    
    [originalImage drawInRect:CGRectMake(0, 0, 200, 200)];
    
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

- (void)adjustFilterValue {
    
    if contains(inputKeys, kCIInputIntensityKey) { [currentFilter.setValue([self.filterSliderValue.value forKey: kCIInputIntensityKey]) }
    
    
}

- (UIImage *)filterImage:(UIImage *)resizedImage withName:(NSString *)filterName {
    
    CIContext * context = [CIContext contextWithOptions:nil];               // 1
    
    CIImage * image = [CIImage imageWithCGImage:resizedImage.CGImage];               // 2
    
    CIFilter *filter = [CIFilter filterWithName:filterName];               // 3
    
    [filter setValue:image forKey:kCIInputImageKey];

//    NSNumber * sliderValue = [NSNumber numberWithFloat: self.filterSliderValue.value];
    
//    [filter setValue:@0.8f forKey:kCIInputIntensityKey];
    
    CIImage * result = [filter valueForKey:kCIOutputImageKey];             // 4
    
    CGRect extent = [result extent];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:extent];    // 5

    return [UIImage imageWithCGImage:cgImage];
    
}


@end
