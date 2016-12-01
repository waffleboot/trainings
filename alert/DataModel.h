
#import <Foundation/Foundation.h>

@class DataModel;
@class Training;
@class Approach;

@interface DataModel : NSObject
@property (readonly) NSArray *trainings;
- (void)addTraining:(Training *)training;
- (void)deleteTraining:(Training*)training;
- (void)loadUserDefaultsTrainings;
- (void)saveUserDefaultsTrainings;
@end

@interface DataModel (SharedInstance)
+ (instancetype)sharedInstance;
@end

@interface Training : NSObject <NSCoding>
@property NSString *name;
@property NSUInteger smallPeriod;
@property NSUInteger largePeriod;
@property (readonly) NSArray *approaches;
@property (readonly) NSUInteger maxRound;
- (Approach*)addApproach:(Approach*)name;
- (void)moveApproachFromIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)newIndex;
- (void)deleteApproach:(Approach*)approach;
@end

@interface Approach : NSObject <NSCoding>
@property NSString *name;
@property (readonly) NSArray *exercises;
@property (weak) Training *training;
- (void)addExercise:(NSUInteger)count;
- (void)moveExerciseFromIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)newIndex;
- (void)removeExercise:(NSUInteger)index;
- (NSUInteger)exercisesCountForRound:(NSUInteger)round;
@end
