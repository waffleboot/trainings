//
//  RoundButton.m
//  alert
//
//  Created by Андрей on 23.11.16.
//  Copyright © 2016 Andrei Yangabishev. All rights reserved.
//

#import "RoundButton.h"

@implementation RoundButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    self.layer.cornerRadius = 5.0;
  }
  return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
