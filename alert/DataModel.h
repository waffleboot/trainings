
#import <Foundation/Foundation.h>

@class DataModel;
@class Training;
@class Approach;

@interface DataModel : NSObject
@property (readonly) NSArray *trainings;
- (Training*)addTrainingWithName:(NSString*)name;
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
- (Approach*)addApproachWithName:(NSString*)name;
@end

@interface Approach : NSObject <NSCoding>
@property NSString *name;
@property (readonly) NSArray *exercises;
@property (weak) Training *training;
- (void)addExercise:(NSUInteger)count;
- (NSUInteger)exercisesCountForRound:(NSUInteger)round;
@end
