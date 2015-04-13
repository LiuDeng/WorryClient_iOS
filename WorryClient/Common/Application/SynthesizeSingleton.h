//
//  SynthesizeSingleton.h
//  WorryClient
//
//  Created by 蔡少武 on 15/4/11.
//  Copyright (c) 2015年 jiandan. All rights reserved.
//

//
// SynthesizeSingleton.h
// Copyright 2009 Matt Gallagher. All rights reserved.
//
// Modified by Oliver Jones and Byron Salau
//
// Permission is given to use this source code file without charge in any
// project, commercial or otherwise, entirely at your risk, with the condition
// that any redistribution (in part or whole) of source code must retain
// this copyright and permission notice. Attribution in compiled projects is
// appreciated but not required.

#import <Foundation/Foundation.h>

#ifndef WorryClient_SynthesizeSingleton_h
#define WorryClient_SynthesizeSingleton_h

//#if __has_feature(objc_arc)

//  TODO maybe is fault.
//#define DEFINE_SINGLETON_FOR_CLASS(UserService)
#define DEFINE_SINGLETON_FOR_CLASS(classname)\
+ (id) sharedInstance;

#define IMPLEMENT_SINGLETON_FOR_CLASS(classname)\
+ (id) sharedInstance {\
static dispatch_once_t pred = 0;\
__strong static id _sharedObject = nil;\
dispatch_once(&pred, ^{\
_sharedObject = [[self alloc] init];\
});\
return _sharedObject;\
}

#endif
