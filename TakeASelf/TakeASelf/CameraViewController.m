

#import "CameraViewController.h"
#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width 
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@end

@implementation CameraViewController
{
    UIImagePickerController * imagePickerController;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //iniating the imagePicker
    imagePickerController = [[UIImagePickerController alloc] init];
    //declaring the sourcetype as a camera
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //allowing the child to talk to the parent
    imagePickerController.delegate = self;
    //no controls on the camera are visible
    imagePickerController.showsCameraControls = NO;
    
    [self.view addSubview:imagePickerController.view];
    
    int buttonSize = 80;
//    int buttonLabelSize = 120;
    
    UIButton * takeButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - buttonSize) / 2, SCREEN_HEIGHT - 40 - buttonSize, buttonSize, buttonSize)];
    
//    UILabel * buttonLayer = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - buttonLabelSize) / 2, SCREEN_HEIGHT - 20 - buttonLabelSize, buttonLabelSize, buttonLabelSize)];

    takeButton.layer.cornerRadius = buttonSize / 2;
    takeButton.layer.masksToBounds = YES;
    takeButton.backgroundColor = [UIColor magentaColor];
    
//    buttonLayer.layer.cornerRadius = buttonLabelSize / 2;
//    buttonLayer.layer.masksToBounds = YES;
//    buttonLayer.backgroundColor = [UIColor whiteColor];
    
    [takeButton addTarget:imagePickerController action:@selector(takePicture)forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:buttonLayer];
    [self.view addSubview:takeButton];
    
    UIButton * toggleCamera = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH * 0.75) - 25, 0, 50, 50)];
    
    toggleCamera.center = CGPointMake(toggleCamera.center.x, takeButton.center.y);
    
    toggleCamera.layer.cornerRadius = 25;
    toggleCamera.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:toggleCamera];
    
    [toggleCamera addTarget:self action:@selector(toggleCamera) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)toggleCamera {
    
    if (imagePickerController.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        
    } else {
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    
}

//- (void)takePhoto {
//    [imagePickerController takePicture];
////    NSLog(@"Take Photo");
//    
//}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //you have to have editing key information key
    UIImage * original = info[UIImagePickerControllerOriginalImage];
    
    ViewController * imageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"imageVC"];
    
    imageVC.original = original;

    [self.navigationController pushViewController:imageVC animated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];

    
//    NSLog(@"%@", original);
    
//    self.imageView.image = original;
    
    //you have to dismiss the camera when implementing the imagePickerController
    
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
