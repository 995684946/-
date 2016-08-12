//
//  DataHelper.m
//  你听啥
//
//  Created by anyurchao on 15/10/22.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "DataHelper.h"
#import <UIKit/UIKit.h>

@interface DataHelper ()

@property (nonatomic,strong)NSMutableDictionary *allDataDic;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSMutableArray *Aarray;
@property (nonatomic,strong)NSMutableArray *dataMusicArray;

@end

@implementation DataHelper

+ (instancetype)shareDataHelper
{
    static DataHelper *data = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [DataHelper new];
    });
    return data;
 
}

- (instancetype) init
{
    if (self = [super init]) {
    
    }
    return self;
}




- (NSMutableDictionary *)allDataDic
{
    if (!_allDataDic) {
        self.allDataDic = [NSMutableDictionary dictionary];
        
    }
    return _allDataDic;
}

- (NSMutableArray *)dataMusicArray
{
    if (!_dataMusicArray) {
        
        self.dataMusicArray  = [NSMutableArray array];
 
    }
    
    return _dataMusicArray;
}


//获取key对应的Value
- (NSArray *)getPopMusicWithKey:(NSString *)key
{
    NSArray *array = [self.allDataDic objectForKey:key];
    
    return [array copy];
}

- (NSMutableDictionary *)allDatadictionary{
    
    return self.allDataDic;
    
}
- (void)addobject:(NSMutableArray *)object forKey:(NSString *)str
{
    [self.allDataDic setObject:object forKey:str];
    
}


- (NSArray*)allKeys{
    
   return self.allDataDic.allKeys;
}

#pragma mark 存放Music
- (void)addObjectStorePopThered:(PopThered *)PopThered
{

    [self.dataMusicArray addObject:PopThered];

}

- (NSArray *)allMusicArray
{
    return self.dataMusicArray;
}

//******************************


#pragma mark 加载PopMusic
- (void) loadDataPopMusicblock:(Block)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:MusciUrlFirst]];
    
    NSURLSession *session = [NSURLSession sharedSession];
                             

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!data) {
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        _array = [[NSMutableArray alloc] initWithCapacity:10];
        
        for (NSDictionary *dic in [dict objectForKey:@"list"]) {
            
            PopMusic *popMusic = [PopMusic new];
            [popMusic setValuesForKeysWithDictionary:dic];
            [_array addObject:popMusic];
            
        }
        
        NSMutableArray *sArray = [NSMutableArray arrayWithArray:_array];
        [self.allDataDic setObject:sArray forKey:@"PopMusicFirst"];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            block();
            
        });
    
    }];
    
    [task resume];
       
    });
}

//1测试
- (void)loadDataMusicSecondWithTName:(NSString *)TName count:(NSInteger)count block:(Block)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *str =
        [TName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *strURL = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=music&condition=hot&device=android&page=3&per_page=%ld",count];
        NSString *strCON = [NSString stringWithFormat:@"&status=0&tag_name=%@",str];
        
        NSString *url = [strURL stringByAppendingString:strCON];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSURLSession *Session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [Session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!data) {
                return ;
            }
            
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            _array = [[NSMutableArray alloc] initWithCapacity:10];
            
            
            for (NSDictionary *dic in [dict objectForKey:@"list"]) {
                
                PopMusic *pop = [PopMusic new];
                [pop setValuesForKeysWithDictionary:dic];
                [_array addObject:pop];
                
            }
            
            NSMutableArray *sarray = [NSMutableArray arrayWithArray:_array];
            
            [self.allDataDic setObject:sarray forKey:@"PopMusicSecond"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block();
                
            });
            
            
        }];
        [task resume];
        
        
    });

    
    
    
}








- (void)loadDataMusicSecondWithTName:(NSString *)TName block:(Block)block;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *str =
        [TName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
      NSString *url = [MusicUrlSecond stringByAppendingString:str];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

        NSURLSession *Session = [NSURLSession sharedSession];
        
    NSURLSessionDataTask *task = [Session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            return ;
        }
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        _array = [[NSMutableArray alloc] initWithCapacity:10];

        
        for (NSDictionary *dic in [dict objectForKey:@"list"]) {
            
            PopMusic *pop = [PopMusic new];
            [pop setValuesForKeysWithDictionary:dic];
            [_array addObject:pop];

        }
        
        NSMutableArray *sarray = [NSMutableArray arrayWithArray:_array];
        
        [self.allDataDic setObject:sarray forKey:@"PopMusicSecond"];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            block();
  
        });

        
    }];
        [task resume];
        
        
    });
    
    
}

