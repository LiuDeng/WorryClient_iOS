//
//  UpdateImage.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/25.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LocaleUtils.h"
#import "CLImageEditor.h"

typedef void(^UpdateImageDidSelectedBlock)(UIImage* image);

@interface UpdateImage : NSObject<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLImageEditorDelegate>

@property (nonatomic,strong) UIViewController *superViewController;
@property (nonatomic,assign) BOOL canTakePhoto;
@property (nonatomic,copy) UpdateImageDidSelectedBlock didSelectedBlock;
@property (nonatomic,retain) UIPopoverController *popoverController;
@property (nonatomic,assign) BOOL imageAllowsEditing;
@property (nonatomic,strong) UIImagePickerController *picker;

- (void)showSelectionWithTitle:(NSString *)actionSheetTitle
           superViewController:(UIViewController *)superViewController
            selectedImageBlock:(UpdateImageDidSelectedBlock)didSelectedBlock;


@end
