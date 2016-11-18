//
//  OFADataFetcher.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OFADataFetcher <NSObject>
@property (nonatomic, strong) NSArray *sectionObjects;
- (void)fetchSuccess:(void (^)(void))success;
- (void)fetchedData:(id)obj onDataFetcher:(id<OFADataFetcher>)dataFetcher;
- (void)fetchingDataFaildWithError:(NSError *)error onDataFetcher:(id<OFADataFetcher>)dataFetcher;
@end