- (void)loadDataMusicTheredWithAlbumId:(NSInteger)AlbumId block:(Block)block
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ss = [NSString stringWithFormat:@"%ld",AlbumId];
        
        NSString *str = [MusicUrlThered stringByAppendingString:ss];
        
        NSString *url = [str stringByAppendingString:MusicUrlTheredSmall];

        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSURLSession *sesson = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!data) {
                return ;
            }
            
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            //1
            _array = [[NSMutableArray alloc] initWithCapacity:10];
            
            NSDictionary *dic = [dict objectForKey:@"album"];
            
                PopThered *pop = [PopThered new];
                [pop setValuesForKeysWithDictionary:dic];
                [_array addObject:pop];
            
            NSArray *Array = [NSArray arrayWithArray:_array];
            [self.allDataDic setObject:Array forKey:@"PopMusicThered"];
            
            //2
            _Aarray = [[NSMutableArray alloc] initWithCapacity:10];
        
            NSDictionary *dictionary = [dict objectForKey:@"tracks"];
           
            
            for (NSDictionary *d in [dictionary objectForKey:@"list"]) {
               
               
                PopThered *pop = [PopThered new];
                [pop setValuesForKeysWithDictionary:d];
                [_Aarray addObject:pop];
            }
            
            NSArray *aarray = [NSMutableArray arrayWithArray:_Aarray];
            
            [self.allDataDic setObject:aarray forKey:@"PopMusicThered2"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                block();
                
            });
            
            
        }];
        [task resume];
        

    });
    
    
    
}




#pragma mark 加载PopSounds数据
- (void) loadDataPopSoundsblock:(Block)block;{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:SoundsUrlFirst]];
 
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            if (!data) {
                return ;
            }
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            _array = [[NSMutableArray alloc] initWithCapacity:10];
            
            for (NSDictionary *dic in [dict objectForKey:@"list"]) {
                
                PopMusic *popMusic = [PopMusic new];
                [popMusic setValuesForKeysWithDictionary:dic];
                [_array addObject:popMusic];
                
            }
            

            NSMutableArray *array = [NSMutableArray arrayWithArray:_array];
            
            [self.allDataDic setObject:array forKey:@"PopSoundsFirst"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block();
                
            });

            
        }];
        
        [task resume];
        
    });
    

    
    
}

- (void)loadDataSoundsSecondWithTName:(NSString *)TName block:(Block)block{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *str =
        [TName
         stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *url = [SoundsUrlSecond stringByAppendingString:str];
        
       
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSURLSession *Session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [Session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            if (!data) {
                return ;
            }
            
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            _array = [[NSMutableArray alloc] initWithCapacity:10];
            
            
            for (NSDictionary *dic in [dict objectForKey:@"list"]) {
                
                PopMusic *pop = [PopMusic new];
                [pop setValuesForKeysWithDictionary:dic];
                [_array addObject:pop];
                

            }
            

            [self.allDataDic setObject:_array forKey:@"PopSoundsSecond"];
            
//            NSArray *Array = self.allDataDic[@"PopSoundsSecond"];
//            NSLog(@"%@",Array);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block();
                
            });
            
        }];
        [task resume];
        
    });
  
}

- (void)loadDataSoundsTheredWithAlbumId:(NSInteger)AlbumId block:(Block)block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ss = [NSString stringWithFormat:@"%ld",AlbumId];
        
        NSString *str = [SoundsUrlThered stringByAppendingString:ss];
        
        NSString *url = [str stringByAppendingString:SoundsUrlTheredSmall];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSURLSession *sesson = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            if (!data) {
                return ;
            }
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            //1
            _array = [[NSMutableArray alloc] initWithCapacity:10];
            
            NSDictionary *dic = [dict objectForKey:@"album"];
            
            PopThered *pop = [PopThered new];
            [pop setValuesForKeysWithDictionary:dic];
            [_array addObject:pop];
            
            NSMutableArray *Array = [NSMutableArray arrayWithArray:_array];

            [self.allDataDic setObject:Array forKey:@"PopSoundThered"];
            
