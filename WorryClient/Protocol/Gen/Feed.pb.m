// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "Feed.pb.h"
// @@protoc_insertion_point(imports)

@implementation FeedRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [FeedRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    [UserRoot registerAllExtensions:registry];
    extensionRegistry = registry;
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

BOOL PBFeedTypeIsValidValue(PBFeedType value) {
  switch (value) {
    case PBFeedTypeFeedTypeWorry:
    case PBFeedTypeFeedTypeStory:
      return YES;
    default:
      return NO;
  }
}
NSString *NSStringFromPBFeedType(PBFeedType value) {
  switch (value) {
    case PBFeedTypeFeedTypeWorry:
      return @"PBFeedTypeFeedTypeWorry";
    case PBFeedTypeFeedTypeStory:
      return @"PBFeedTypeFeedTypeStory";
    default:
      return nil;
  }
}

@interface PBTopic ()
@property (strong) NSString* topicId;
@property (strong) NSString* title;
@end

@implementation PBTopic

- (BOOL) hasTopicId {
  return !!hasTopicId_;
}
- (void) setHasTopicId:(BOOL) _value_ {
  hasTopicId_ = !!_value_;
}
@synthesize topicId;
- (BOOL) hasTitle {
  return !!hasTitle_;
}
- (void) setHasTitle:(BOOL) _value_ {
  hasTitle_ = !!_value_;
}
@synthesize title;
- (instancetype) init {
  if ((self = [super init])) {
    self.topicId = @"";
    self.title = @"";
  }
  return self;
}
static PBTopic* defaultPBTopicInstance = nil;
+ (void) initialize {
  if (self == [PBTopic class]) {
    defaultPBTopicInstance = [[PBTopic alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultPBTopicInstance;
}
- (instancetype) defaultInstance {
  return defaultPBTopicInstance;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasTopicId) {
    [output writeString:1 value:self.topicId];
  }
  if (self.hasTitle) {
    [output writeString:2 value:self.title];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (SInt32) serializedSize {
  __block SInt32 size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasTopicId) {
    size_ += computeStringSize(1, self.topicId);
  }
  if (self.hasTitle) {
    size_ += computeStringSize(2, self.title);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (PBTopic*) parseFromData:(NSData*) data {
  return (PBTopic*)[[[PBTopic builder] mergeFromData:data] build];
}
+ (PBTopic*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBTopic*)[[[PBTopic builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (PBTopic*) parseFromInputStream:(NSInputStream*) input {
  return (PBTopic*)[[[PBTopic builder] mergeFromInputStream:input] build];
}
+ (PBTopic*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBTopic*)[[[PBTopic builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PBTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (PBTopic*)[[[PBTopic builder] mergeFromCodedInputStream:input] build];
}
+ (PBTopic*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBTopic*)[[[PBTopic builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PBTopicBuilder*) builder {
  return [[PBTopicBuilder alloc] init];
}
+ (PBTopicBuilder*) builderWithPrototype:(PBTopic*) prototype {
  return [[PBTopic builder] mergeFrom:prototype];
}
- (PBTopicBuilder*) builder {
  return [PBTopic builder];
}
- (PBTopicBuilder*) toBuilder {
  return [PBTopic builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasTopicId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"topicId", self.topicId];
  }
  if (self.hasTitle) {
    [output appendFormat:@"%@%@: %@\n", indent, @"title", self.title];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[PBTopic class]]) {
    return NO;
  }
  PBTopic *otherMessage = other;
  return
      self.hasTopicId == otherMessage.hasTopicId &&
      (!self.hasTopicId || [self.topicId isEqual:otherMessage.topicId]) &&
      self.hasTitle == otherMessage.hasTitle &&
      (!self.hasTitle || [self.title isEqual:otherMessage.title]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  if (self.hasTopicId) {
    hashCode = hashCode * 31 + [self.topicId hash];
  }
  if (self.hasTitle) {
    hashCode = hashCode * 31 + [self.title hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface PBTopicBuilder()
@property (strong) PBTopic* resultPbtopic;
@end

@implementation PBTopicBuilder
@synthesize resultPbtopic;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultPbtopic = [[PBTopic alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultPbtopic;
}
- (PBTopicBuilder*) clear {
  self.resultPbtopic = [[PBTopic alloc] init];
  return self;
}
- (PBTopicBuilder*) clone {
  return [PBTopic builderWithPrototype:resultPbtopic];
}
- (PBTopic*) defaultInstance {
  return [PBTopic defaultInstance];
}
- (PBTopic*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (PBTopic*) buildPartial {
  PBTopic* returnMe = resultPbtopic;
  self.resultPbtopic = nil;
  return returnMe;
}
- (PBTopicBuilder*) mergeFrom:(PBTopic*) other {
  if (other == [PBTopic defaultInstance]) {
    return self;
  }
  if (other.hasTopicId) {
    [self setTopicId:other.topicId];
  }
  if (other.hasTitle) {
    [self setTitle:other.title];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (PBTopicBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (PBTopicBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSetBuilder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    SInt32 tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 10: {
        [self setTopicId:[input readString]];
        break;
      }
      case 18: {
        [self setTitle:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasTopicId {
  return resultPbtopic.hasTopicId;
}
- (NSString*) topicId {
  return resultPbtopic.topicId;
}
- (PBTopicBuilder*) setTopicId:(NSString*) value {
  resultPbtopic.hasTopicId = YES;
  resultPbtopic.topicId = value;
  return self;
}
- (PBTopicBuilder*) clearTopicId {
  resultPbtopic.hasTopicId = NO;
  resultPbtopic.topicId = @"";
  return self;
}
- (BOOL) hasTitle {
  return resultPbtopic.hasTitle;
}
- (NSString*) title {
  return resultPbtopic.title;
}
- (PBTopicBuilder*) setTitle:(NSString*) value {
  resultPbtopic.hasTitle = YES;
  resultPbtopic.title = value;
  return self;
}
- (PBTopicBuilder*) clearTitle {
  resultPbtopic.hasTitle = NO;
  resultPbtopic.title = @"";
  return self;
}
@end

@interface PBComment ()
@property (strong) NSString* commentId;
@property (strong) PBUser* createUser;
@property (strong) NSString* text;
@end

@implementation PBComment

- (BOOL) hasCommentId {
  return !!hasCommentId_;
}
- (void) setHasCommentId:(BOOL) _value_ {
  hasCommentId_ = !!_value_;
}
@synthesize commentId;
- (BOOL) hasCreateUser {
  return !!hasCreateUser_;
}
- (void) setHasCreateUser:(BOOL) _value_ {
  hasCreateUser_ = !!_value_;
}
@synthesize createUser;
- (BOOL) hasText {
  return !!hasText_;
}
- (void) setHasText:(BOOL) _value_ {
  hasText_ = !!_value_;
}
@synthesize text;
- (instancetype) init {
  if ((self = [super init])) {
    self.commentId = @"";
    self.createUser = [PBUser defaultInstance];
    self.text = @"";
  }
  return self;
}
static PBComment* defaultPBCommentInstance = nil;
+ (void) initialize {
  if (self == [PBComment class]) {
    defaultPBCommentInstance = [[PBComment alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultPBCommentInstance;
}
- (instancetype) defaultInstance {
  return defaultPBCommentInstance;
}
- (BOOL) isInitialized {
  if (!self.hasCommentId) {
    return NO;
  }
  if (self.hasCreateUser) {
    if (!self.createUser.isInitialized) {
      return NO;
    }
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasCommentId) {
    [output writeString:1 value:self.commentId];
  }
  if (self.hasCreateUser) {
    [output writeMessage:2 value:self.createUser];
  }
  if (self.hasText) {
    [output writeString:5 value:self.text];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (SInt32) serializedSize {
  __block SInt32 size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasCommentId) {
    size_ += computeStringSize(1, self.commentId);
  }
  if (self.hasCreateUser) {
    size_ += computeMessageSize(2, self.createUser);
  }
  if (self.hasText) {
    size_ += computeStringSize(5, self.text);
  }
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (PBComment*) parseFromData:(NSData*) data {
  return (PBComment*)[[[PBComment builder] mergeFromData:data] build];
}
+ (PBComment*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBComment*)[[[PBComment builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (PBComment*) parseFromInputStream:(NSInputStream*) input {
  return (PBComment*)[[[PBComment builder] mergeFromInputStream:input] build];
}
+ (PBComment*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBComment*)[[[PBComment builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PBComment*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (PBComment*)[[[PBComment builder] mergeFromCodedInputStream:input] build];
}
+ (PBComment*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBComment*)[[[PBComment builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PBCommentBuilder*) builder {
  return [[PBCommentBuilder alloc] init];
}
+ (PBCommentBuilder*) builderWithPrototype:(PBComment*) prototype {
  return [[PBComment builder] mergeFrom:prototype];
}
- (PBCommentBuilder*) builder {
  return [PBComment builder];
}
- (PBCommentBuilder*) toBuilder {
  return [PBComment builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasCommentId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"commentId", self.commentId];
  }
  if (self.hasCreateUser) {
    [output appendFormat:@"%@%@ {\n", indent, @"createUser"];
    [self.createUser writeDescriptionTo:output
                         withIndent:[NSString stringWithFormat:@"%@  ", indent]];
    [output appendFormat:@"%@}\n", indent];
  }
  if (self.hasText) {
    [output appendFormat:@"%@%@: %@\n", indent, @"text", self.text];
  }
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[PBComment class]]) {
    return NO;
  }
  PBComment *otherMessage = other;
  return
      self.hasCommentId == otherMessage.hasCommentId &&
      (!self.hasCommentId || [self.commentId isEqual:otherMessage.commentId]) &&
      self.hasCreateUser == otherMessage.hasCreateUser &&
      (!self.hasCreateUser || [self.createUser isEqual:otherMessage.createUser]) &&
      self.hasText == otherMessage.hasText &&
      (!self.hasText || [self.text isEqual:otherMessage.text]) &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  if (self.hasCommentId) {
    hashCode = hashCode * 31 + [self.commentId hash];
  }
  if (self.hasCreateUser) {
    hashCode = hashCode * 31 + [self.createUser hash];
  }
  if (self.hasText) {
    hashCode = hashCode * 31 + [self.text hash];
  }
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface PBCommentBuilder()
@property (strong) PBComment* resultPbcomment;
@end

@implementation PBCommentBuilder
@synthesize resultPbcomment;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultPbcomment = [[PBComment alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultPbcomment;
}
- (PBCommentBuilder*) clear {
  self.resultPbcomment = [[PBComment alloc] init];
  return self;
}
- (PBCommentBuilder*) clone {
  return [PBComment builderWithPrototype:resultPbcomment];
}
- (PBComment*) defaultInstance {
  return [PBComment defaultInstance];
}
- (PBComment*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (PBComment*) buildPartial {
  PBComment* returnMe = resultPbcomment;
  self.resultPbcomment = nil;
  return returnMe;
}
- (PBCommentBuilder*) mergeFrom:(PBComment*) other {
  if (other == [PBComment defaultInstance]) {
    return self;
  }
  if (other.hasCommentId) {
    [self setCommentId:other.commentId];
  }
  if (other.hasCreateUser) {
    [self mergeCreateUser:other.createUser];
  }
  if (other.hasText) {
    [self setText:other.text];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (PBCommentBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (PBCommentBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSetBuilder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    SInt32 tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 10: {
        [self setCommentId:[input readString]];
        break;
      }
      case 18: {
        PBUserBuilder* subBuilder = [PBUser builder];
        if (self.hasCreateUser) {
          [subBuilder mergeFrom:self.createUser];
        }
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self setCreateUser:[subBuilder buildPartial]];
        break;
      }
      case 42: {
        [self setText:[input readString]];
        break;
      }
    }
  }
}
- (BOOL) hasCommentId {
  return resultPbcomment.hasCommentId;
}
- (NSString*) commentId {
  return resultPbcomment.commentId;
}
- (PBCommentBuilder*) setCommentId:(NSString*) value {
  resultPbcomment.hasCommentId = YES;
  resultPbcomment.commentId = value;
  return self;
}
- (PBCommentBuilder*) clearCommentId {
  resultPbcomment.hasCommentId = NO;
  resultPbcomment.commentId = @"";
  return self;
}
- (BOOL) hasCreateUser {
  return resultPbcomment.hasCreateUser;
}
- (PBUser*) createUser {
  return resultPbcomment.createUser;
}
- (PBCommentBuilder*) setCreateUser:(PBUser*) value {
  resultPbcomment.hasCreateUser = YES;
  resultPbcomment.createUser = value;
  return self;
}
- (PBCommentBuilder*) setCreateUserBuilder:(PBUserBuilder*) builderForValue {
  return [self setCreateUser:[builderForValue build]];
}
- (PBCommentBuilder*) mergeCreateUser:(PBUser*) value {
  if (resultPbcomment.hasCreateUser &&
      resultPbcomment.createUser != [PBUser defaultInstance]) {
    resultPbcomment.createUser =
      [[[PBUser builderWithPrototype:resultPbcomment.createUser] mergeFrom:value] buildPartial];
  } else {
    resultPbcomment.createUser = value;
  }
  resultPbcomment.hasCreateUser = YES;
  return self;
}
- (PBCommentBuilder*) clearCreateUser {
  resultPbcomment.hasCreateUser = NO;
  resultPbcomment.createUser = [PBUser defaultInstance];
  return self;
}
- (BOOL) hasText {
  return resultPbcomment.hasText;
}
- (NSString*) text {
  return resultPbcomment.text;
}
- (PBCommentBuilder*) setText:(NSString*) value {
  resultPbcomment.hasText = YES;
  resultPbcomment.text = value;
  return self;
}
- (PBCommentBuilder*) clearText {
  resultPbcomment.hasText = NO;
  resultPbcomment.text = @"";
  return self;
}
@end

@interface PBFeed ()
@property PBFeedType type;
@property (strong) NSString* feedId;
@property (strong) PBUser* createUser;
@property BOOL isAnonymous;
@property (strong) NSMutableArray * blessingUserArray;
@property (strong) NSString* title;
@property (strong) NSString* text;
@property SInt32 date;
@property (strong) NSMutableArray * topicArray;
@property (strong) NSMutableArray * commentArray;
@end

@implementation PBFeed

- (BOOL) hasType {
  return !!hasType_;
}
- (void) setHasType:(BOOL) _value_ {
  hasType_ = !!_value_;
}
@synthesize type;
- (BOOL) hasFeedId {
  return !!hasFeedId_;
}
- (void) setHasFeedId:(BOOL) _value_ {
  hasFeedId_ = !!_value_;
}
@synthesize feedId;
- (BOOL) hasCreateUser {
  return !!hasCreateUser_;
}
- (void) setHasCreateUser:(BOOL) _value_ {
  hasCreateUser_ = !!_value_;
}
@synthesize createUser;
- (BOOL) hasIsAnonymous {
  return !!hasIsAnonymous_;
}
- (void) setHasIsAnonymous:(BOOL) _value_ {
  hasIsAnonymous_ = !!_value_;
}
- (BOOL) isAnonymous {
  return !!isAnonymous_;
}
- (void) setIsAnonymous:(BOOL) _value_ {
  isAnonymous_ = !!_value_;
}
@synthesize blessingUserArray;
@dynamic blessingUser;
- (BOOL) hasTitle {
  return !!hasTitle_;
}
- (void) setHasTitle:(BOOL) _value_ {
  hasTitle_ = !!_value_;
}
@synthesize title;
- (BOOL) hasText {
  return !!hasText_;
}
- (void) setHasText:(BOOL) _value_ {
  hasText_ = !!_value_;
}
@synthesize text;
- (BOOL) hasDate {
  return !!hasDate_;
}
- (void) setHasDate:(BOOL) _value_ {
  hasDate_ = !!_value_;
}
@synthesize date;
@synthesize topicArray;
@dynamic topic;
@synthesize commentArray;
@dynamic comment;
- (instancetype) init {
  if ((self = [super init])) {
    self.type = PBFeedTypeFeedTypeWorry;
    self.feedId = @"";
    self.createUser = [PBUser defaultInstance];
    self.isAnonymous = NO;
    self.title = @"";
    self.text = @"";
    self.date = 0;
  }
  return self;
}
static PBFeed* defaultPBFeedInstance = nil;
+ (void) initialize {
  if (self == [PBFeed class]) {
    defaultPBFeedInstance = [[PBFeed alloc] init];
  }
}
+ (instancetype) defaultInstance {
  return defaultPBFeedInstance;
}
- (instancetype) defaultInstance {
  return defaultPBFeedInstance;
}
- (NSArray *)blessingUser {
  return blessingUserArray;
}
- (PBUser*)blessingUserAtIndex:(NSUInteger)index {
  return [blessingUserArray objectAtIndex:index];
}
- (NSArray *)topic {
  return topicArray;
}
- (PBTopic*)topicAtIndex:(NSUInteger)index {
  return [topicArray objectAtIndex:index];
}
- (NSArray *)comment {
  return commentArray;
}
- (PBComment*)commentAtIndex:(NSUInteger)index {
  return [commentArray objectAtIndex:index];
}
- (BOOL) isInitialized {
  if (self.hasCreateUser) {
    if (!self.createUser.isInitialized) {
      return NO;
    }
  }
  __block BOOL isInitblessingUser = YES;
   [self.blessingUser enumerateObjectsUsingBlock:^(PBUser *element, NSUInteger idx, BOOL *stop) {
    if (!element.isInitialized) {
      isInitblessingUser = NO;
      *stop = YES;
    }
  }];
  if (!isInitblessingUser) return isInitblessingUser;
  __block BOOL isInitcomment = YES;
   [self.comment enumerateObjectsUsingBlock:^(PBComment *element, NSUInteger idx, BOOL *stop) {
    if (!element.isInitialized) {
      isInitcomment = NO;
      *stop = YES;
    }
  }];
  if (!isInitcomment) return isInitcomment;
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasType) {
    [output writeEnum:1 value:self.type];
  }
  if (self.hasFeedId) {
    [output writeString:2 value:self.feedId];
  }
  if (self.hasCreateUser) {
    [output writeMessage:3 value:self.createUser];
  }
  if (self.hasIsAnonymous) {
    [output writeBool:5 value:self.isAnonymous];
  }
  [self.blessingUserArray enumerateObjectsUsingBlock:^(PBUser *element, NSUInteger idx, BOOL *stop) {
    [output writeMessage:7 value:element];
  }];
  if (self.hasTitle) {
    [output writeString:40 value:self.title];
  }
  if (self.hasText) {
    [output writeString:41 value:self.text];
  }
  if (self.hasDate) {
    [output writeInt32:42 value:self.date];
  }
  [self.topicArray enumerateObjectsUsingBlock:^(PBTopic *element, NSUInteger idx, BOOL *stop) {
    [output writeMessage:50 value:element];
  }];
  [self.commentArray enumerateObjectsUsingBlock:^(PBComment *element, NSUInteger idx, BOOL *stop) {
    [output writeMessage:60 value:element];
  }];
  [self.unknownFields writeToCodedOutputStream:output];
}
- (SInt32) serializedSize {
  __block SInt32 size_ = memoizedSerializedSize;
  if (size_ != -1) {
    return size_;
  }

  size_ = 0;
  if (self.hasType) {
    size_ += computeEnumSize(1, self.type);
  }
  if (self.hasFeedId) {
    size_ += computeStringSize(2, self.feedId);
  }
  if (self.hasCreateUser) {
    size_ += computeMessageSize(3, self.createUser);
  }
  if (self.hasIsAnonymous) {
    size_ += computeBoolSize(5, self.isAnonymous);
  }
  [self.blessingUserArray enumerateObjectsUsingBlock:^(PBUser *element, NSUInteger idx, BOOL *stop) {
    size_ += computeMessageSize(7, element);
  }];
  if (self.hasTitle) {
    size_ += computeStringSize(40, self.title);
  }
  if (self.hasText) {
    size_ += computeStringSize(41, self.text);
  }
  if (self.hasDate) {
    size_ += computeInt32Size(42, self.date);
  }
  [self.topicArray enumerateObjectsUsingBlock:^(PBTopic *element, NSUInteger idx, BOOL *stop) {
    size_ += computeMessageSize(50, element);
  }];
  [self.commentArray enumerateObjectsUsingBlock:^(PBComment *element, NSUInteger idx, BOOL *stop) {
    size_ += computeMessageSize(60, element);
  }];
  size_ += self.unknownFields.serializedSize;
  memoizedSerializedSize = size_;
  return size_;
}
+ (PBFeed*) parseFromData:(NSData*) data {
  return (PBFeed*)[[[PBFeed builder] mergeFromData:data] build];
}
+ (PBFeed*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBFeed*)[[[PBFeed builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (PBFeed*) parseFromInputStream:(NSInputStream*) input {
  return (PBFeed*)[[[PBFeed builder] mergeFromInputStream:input] build];
}
+ (PBFeed*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBFeed*)[[[PBFeed builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PBFeed*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (PBFeed*)[[[PBFeed builder] mergeFromCodedInputStream:input] build];
}
+ (PBFeed*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBFeed*)[[[PBFeed builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PBFeedBuilder*) builder {
  return [[PBFeedBuilder alloc] init];
}
+ (PBFeedBuilder*) builderWithPrototype:(PBFeed*) prototype {
  return [[PBFeed builder] mergeFrom:prototype];
}
- (PBFeedBuilder*) builder {
  return [PBFeed builder];
}
- (PBFeedBuilder*) toBuilder {
  return [PBFeed builderWithPrototype:self];
}
- (void) writeDescriptionTo:(NSMutableString*) output withIndent:(NSString*) indent {
  if (self.hasType) {
    [output appendFormat:@"%@%@: %@\n", indent, @"type", NSStringFromPBFeedType(self.type)];
  }
  if (self.hasFeedId) {
    [output appendFormat:@"%@%@: %@\n", indent, @"feedId", self.feedId];
  }
  if (self.hasCreateUser) {
    [output appendFormat:@"%@%@ {\n", indent, @"createUser"];
    [self.createUser writeDescriptionTo:output
                         withIndent:[NSString stringWithFormat:@"%@  ", indent]];
    [output appendFormat:@"%@}\n", indent];
  }
  if (self.hasIsAnonymous) {
    [output appendFormat:@"%@%@: %@\n", indent, @"isAnonymous", [NSNumber numberWithBool:self.isAnonymous]];
  }
  [self.blessingUserArray enumerateObjectsUsingBlock:^(PBUser *element, NSUInteger idx, BOOL *stop) {
    [output appendFormat:@"%@%@ {\n", indent, @"blessingUser"];
    [element writeDescriptionTo:output
                     withIndent:[NSString stringWithFormat:@"%@  ", indent]];
    [output appendFormat:@"%@}\n", indent];
  }];
  if (self.hasTitle) {
    [output appendFormat:@"%@%@: %@\n", indent, @"title", self.title];
  }
  if (self.hasText) {
    [output appendFormat:@"%@%@: %@\n", indent, @"text", self.text];
  }
  if (self.hasDate) {
    [output appendFormat:@"%@%@: %@\n", indent, @"date", [NSNumber numberWithInteger:self.date]];
  }
  [self.topicArray enumerateObjectsUsingBlock:^(PBTopic *element, NSUInteger idx, BOOL *stop) {
    [output appendFormat:@"%@%@ {\n", indent, @"topic"];
    [element writeDescriptionTo:output
                     withIndent:[NSString stringWithFormat:@"%@  ", indent]];
    [output appendFormat:@"%@}\n", indent];
  }];
  [self.commentArray enumerateObjectsUsingBlock:^(PBComment *element, NSUInteger idx, BOOL *stop) {
    [output appendFormat:@"%@%@ {\n", indent, @"comment"];
    [element writeDescriptionTo:output
                     withIndent:[NSString stringWithFormat:@"%@  ", indent]];
    [output appendFormat:@"%@}\n", indent];
  }];
  [self.unknownFields writeDescriptionTo:output withIndent:indent];
}
- (BOOL) isEqual:(id)other {
  if (other == self) {
    return YES;
  }
  if (![other isKindOfClass:[PBFeed class]]) {
    return NO;
  }
  PBFeed *otherMessage = other;
  return
      self.hasType == otherMessage.hasType &&
      (!self.hasType || self.type == otherMessage.type) &&
      self.hasFeedId == otherMessage.hasFeedId &&
      (!self.hasFeedId || [self.feedId isEqual:otherMessage.feedId]) &&
      self.hasCreateUser == otherMessage.hasCreateUser &&
      (!self.hasCreateUser || [self.createUser isEqual:otherMessage.createUser]) &&
      self.hasIsAnonymous == otherMessage.hasIsAnonymous &&
      (!self.hasIsAnonymous || self.isAnonymous == otherMessage.isAnonymous) &&
      [self.blessingUserArray isEqualToArray:otherMessage.blessingUserArray] &&
      self.hasTitle == otherMessage.hasTitle &&
      (!self.hasTitle || [self.title isEqual:otherMessage.title]) &&
      self.hasText == otherMessage.hasText &&
      (!self.hasText || [self.text isEqual:otherMessage.text]) &&
      self.hasDate == otherMessage.hasDate &&
      (!self.hasDate || self.date == otherMessage.date) &&
      [self.topicArray isEqualToArray:otherMessage.topicArray] &&
      [self.commentArray isEqualToArray:otherMessage.commentArray] &&
      (self.unknownFields == otherMessage.unknownFields || (self.unknownFields != nil && [self.unknownFields isEqual:otherMessage.unknownFields]));
}
- (NSUInteger) hash {
  __block NSUInteger hashCode = 7;
  if (self.hasType) {
    hashCode = hashCode * 31 + self.type;
  }
  if (self.hasFeedId) {
    hashCode = hashCode * 31 + [self.feedId hash];
  }
  if (self.hasCreateUser) {
    hashCode = hashCode * 31 + [self.createUser hash];
  }
  if (self.hasIsAnonymous) {
    hashCode = hashCode * 31 + [[NSNumber numberWithBool:self.isAnonymous] hash];
  }
  [self.blessingUserArray enumerateObjectsUsingBlock:^(PBUser *element, NSUInteger idx, BOOL *stop) {
    hashCode = hashCode * 31 + [element hash];
  }];
  if (self.hasTitle) {
    hashCode = hashCode * 31 + [self.title hash];
  }
  if (self.hasText) {
    hashCode = hashCode * 31 + [self.text hash];
  }
  if (self.hasDate) {
    hashCode = hashCode * 31 + [[NSNumber numberWithInteger:self.date] hash];
  }
  [self.topicArray enumerateObjectsUsingBlock:^(PBTopic *element, NSUInteger idx, BOOL *stop) {
    hashCode = hashCode * 31 + [element hash];
  }];
  [self.commentArray enumerateObjectsUsingBlock:^(PBComment *element, NSUInteger idx, BOOL *stop) {
    hashCode = hashCode * 31 + [element hash];
  }];
  hashCode = hashCode * 31 + [self.unknownFields hash];
  return hashCode;
}
@end

@interface PBFeedBuilder()
@property (strong) PBFeed* resultPbfeed;
@end

@implementation PBFeedBuilder
@synthesize resultPbfeed;
- (instancetype) init {
  if ((self = [super init])) {
    self.resultPbfeed = [[PBFeed alloc] init];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return resultPbfeed;
}
- (PBFeedBuilder*) clear {
  self.resultPbfeed = [[PBFeed alloc] init];
  return self;
}
- (PBFeedBuilder*) clone {
  return [PBFeed builderWithPrototype:resultPbfeed];
}
- (PBFeed*) defaultInstance {
  return [PBFeed defaultInstance];
}
- (PBFeed*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (PBFeed*) buildPartial {
  PBFeed* returnMe = resultPbfeed;
  self.resultPbfeed = nil;
  return returnMe;
}
- (PBFeedBuilder*) mergeFrom:(PBFeed*) other {
  if (other == [PBFeed defaultInstance]) {
    return self;
  }
  if (other.hasType) {
    [self setType:other.type];
  }
  if (other.hasFeedId) {
    [self setFeedId:other.feedId];
  }
  if (other.hasCreateUser) {
    [self mergeCreateUser:other.createUser];
  }
  if (other.hasIsAnonymous) {
    [self setIsAnonymous:other.isAnonymous];
  }
  if (other.blessingUserArray.count > 0) {
    if (resultPbfeed.blessingUserArray == nil) {
      resultPbfeed.blessingUserArray = [[NSMutableArray alloc] initWithArray:other.blessingUserArray];
    } else {
      [resultPbfeed.blessingUserArray addObjectsFromArray:other.blessingUserArray];
    }
  }
  if (other.hasTitle) {
    [self setTitle:other.title];
  }
  if (other.hasText) {
    [self setText:other.text];
  }
  if (other.hasDate) {
    [self setDate:other.date];
  }
  if (other.topicArray.count > 0) {
    if (resultPbfeed.topicArray == nil) {
      resultPbfeed.topicArray = [[NSMutableArray alloc] initWithArray:other.topicArray];
    } else {
      [resultPbfeed.topicArray addObjectsFromArray:other.topicArray];
    }
  }
  if (other.commentArray.count > 0) {
    if (resultPbfeed.commentArray == nil) {
      resultPbfeed.commentArray = [[NSMutableArray alloc] initWithArray:other.commentArray];
    } else {
      [resultPbfeed.commentArray addObjectsFromArray:other.commentArray];
    }
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (PBFeedBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (PBFeedBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSetBuilder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    SInt32 tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 8: {
        PBFeedType value = (PBFeedType)[input readEnum];
        if (PBFeedTypeIsValidValue(value)) {
          [self setType:value];
        } else {
          [unknownFields mergeVarintField:1 value:value];
        }
        break;
      }
      case 18: {
        [self setFeedId:[input readString]];
        break;
      }
      case 26: {
        PBUserBuilder* subBuilder = [PBUser builder];
        if (self.hasCreateUser) {
          [subBuilder mergeFrom:self.createUser];
        }
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self setCreateUser:[subBuilder buildPartial]];
        break;
      }
      case 40: {
        [self setIsAnonymous:[input readBool]];
        break;
      }
      case 58: {
        PBUserBuilder* subBuilder = [PBUser builder];
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self addBlessingUser:[subBuilder buildPartial]];
        break;
      }
      case 322: {
        [self setTitle:[input readString]];
        break;
      }
      case 330: {
        [self setText:[input readString]];
        break;
      }
      case 336: {
        [self setDate:[input readInt32]];
        break;
      }
      case 402: {
        PBTopicBuilder* subBuilder = [PBTopic builder];
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self addTopic:[subBuilder buildPartial]];
        break;
      }
      case 482: {
        PBCommentBuilder* subBuilder = [PBComment builder];
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self addComment:[subBuilder buildPartial]];
        break;
      }
    }
  }
}
- (BOOL) hasType {
  return resultPbfeed.hasType;
}
- (PBFeedType) type {
  return resultPbfeed.type;
}
- (PBFeedBuilder*) setType:(PBFeedType) value {
  resultPbfeed.hasType = YES;
  resultPbfeed.type = value;
  return self;
}
- (PBFeedBuilder*) clearType {
  resultPbfeed.hasType = NO;
  resultPbfeed.type = PBFeedTypeFeedTypeWorry;
  return self;
}
- (BOOL) hasFeedId {
  return resultPbfeed.hasFeedId;
}
- (NSString*) feedId {
  return resultPbfeed.feedId;
}
- (PBFeedBuilder*) setFeedId:(NSString*) value {
  resultPbfeed.hasFeedId = YES;
  resultPbfeed.feedId = value;
  return self;
}
- (PBFeedBuilder*) clearFeedId {
  resultPbfeed.hasFeedId = NO;
  resultPbfeed.feedId = @"";
  return self;
}
- (BOOL) hasCreateUser {
  return resultPbfeed.hasCreateUser;
}
- (PBUser*) createUser {
  return resultPbfeed.createUser;
}
- (PBFeedBuilder*) setCreateUser:(PBUser*) value {
  resultPbfeed.hasCreateUser = YES;
  resultPbfeed.createUser = value;
  return self;
}
- (PBFeedBuilder*) setCreateUserBuilder:(PBUserBuilder*) builderForValue {
  return [self setCreateUser:[builderForValue build]];
}
- (PBFeedBuilder*) mergeCreateUser:(PBUser*) value {
  if (resultPbfeed.hasCreateUser &&
      resultPbfeed.createUser != [PBUser defaultInstance]) {
    resultPbfeed.createUser =
      [[[PBUser builderWithPrototype:resultPbfeed.createUser] mergeFrom:value] buildPartial];
  } else {
    resultPbfeed.createUser = value;
  }
  resultPbfeed.hasCreateUser = YES;
  return self;
}
- (PBFeedBuilder*) clearCreateUser {
  resultPbfeed.hasCreateUser = NO;
  resultPbfeed.createUser = [PBUser defaultInstance];
  return self;
}
- (BOOL) hasIsAnonymous {
  return resultPbfeed.hasIsAnonymous;
}
- (BOOL) isAnonymous {
  return resultPbfeed.isAnonymous;
}
- (PBFeedBuilder*) setIsAnonymous:(BOOL) value {
  resultPbfeed.hasIsAnonymous = YES;
  resultPbfeed.isAnonymous = value;
  return self;
}
- (PBFeedBuilder*) clearIsAnonymous {
  resultPbfeed.hasIsAnonymous = NO;
  resultPbfeed.isAnonymous = NO;
  return self;
}
- (NSMutableArray *)blessingUser {
  return resultPbfeed.blessingUserArray;
}
- (PBUser*)blessingUserAtIndex:(NSUInteger)index {
  return [resultPbfeed blessingUserAtIndex:index];
}
- (PBFeedBuilder *)addBlessingUser:(PBUser*)value {
  if (resultPbfeed.blessingUserArray == nil) {
    resultPbfeed.blessingUserArray = [[NSMutableArray alloc]init];
  }
  [resultPbfeed.blessingUserArray addObject:value];
  return self;
}
- (PBFeedBuilder *)setBlessingUserArray:(NSArray *)array {
  resultPbfeed.blessingUserArray = [[NSMutableArray alloc]initWithArray:array];
  return self;
}
- (PBFeedBuilder *)clearBlessingUser {
  resultPbfeed.blessingUserArray = nil;
  return self;
}
- (BOOL) hasTitle {
  return resultPbfeed.hasTitle;
}
- (NSString*) title {
  return resultPbfeed.title;
}
- (PBFeedBuilder*) setTitle:(NSString*) value {
  resultPbfeed.hasTitle = YES;
  resultPbfeed.title = value;
  return self;
}
- (PBFeedBuilder*) clearTitle {
  resultPbfeed.hasTitle = NO;
  resultPbfeed.title = @"";
  return self;
}
- (BOOL) hasText {
  return resultPbfeed.hasText;
}
- (NSString*) text {
  return resultPbfeed.text;
}
- (PBFeedBuilder*) setText:(NSString*) value {
  resultPbfeed.hasText = YES;
  resultPbfeed.text = value;
  return self;
}
- (PBFeedBuilder*) clearText {
  resultPbfeed.hasText = NO;
  resultPbfeed.text = @"";
  return self;
}
- (BOOL) hasDate {
  return resultPbfeed.hasDate;
}
- (SInt32) date {
  return resultPbfeed.date;
}
- (PBFeedBuilder*) setDate:(SInt32) value {
  resultPbfeed.hasDate = YES;
  resultPbfeed.date = value;
  return self;
}
- (PBFeedBuilder*) clearDate {
  resultPbfeed.hasDate = NO;
  resultPbfeed.date = 0;
  return self;
}
- (NSMutableArray *)topic {
  return resultPbfeed.topicArray;
}
- (PBTopic*)topicAtIndex:(NSUInteger)index {
  return [resultPbfeed topicAtIndex:index];
}
- (PBFeedBuilder *)addTopic:(PBTopic*)value {
  if (resultPbfeed.topicArray == nil) {
    resultPbfeed.topicArray = [[NSMutableArray alloc]init];
  }
  [resultPbfeed.topicArray addObject:value];
  return self;
}
- (PBFeedBuilder *)setTopicArray:(NSArray *)array {
  resultPbfeed.topicArray = [[NSMutableArray alloc]initWithArray:array];
  return self;
}
- (PBFeedBuilder *)clearTopic {
  resultPbfeed.topicArray = nil;
  return self;
}
- (NSMutableArray *)comment {
  return resultPbfeed.commentArray;
}
- (PBComment*)commentAtIndex:(NSUInteger)index {
  return [resultPbfeed commentAtIndex:index];
}
- (PBFeedBuilder *)addComment:(PBComment*)value {
  if (resultPbfeed.commentArray == nil) {
    resultPbfeed.commentArray = [[NSMutableArray alloc]init];
  }
  [resultPbfeed.commentArray addObject:value];
  return self;
}
- (PBFeedBuilder *)setCommentArray:(NSArray *)array {
  resultPbfeed.commentArray = [[NSMutableArray alloc]initWithArray:array];
  return self;
}
- (PBFeedBuilder *)clearComment {
  resultPbfeed.commentArray = nil;
  return self;
}
@end


// @@protoc_insertion_point(global_scope)
