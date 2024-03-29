
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
    self.mutableTrainings = [NSMutableArray arrayWithCapacity:1];
  }
  return self;
}

- (void)loadUserDefaultsTrainings {
  NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"trainings"];
  NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  self.mutableTrainings = [NSMutableArray arrayWithArray:array];
}

- (void)saveUserDefaultsTrainings {
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.trainings];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"trainings"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray*)trainings {
  return self.mutableTrainings;
}

- (void)addTraining:(Training *)training {
  [self.mutableTrainings addObject:training];
  [self saveUserDefaultsTrainings];
}

- (void)deleteTraining:(Training *)training {
  [self.mutableTrainings removeObject:training];
  [self saveUserDefaultsTrainings];
}

@end

@interface Training ()
@property NSMutableArray *mutableApproaches;
@end

@implementation Training

- (instancetype)init {
  if (self = [super init]) {
    self.mutableApproaches = [NSMutableArray arrayWithCapacity:1];
    self.smallPeriod = 3;
    self.largePeriod = 7;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super init]) {
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.largePeriod = [aDecoder decodeIntegerForKey:@"largePeriod"];
    self.smallPeriod = [aDecoder decodeIntegerForKey:@"smallPeriod"];
    NSData *data = [aDecoder decodeObjectForKey:@"approaches"];
    NSArray *approaches = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    for (Approach *approach in approaches) {
      approach.training = self;
    }
    self.mutableApproaches = [NSMutableArray arrayWithArray:approaches];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeInteger:self.largePeriod forKey:@"largePeriod"];
  [aCoder encodeInteger:self.smallPeriod forKey:@"smallPeriod"];
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.approaches];
  [aCoder encodeObject:data forKey:@"approaches"];
}

- (NSArray *)approaches {
  return self.mutableApproaches;
}

- (void)deleteApproach:(Approach *)approach {
  [self.mutableApproaches removeObject:approach];
  [[DataModel sharedInstance] saveUserDefaultsTrainings];
}

- (Approach *)addApproach:(Approach *)approach {
  approach.training = self;
  [self.mutableApproaches addObject:approach];
  [[DataModel sharedInstance] saveUserDefaultsTrainings];
  return approach;
}

- (NSUInteger)maxRound {
  NSUInteger maxRound = 0;
  for (int i = 0; i < self.approaches.count; ++i) {
    Approach *approach = [self.approaches objectAtIndex:i];
    NSArray *exercises = approach.exercises;
    NSUInteger count = exercises.count;
    maxRound = MAX(maxRound, count);
  }
  return maxRound;
}

- (void)moveApproachFromIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)newIndex {
  id obj = [self.mutableApproaches objectAtIndex:sourceIndex];
  [self.mutableApproaches removeObjectAtIndex:sourceIndex];
  [self.mutableApproaches insertObject:obj atIndex:newIndex];
  [[DataModel sharedInstance] saveUserDefaultsTrainings];
}

@end

@interface Approach ()
@property NSMutableArray *mutableExercises;
@end

@implementation Approach

- (NSInteger)exercisesCountForRound:(NSUInteger)round {
  NSArray *exercises = self.exercises;
  NSUInteger count = exercises.count;
  if (round < count) {
    NSNumber *count = [exercises objectAtIndex:round];
    return [count unsignedIntegerValue];
  } else {
    return -1;
  }
}

- (instancetype)init {
  if (self = [super init]) {
    self.mutableExercises = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.name forKey:@"name"];
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.exercises];
  [aCoder encodeObject:data forKey:@"exercises"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super init]) {
    self.name = [aDecoder decodeObjectForKey:@"name"];
    NSData *data = [aDecoder decodeObjectForKey:@"exercises"];
    NSArray *exercises = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.mutableExercises = [NSMutableArray arrayWithArray:exercises];
  }
  return self;
}

- (NSArray *)exercises {
  return self.mutableExercises;
}

- (void)removeExercise:(NSUInteger)index {
  [self.mutableExercises removeObjectAtIndex:index];
  [[DataModel sharedInstance] saveUserDefaultsTrainings];
}

- (void)addExercise:(NSUInteger)count {
  [self.mutableExercises addObject: [NSNumber numberWithUnsignedInteger:count]];
  [[DataModel sharedInstance] saveUserDefaultsTrainings];
}

- (void)moveExerciseFromIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)newIndex {
  id obj = [self.mutableExercises objectAtIndex:sourceIndex];
  [self.mutableExercises removeObjectAtIndex:sourceIndex];
  [self.mutableExercises insertObject:obj atIndex:newIndex];
  [[DataModel sharedInstance] saveUserDefaultsTrainings];
}

@end

