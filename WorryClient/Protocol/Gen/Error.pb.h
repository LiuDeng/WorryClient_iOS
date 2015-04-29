// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import <ProtocolBuffers/ProtocolBuffers.h>

// @@protoc_insertion_point(imports)

#ifndef __has_feature
  #define __has_feature(x) 0 // Compatibility with non-clang compilers.
#endif // __has_feature

#ifndef NS_RETURNS_NOT_RETAINED
  #if __has_feature(attribute_ns_returns_not_retained)
    #define NS_RETURNS_NOT_RETAINED __attribute__((ns_returns_not_retained))
  #else
    #define NS_RETURNS_NOT_RETAINED
  #endif
#endif

typedef NS_ENUM(SInt32, PBError) {
  PBErrorUnknown = 1000001,
  PBErrorServiceCatchException = 1000002,
  PBErrorNoService = 1000003,
  PBErrorUserLogInInfoEmpty = 2000001,
  PBErrorUserRegisterInfoEmpty = 2000002,
  PBErrorUserNotFound = 2000003,
  PBErrorPhoneEmpty = 2000004,
  PBErrorEmailEmpty = 2000005,
  PBErrorSnsIdEmpty = 2000006,
  PBErrorPasswordEmpty = 2000007,
  PBErrorSnsGetUserInfoEmpty = 2000008,
  PBErrorUserExist = 2000009,
  PBErrorFeedNotFound = 3000001,
  PBErrorFeedIdNull = 3000002,
};

BOOL PBErrorIsValidValue(PBError value);
NSString *NSStringFromPBError(PBError value);


@interface ErrorRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end


// @@protoc_insertion_point(global_scope)