//
//  OFASelectableCell.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 07/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OFASelectableCell <NSObject>

-(BOOL)isSelected;
-(void)setSelected:(BOOL)selected;

@end