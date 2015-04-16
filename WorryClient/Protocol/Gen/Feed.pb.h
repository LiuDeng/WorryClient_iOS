// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import <ProtocolBuffers/ProtocolBuffers.h>

#import "User.pb.h"
// @@protoc_insertion_point(imports)

@class PBFeed;
@class PBFeedBuilder;
@class PBTopic;
@class PBTopicBuilder;
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

typedef NS_ENUM(SInt32, PBFeedType) {
  PBFeedTypeFeedTypeWorry = 0,
  PBFeedTypeFeedTypeStory = 1,
};

BOOL PBFeedTypeIsValidValue(PBFeedType value);
NSString *NSStringFromPBFeedType(PBFeedType value);


@interface FeedRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface PBTopic : PBGeneratedMessage<GeneratedMessageProtocol> {
@private
  BOOL hasTopicId_:1;
  BOOL hasTitle_:1;
  NSString* topicId;
  NSString* title;
}
- (BOOL) hasTopicId;
- (BOOL) hasTitle;
@property (readonly, strong) NSString* topicId;
@property (readonly, strong) NSString* title;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBTopicBuilder*) builder;
+ (PBTopicBuilder*) builder;
+ (PBTopicBuilder*) builderWithPrototype:(PBTopic*) prototype;
- (PBTopicBuilder*) toBuilder;

+ (PBTopic*) parseFromData:(NSData*) data;
+ (PBTopic*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBTopic*) parseFromInputStream:(NSInputStream*) input;
+ (PBTopic*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBTopicBuilder : PBGeneratedMessageBuilder {
@private
  PBTopic* resultPbtopic;
}

- (PBTopic*) defaultInstance;

- (PBTopicBuilder*) clear;
- (PBTopicBuilder*) clone;

- (PBTopic*) build;
- (PBTopic*) buildPartial;

- (PBTopicBuilder*) mergeFrom:(PBTopic*) other;
- (PBTopicBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBTopicBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasTopicId;
- (NSString*) topicId;
- (PBTopicBuilder*) setTopicId:(NSString*) value;
- (PBTopicBuilder*) clearTopicId;

- (BOOL) hasTitle;
- (NSString*) title;
- (PBTopicBuilder*) setTitle:(NSString*) value;
- (PBTopicBuilder*) clearTitle;
@end

@interface PBFeed : PBGeneratedMessage<GeneratedMessageProtocol> {
@private
  BOOL hasIsAnonymous_:1;
  BOOL hasDate_:1;
  BOOL hasFeedId_:1;
  BOOL hasTitle_:1;
  BOOL hasText_:1;
  BOOL hasCreateUser_:1;
  BOOL hasType_:1;
  BOOL isAnonymous_:1;
  SInt32 date;
  NSString* feedId;
  NSString* title;
  NSString* text;
  PBUser* createUser;
  PBFeedType type;
  NSMutableArray * commentUserArray;
  NSMutableArray * blessingUserArray;
  NSMutableArray * topicArray;
}
- (BOOL) hasType;
- (BOOL) hasFeedId;
- (BOOL) hasCreateUser;
- (BOOL) hasIsAnonymous;
- (BOOL) hasTitle;
- (BOOL) hasText;
- (BOOL) hasDate;
@property (readonly) PBFeedType type;
@property (readonly, strong) NSString* feedId;
@property (readonly, strong) PBUser* createUser;
- (BOOL) isAnonymous;
@property (readonly, strong) NSArray * commentUser;
@property (readonly, strong) NSArray * blessingUser;
@property (readonly, strong) NSString* title;
@property (readonly, strong) NSString* text;
@property (readonly) SInt32 date;
@property (readonly, strong) NSArray * topic;
- (PBUser*)commentUserAtIndex:(NSUInteger)index;
- (PBUser*)blessingUserAtIndex:(NSUInteger)index;
- (PBTopic*)topicAtIndex:(NSUInteger)index;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBFeedBuilder*) builder;
+ (PBFeedBuilder*) builder;
+ (PBFeedBuilder*) builderWithPrototype:(PBFeed*) prototype;
- (PBFeedBuilder*) toBuilder;

+ (PBFeed*) parseFromData:(NSData*) data;
+ (PBFeed*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBFeed*) parseFromInputStream:(NSInputStream*) input;
+ (PBFeed*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBFeed*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBFeed*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBFeedBuilder : PBGeneratedMessageBuilder {
@private
  PBFeed* resultPbfeed;
}

- (PBFeed*) defaultInstance;

- (PBFeedBuilder*) clear;
- (PBFeedBuilder*) clone;

- (PBFeed*) build;
- (PBFeed*) buildPartial;

- (PBFeedBuilder*) mergeFrom:(PBFeed*) other;
- (PBFeedBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBFeedBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasType;
- (PBFeedType) type;
- (PBFeedBuilder*) setType:(PBFeedType) value;
- (PBFeedBuilder*) clearType;

- (BOOL) hasFeedId;
- (NSString*) feedId;
- (PBFeedBuilder*) setFeedId:(NSString*) value;
- (PBFeedBuilder*) clearFeedId;

- (BOOL) hasCreateUser;
- (PBUser*) createUser;
- (PBFeedBuilder*) setCreateUser:(PBUser*) value;
- (PBFeedBuilder*) setCreateUserBuilder:(PBUserBuilder*) builderForValue;
- (PBFeedBuilder*) mergeCreateUser:(PBUser*) value;
- (PBFeedBuilder*) clearCreateUser;

- (BOOL) hasIsAnonymous;
- (BOOL) isAnonymous;
- (PBFeedBuilder*) setIsAnonymous:(BOOL) value;
- (PBFeedBuilder*) clearIsAnonymous;

- (NSMutableArray *)commentUser;
- (PBUser*)commentUserAtIndex:(NSUInteger)index;
- (PBFeedBuilder *)addCommentUser:(PBUser*)value;
- (PBFeedBuilder *)setCommentUserArray:(NSArray *)array;
- (PBFeedBuilder *)clearCommentUser;

- (NSMutableArray *)blessingUser;
- (PBUser*)blessingUserAtIndex:(NSUInteger)index;
- (PBFeedBuilder *)addBlessingUser:(PBUser*)value;
- (PBFeedBuilder *)setBlessingUserArray:(NSArray *)array;
- (PBFeedBuilder *)clearBlessingUser;

- (BOOL) hasTitle;
- (NSString*) title;
- (PBFeedBuilder*) setTitle:(NSString*) value;
- (PBFeedBuilder*) clearTitle;

- (BOOL) hasText;
- (NSString*) text;
- (PBFeedBuilder*) setText:(NSString*) value;
- (PBFeedBuilder*) clearText;

- (BOOL) hasDate;
- (SInt32) date;
- (PBFeedBuilder*) setDate:(SInt32) value;
- (PBFeedBuilder*) clearDate;

- (NSMutableArray *)topic;
- (PBTopic*)topicAtIndex:(NSUInteger)index;
- (PBFeedBuilder *)addTopic:(PBTopic*)value;
- (PBFeedBuilder *)setTopicArray:(NSArray *)array;
- (PBFeedBuilder *)clearTopic;
@end


// @@protoc_insertion_point(global_scope)
