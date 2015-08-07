//
//  UpdateImage.m
//  WorryClient
//
//  Created by 蔡少武 on 15/4/25.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import "UpdateImage.h"
#import "DeviceDetection.h"
#import "Utils.h"

#define kAlbumTitle             @"相册"
#define kTakePhotoTitle         @"拍照"
#define kCancelTitle            @"取消"

@implementation UpdateImage

- (void)showSelectionWithTitle:(NSString *)actionSheetTitle
           superViewController:(UIViewController *)superViewController
            selectedImageBlock:(UpdateImageDidSelectedBlock)didSelectedBlock

{
    self.didSelectedBlock = didSelectedBlock;
    self.superViewController = superViewController;
    NSArray *actionSheetTitleArray = @[kAlbumTitle,kTakePhotoTitle,kCancelTitle];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    for (NSString *title in actionSheetTitleArray) {
        [actionSheet addButtonWithTitle:title];
    }
    [actionSheet setCancelButtonIndex:[actionSheetTitleArray indexOfObject:kCancelTitle]];
    [actionSheet showInView:superViewController.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        actionSheet.hidden = YES;
    }else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString: kTakePhotoTitle]) {
        [self takePhoto];
    }else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:kAlbumTitle]){
        [self selectPhoto];
    }else{
        
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    __block UIImage *image = [info objectForKey:self.imageAllowsEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage];
    
    CLImageEditor *imageEditor = [[CLImageEditor alloc]initWithImage:image];
    imageEditor.delegate = self;
    [picker pushViewController:imageEditor animated:YES];
}

#pragma mark - Utils

- (void)selectPhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] &&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        self.picker = picker;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;  //  TODO
        picker.allowsEditing = self.imageAllowsEditing;
        picker.delegate = self;
        
        if (ISIOS8){
            
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
            
            picker.modalPresentationStyle = UIModalPresentationPopover;
            UIPopoverPresentationController* popVC = picker.popoverPresentationController;
            popVC.permittedArrowDirections = UIPopoverArrowDirectionUp;
            popVC.sourceView = _superViewController.view;
            float screenWidth = [UIScreen mainScreen].bounds.size.width;
            float width = 400;
            popVC.sourceRect = ISIPAD ? CGRectMake((screenWidth-width)/2, -140, width, width) : self.superViewController.view.bounds;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.superViewController presentViewController:picker
                                                   animated:NO
                                                 completion:nil];
                
            });
#endif
        }else{
            if (ISIPAD){
                UIPopoverController *controller = [[UIPopoverController alloc] initWithContentViewController:picker];
                self.popoverController = controller;
                CGRect popoverRect = CGRectMake((768-400)/2, -140, 400, 400);
                [self.popoverController presentPopoverFromRect:popoverRect
                                                    inView:_superViewController.view
                                  permittedArrowDirections:UIPopoverArrowDirectionUp
                                                  animated:YES];
            }else {
                [self.superViewController presentViewController:picker
                                                   animated:YES
                                                 completion:nil];
            }
        }
        
    }
    
}


- (void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = self.imageAllowsEditing;
        picker.delegate = self;
        
        if (ISIOS8){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_superViewController presentViewController:picker
                                                   animated:NO
                                                 completion:nil];
            });
            
        }else{
            [_superViewController presentViewController:picker
                                               animated:YES
                                             completion:nil];
        }
    }
    
}

#pragma mark - CLImageEditorDelegate

- (void)imageEditor:(CLImageEditor*)editor didFinishEdittingWithImage:(UIImage*)image
{
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:NO];
    }else{
        [self.picker dismissViewControllerAnimated:NO completion:nil];
    }
    EXECUTE_BLOCK(self.didSelectedBlock,image);
}

@end
