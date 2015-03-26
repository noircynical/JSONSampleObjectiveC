//
//  tableCell.h
//  JSONTest
//
//  Created by noirCynical on 2015. 3. 27..
//  Copyright (c) 2015년 LuceteK. All rights reserved.
//

#include "UIKit/UIKit.h"

@interface tableCell : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* speaker;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) NSString* room;
@property (nonatomic, strong) NSString* details;

@end