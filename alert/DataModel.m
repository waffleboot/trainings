
#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface DataModel ()
@property NSMutableArray *mutableTrainings;
@end

@implementation DataModel

+ (instancetype)sharedInstance {
  static dispatch_once_t once;
  static id sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

- (instancetype)init {
  if (self = [super init]) {
    NSLog(@"%@", self.mutableTrainings);
    self.mutableTrainings = [[NSMutableArray alloc] init];
  }
  return self;
}

- (NSArray*)trainings {
  return self.mutableTrainings;
}

- (Training *)addTrainingWithName:(NSString *)name {
  Training *training = [[Training alloc] init];
  training.name = name;
  [self.mutableTrainings addObject:training];
  return training;
}

- (void)deleteTraining:(Training *)training {
  [self.mutableTrainings removeObject:training];
}

@end

@interface Training ()
@property NSMutableArray *mutableApproaches;
@end

@implementation Training

- (instancetype)init {
  if (self = [super init]) {
    self.mutableApproaches = [[NSMutableArray alloc] init];
  }
  return self;
}

- (NSArray *)approaches {
  return self.mutableApproaches;
}

- (Approach *)addApproachWithName:(NSString *)name {
  Approach *approach = [[Approach alloc] init];
  approach.name = name;
  approach.training = self;
  [self.mutableApproaches addObject:approach];
  return approach;
}
@end

@interface Approach ()
@property NSMutableArray *mutableExercises;
@end

@implementation Approach
- (instancetype)init {
  if (self = [super init]) {
    self.mutableExercises = [[NSMutableArray alloc] init];
  }
  return self;
}
- (NSArray *)exercises {
  return self.mutableExercises;
}
- (void)addExercise:(NSUInteger)count {
  [self.mutableExercises addObject: [NSNumber numberWithUnsignedInteger:count]];
}
@end

