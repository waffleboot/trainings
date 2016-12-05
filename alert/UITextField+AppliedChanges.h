
#import <UIKit/UIKit.h>

@interface UITextField (AppliedChanges)

- (NSString *)textAfterChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
