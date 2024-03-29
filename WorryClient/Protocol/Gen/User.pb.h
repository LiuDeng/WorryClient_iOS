// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import <ProtocolBuffers/ProtocolBuffers.h>

#import "Common.pb.h"
// @@protoc_insertion_point(imports)

@class PBDevice;
@class PBDeviceBuilder;
@class PBUser;
@class PBUserBuilder;
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

typedef NS_ENUM(SInt32, PBSignUpAndLogInType) {
  PBSignUpAndLogInTypePhone = 1,
  PBSignUpAndLogInTypeEmail = 2,
  PBSignUpAndLogInTypeQq = 3,
  PBSignUpAndLogInTypeWeixin = 4,
  PBSignUpAndLogInTypeSina = 5,
};

BOOL PBSignUpAndLogInTypeIsValidValue(PBSignUpAndLogInType value);
NSString *NSStringFromPBSignUpAndLogInType(PBSignUpAndLogInType value);


@interface UserRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface PBUser : PBGeneratedMessage<GeneratedMessageProtocol> {
@private
  BOOL hasGender_:1;
  BOOL hasPhoneVerified_:1;
  BOOL hasEmailVerified_:1;
  BOOL hasCreatedAt_:1;
  BOOL hasUpatedAt_:1;
  BOOL hasCredit_:1;
  BOOL hasLevel_:1;
  BOOL hasThanksNum_:1;
  BOOL hasAgreeNum_:1;
  BOOL hasUserId_:1;
  BOOL hasPassword_:1;
  BOOL hasNick_:1;
  BOOL hasAvatar_:1;
  BOOL hasBgImage_:1;
  BOOL hasSignature_:1;
  BOOL hasLocation_:1;
  BOOL hasPhone_:1;
  BOOL hasEmail_:1;
  BOOL hasWeixinId_:1;
  BOOL hasQqId_:1;
  BOOL hasSinaId_:1;
  BOOL hasCurrentDevice_:1;
  BOOL gender_:1;
  BOOL phoneVerified_:1;
  BOOL emailVerified_:1;
  SInt32 createdAt;
  SInt32 upatedAt;
  SInt32 credit;
  SInt32 level;
  SInt32 thanksNum;
  SInt32 agreeNum;
  NSString* userId;
  NSString* password;
  NSString* nick;
  NSString* avatar;
  NSString* bgImage;
  NSString* signature;
  NSString* location;
  NSString* phone;
  NSString* email;
  NSString* weixinId;
  NSString* qqId;
  NSString* sinaId;
  PBDevice* currentDevice;
  NSMutableArray * favoriteFeedIdArray;
  NSMutableArray * answerIdArray;
  NSMutableArray * receivedBlessingIdArray;
  NSMutableArray * sentBlessingIdArray;
  NSMutableArray * topicIdArray;
  NSMutableArray * followingsIdArray;
  NSMutableArray * followersIdArray;
  NSMutableArray * devicesArray;
}
- (BOOL) hasUserId;
- (BOOL) hasPassword;
- (BOOL) hasNick;
- (BOOL) hasAvatar;
- (BOOL) hasGender;
- (BOOL) hasBgImage;
- (BOOL) hasSignature;
- (BOOL) hasLocation;
- (BOOL) hasPhone;
- (BOOL) hasEmail;
- (BOOL) hasCreatedAt;
- (BOOL) hasUpatedAt;
- (BOOL) hasPhoneVerified;
- (BOOL) hasEmailVerified;
- (BOOL) hasCredit;
- (BOOL) hasLevel;
- (BOOL) hasThanksNum;
- (BOOL) hasAgreeNum;
- (BOOL) hasWeixinId;
- (BOOL) hasQqId;
- (BOOL) hasSinaId;
- (BOOL) hasCurrentDevice;
@property (readonly, strong) NSString* userId;
@property (readonly, strong) NSString* password;
@property (readonly, strong) NSString* nick;
@property (readonly, strong) NSString* avatar;
- (BOOL) gender;
@property (readonly, strong) NSString* bgImage;
@property (readonly, strong) NSString* signature;
@property (readonly, strong) NSString* location;
@property (readonly, strong) NSString* phone;
@property (readonly, strong) NSString* email;
@property (readonly) SInt32 createdAt;
@property (readonly) SInt32 upatedAt;
- (BOOL) phoneVerified;
- (BOOL) emailVerified;
@property (readonly) SInt32 credit;
@property (readonly) SInt32 level;
@property (readonly) SInt32 thanksNum;
@property (readonly) SInt32 agreeNum;
@property (readonly, strong) NSString* weixinId;
@property (readonly, strong) NSString* qqId;
@property (readonly, strong) NSString* sinaId;
@property (readonly, strong) NSArray * favoriteFeedId;
@property (readonly, strong) NSArray * answerId;
@property (readonly, strong) NSArray * receivedBlessingId;
@property (readonly, strong) NSArray * sentBlessingId;
@property (readonly, strong) NSArray * topicId;
@property (readonly, strong) NSArray * followingsId;
@property (readonly, strong) NSArray * followersId;
@property (readonly, strong) PBDevice* currentDevice;
@property (readonly, strong) NSArray * devices;
- (NSString*)favoriteFeedIdAtIndex:(NSUInteger)index;
- (NSString*)answerIdAtIndex:(NSUInteger)index;
- (NSString*)receivedBlessingIdAtIndex:(NSUInteger)index;
- (NSString*)sentBlessingIdAtIndex:(NSUInteger)index;
- (NSString*)topicIdAtIndex:(NSUInteger)index;
- (NSString*)followingsIdAtIndex:(NSUInteger)index;
- (NSString*)followersIdAtIndex:(NSUInteger)index;
- (PBDevice*)devicesAtIndex:(NSUInteger)index;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBUserBuilder*) builder;
+ (PBUserBuilder*) builder;
+ (PBUserBuilder*) builderWithPrototype:(PBUser*) prototype;
- (PBUserBuilder*) toBuilder;

