
#import "RoundButton.h"

@implementation RoundButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    self.layer.cornerRadius = 5.0;
  }
  return self;
}

@end
