
#import "UITextField+AppliedChanges.h"

@implementation UITextField (AppliedChanges)

- (NSString *)textAfterChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  NSString *text = [self.text stringByReplacingCharactersInRange:range withString:string];
  return [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