+ (PBUser*) parseFromData:(NSData*) data;
+ (PBUser*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBUser*) parseFromInputStream:(NSInputStream*) input;
+ (PBUser*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBUser*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBUser*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBUserBuilder : PBGeneratedMessageBuilder {
@private
  PBUser* resultPbuser;
}

- (PBUser*) defaultInstance;

- (PBUserBuilder*) clear;
- (PBUserBuilder*) clone;

- (PBUser*) build;
- (PBUser*) buildPartial;

- (PBUserBuilder*) mergeFrom:(PBUser*) other;
- (PBUserBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBUserBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasUserId;
- (NSString*) userId;
- (PBUserBuilder*) setUserId:(NSString*) value;
- (PBUserBuilder*) clearUserId;

- (BOOL) hasPassword;
- (NSString*) password;
- (PBUserBuilder*) setPassword:(NSString*) value;
- (PBUserBuilder*) clearPassword;

- (BOOL) hasNick;
- (NSString*) nick;
- (PBUserBuilder*) setNick:(NSString*) value;
- (PBUserBuilder*) clearNick;

- (BOOL) hasAvatar;
- (NSString*) avatar;
- (PBUserBuilder*) setAvatar:(NSString*) value;
- (PBUserBuilder*) clearAvatar;

- (BOOL) hasGender;
- (BOOL) gender;
- (PBUserBuilder*) setGender:(BOOL) value;
- (PBUserBuilder*) clearGender;

- (BOOL) hasBgImage;
- (NSString*) bgImage;
- (PBUserBuilder*) setBgImage:(NSString*) value;
- (PBUserBuilder*) clearBgImage;

- (BOOL) hasSignature;
- (NSString*) signature;
- (PBUserBuilder*) setSignature:(NSString*) value;
- (PBUserBuilder*) clearSignature;

- (BOOL) hasLocation;
- (NSString*) location;
- (PBUserBuilder*) setLocation:(NSString*) value;
- (PBUserBuilder*) clearLocation;

- (BOOL) hasPhone;
- (NSString*) phone;
- (PBUserBuilder*) setPhone:(NSString*) value;
- (PBUserBuilder*) clearPhone;

- (BOOL) hasEmail;
- (NSString*) email;
- (PBUserBuilder*) setEmail:(NSString*) value;
- (PBUserBuilder*) clearEmail;

- (BOOL) hasCreatedAt;
- (SInt32) createdAt;
- (PBUserBuilder*) setCreatedAt:(SInt32) value;
- (PBUserBuilder*) clearCreatedAt;

- (BOOL) hasUpatedAt;
- (SInt32) upatedAt;
- (PBUserBuilder*) setUpatedAt:(SInt32) value;
- (PBUserBuilder*) clearUpatedAt;

- (BOOL) hasPhoneVerified;
- (BOOL) phoneVerified;
- (PBUserBuilder*) setPhoneVerified:(BOOL) value;
- (PBUserBuilder*) clearPhoneVerified;

- (BOOL) hasEmailVerified;
- (BOOL) emailVerified;
- (PBUserBuilder*) setEmailVerified:(BOOL) value;
- (PBUserBuilder*) clearEmailVerified;

- (BOOL) hasCredit;
- (SInt32) credit;
- (PBUserBuilder*) setCredit:(SInt32) value;
- (PBUserBuilder*) clearCredit;

- (BOOL) hasLevel;
- (SInt32) level;
- (PBUserBuilder*) setLevel:(SInt32) value;
- (PBUserBuilder*) clearLevel;

- (BOOL) hasThanksNum;
- (SInt32) thanksNum;
- (PBUserBuilder*) setThanksNum:(SInt32) value;
- (PBUserBuilder*) clearThanksNum;

- (BOOL) hasAgreeNum;
- (SInt32) agreeNum;
- (PBUserBuilder*) setAgreeNum:(SInt32) value;
- (PBUserBuilder*) clearAgreeNum;

- (BOOL) hasWeixinId;
- (NSString*) weixinId;
- (PBUserBuilder*) setWeixinId:(NSString*) value;
- (PBUserBuilder*) clearWeixinId;

- (BOOL) hasQqId;
- (NSString*) qqId;
- (PBUserBuilder*) setQqId:(NSString*) value;
- (PBUserBuilder*) clearQqId;

- (BOOL) hasSinaId;
- (NSString*) sinaId;
- (PBUserBuilder*) setSinaId:(NSString*) value;
- (PBUserBuilder*) clearSinaId;

- (NSMutableArray *)favoriteFeedId;
- (NSString*)favoriteFeedIdAtIndex:(NSUInteger)index;
- (PBUserBuilder *)addFavoriteFeedId:(NSString*)value;
- (PBUserBuilder *)setFavoriteFeedIdArray:(NSArray *)array;
- (PBUserBuilder *)clearFavoriteFeedId;

- (NSMutableArray *)answerId;
- (NSString*)answerIdAtIndex:(NSUInteger)index;
- (PBUserBuilder *)addAnswerId:(NSString*)value;
- (PBUserBuilder *)setAnswerIdArray:(NSArray *)array;
- (PBUserBuilder *)clearAnswerId;

- (NSMutableArray *)receivedBlessingId;
- (NSString*)receivedBlessingIdAtIndex:(NSUInteger)index;
- (PBUserBuilder *)addReceivedBlessingId:(NSString*)value;
- (PBUserBuilder *)setReceivedBlessingIdArray:(NSArray *)array;
- (PBUserBuilder *)clearReceivedBlessingId;

- (NSMutableArray *)sentBlessingId;
- (NSString*)sentBlessingIdAtIndex:(NSUInteger)index;
- (PBUserBuilder *)addSentBlessingId:(NSString*)value;
- (PBUserBuilder *)setSentBlessingIdArray:(NSArray *)array;
- (PBUserBuilder *)clearSentBlessingId;

- (NSMutableArray *)topicId;
- (NSString*)topicIdAtIndex:(NSUInteger)index;
- (PBUserBuilder *)addTopicId:(NSString*)value;
- (PBUserBuilder *)setTopicIdArray:(NSArray *)array;
- (PBUserBuilder *)clearTopicId;

- (NSMutableArray *)followingsId;
- (NSString*)followingsIdAtIndex:(NSUInteger)index;
- (PBUserBuilder *)addFollowingsId:(NSString*)value;
- (PBUserBuilder *)setFollowingsIdArray:(NSArray *)array;
- (PBUserBuilder *)clearFollowingsId;

- (NSMutableArray *)followersId;
- (NSString*)followersIdAtIndex:(NSUInteger)index;
- (PBUserBuilder *)addFollowersId:(NSString*)value;
- (PBUserBuilder *)setFollowersIdArray:(NSArray *)array;
- (PBUserBuilder *)clearFollowersId;

- (BOOL) hasCurrentDevice;
- (PBDevice*) currentDevice;
- (PBUserBuilder*) setCurrentDevice:(PBDevice*) value;
- (PBUserBuilder*) setCurrentDeviceBuilder:(PBDeviceBuilder*) builderForValue;
- (PBUserBuilder*) mergeCurrentDevice:(PBDevice*) value;
- (PBUserBuilder*) clearCurrentDevice;

- (NSMutableArray *)devices;
- (PBDevice*)devicesAtIndex:(NSUInteger)index;
- (PBUserBuilder *)addDevices:(PBDevice*)value;
- (PBUserBuilder *)setDevicesArray:(NSArray *)array;
- (PBUserBuilder *)clearDevices;
@end


// @@protoc_insertion_point(global_scope)
