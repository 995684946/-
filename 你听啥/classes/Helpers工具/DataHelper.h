//
//  DataHelper.h
//  你听啥
//
//  Created by anyurchao on 15/10/22.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Block) ();
@interface DataHelper : NSObject

@property(atomic,copy)Block block;
+(instancetype)shareDataHelper;

- (NSArray *)getPopMusicWithKey:(NSString *)key;

- (NSMutableDictionary *)allDatadictionary;

- (void)addobject:(NSMutableArray *)object forKey:(NSString *)str;

- (NSArray*)allKeys;

#pragma mark 存放音乐的数组
- (void)addObjectStorePopThered:(PopThered *)PopThered;
@property(nonatomic,strong)NSArray *allMusicArray;


//*********************************


//- (void) loadDataPopMusicblock:(Block)block url:(NSString *)url;
- (void)loadDataMusicSecondWithTName:(NSString *)TName count:(NSInteger)count block:(Block)block;


- (void) loadDataPopMusicblock:(Block)block;
- (void)loadDataMusicSecondWithTName:(NSString *)TName block:(Block)block;
- (void)loadDataMusicTheredWithAlbumId:(NSInteger)AlbumId block:(Block)block;

#pragma mark 加载PopSounds
- (void) loadDataPopSoundsblock:(Block)block;
- (void)loadDataSoundsSecondWithTName:(NSString *)TName block:(Block)block;
- (void)loadDataSoundsTheredWithAlbumId:(NSInteger)AlbumId block:(Block)block;

#pragma mark 加载PopOpera

- (void) loadDataPopOperablock:(Block)block;
- (void)loadDataOperaSecondWithTName:(NSString *)TName block:(Block)block;
- (void)loadDataOperaTheredWithAlbumId:(NSInteger)AlbumId block:(Block)block;


@end
