//
//  Camera.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "Camera.h"

@implementation Camera

+(BOOL)PresentMultiCamera:(id)target canEdit:(BOOL)canEdit{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) return NO;
    NSString *type1 = (NSString *)kUTTypeImage;
    NSString *type2 = (NSString *)kUTTypeMovie;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
        && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera] containsObject:type1])
    {
        imagePicker.mediaTypes = @[type1, type2];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
        {
            imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
        {
            imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
    }
    else return NO;
    imagePicker.allowsEditing = canEdit;
    imagePicker.showsCameraControls = YES;
    imagePicker.delegate = target;
    [target presentViewController:imagePicker animated:YES completion:nil];
    return YES;
}

+(BOOL)PresentPhotoLibrary:(id)target canEdit:(BOOL)canEdit{
    
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO
         && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) return NO;
    NSString *type = (NSString *)kUTTypeImage;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]
        && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary] containsObject:type])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[type];
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]
             && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum] containsObject:type])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.mediaTypes = @[type];
    }
    else return NO;
    imagePicker.allowsEditing = canEdit;
    imagePicker.delegate = target;
    [target presentViewController:imagePicker animated:YES completion:nil];
    return YES;
}
@end
