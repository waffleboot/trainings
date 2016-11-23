
#import <Foundation/Foundation.h>

@class DataModel;
@class Training;
@class Approach;

@interface DataModel : NSObject
@property (readonly) NSArray *trainings;
- (Training*)addTrainingWithName:(NSString*)name;
- (void)deleteTraining:(Training*)training;
@end

@interface DataModel (SharedInstance)
+ (instancetype)sharedInstance;
@end

@interface Training : NSObject
@property NSString *name;
@property NSNumber *smallPeriod;
@property NSNumber *largePeriod;
@property (readonly) NSArray *approaches;
- (Approach*)addApproachWithName:(NSString*)name;
@end

@interface Approach : NSObject
@property NSString *name;
@property (readonly) NSArray *exercises;
@property (weak) Training *training;
- (void)addExercise:(NSUInteger)count;
@end