//            [[DataHelper shareDataHelper] addobject:Array forKey:@"PopSoundThered"];
            
            
            //2
  
            _Aarray = [[NSMutableArray alloc] initWithCapacity:10];
            NSDictionary *dictionary = dict[@"tracks"];
            
            for (NSDictionary *d in dictionary[@"list"]) {
                
                PopThered *pop = [PopThered new];
                [pop setValuesForKeysWithDictionary:d];
                [_Aarray addObject:pop];
            }
            

            NSMutableArray *array1 = [NSMutableArray arrayWithArray:_Aarray];
            [self.allDataDic setObject:array1 forKey:@"PopSoundThered2"];
            
//            [[DataHelper shareDataHelper]addobject:_Aarray forKey:@"PopSoundThered2"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                block();
            });
            
        }];
        [task resume];
        
    });
    
}



#pragma mark 加载PopOpera
- (void) loadDataPopOperablock:(Block)block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:OperaUrlFirst]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!data) {
                return ;
            }
            
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            _array = [[NSMutableArray alloc] initWithCapacity:10];
            
            for (NSDictionary *dic in [dict objectForKey:@"list"]) {
                
                PopMusic *popMusic = [PopMusic new];
                [popMusic setValuesForKeysWithDictionary:dic];
                [_array addObject:popMusic];
                
            }
            
            
//            NSLog(@"%@",_array);

            NSMutableArray *Array = [NSMutableArray arrayWithArray:_array];
        
            [self.allDataDic setObject:Array forKey:@"PopOperaFirst"];
            
//            [[DataHelper shareDataHelper]addobject:_array forKey:@"PopOperaFirst"];
 
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block();
            });
            
        }];
        
        [task resume];
        
       
        
    });
    
}
- (void)loadDataOperaSecondWithTName:(NSString *)TName block:(Block)block{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *str =
        [TName
         stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *url = [OperaUrlSecond stringByAppendingString:str];
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSURLSession *Session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [Session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!data) {
                return ;
            }
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            _array = [[NSMutableArray alloc] initWithCapacity:10];
            
            
            for (NSDictionary *dic in [dict objectForKey:@"list"]) {
                
                PopMusic *pop = [PopMusic new];
                [pop setValuesForKeysWithDictionary:dic];
                [_array addObject:pop];
                
            }
            NSMutableArray *Array = [NSMutableArray arrayWithArray:_array];
            
            
            [self.allDataDic setObject:Array forKey:@"PopOperaSecond"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block();
                
            });
            
        }];
        [task resume];
        
    });
  
}
- (void)loadDataOperaTheredWithAlbumId:(NSInteger)AlbumId block:(Block)block{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ss = [NSString stringWithFormat:@"%ld",AlbumId];
        
        NSString *str = [OperaUrlThered stringByAppendingString:ss];
        
        NSString *url = [str stringByAppendingString:OperaUrlTheredSmall];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSURLSession *sesson = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!data) {
                return ;
            }
            
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            //1
            _array = [[NSMutableArray alloc] initWithCapacity:10];
            
            NSDictionary *dic = [dict objectForKey:@"album"];
            
            PopThered *pop = [PopThered new];
            [pop setValuesForKeysWithDictionary:dic];
            [_array addObject:pop];
            
            [[DataHelper shareDataHelper] addobject:_array forKey:@"PopOperaThered"];
            
            
            //2
            
            _Aarray = [[NSMutableArray alloc] initWithCapacity:10];
            NSDictionary *dictionary = dict[@"tracks"];
            
            for (NSDictionary *d in dictionary[@"list"]) {
                
                PopThered *pop = [PopThered new];
                [pop setValuesForKeysWithDictionary:d];
                [_Aarray addObject:pop];
            }
            
            
            [[DataHelper shareDataHelper]addobject:_Aarray forKey:@"PopOperaThered2"];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block();
            });
            
        }];
        [task resume];
        
    });

    
}





@end
