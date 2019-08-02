/**
 *  Copyright (C) 2010-2019 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

#import <Foundation/Foundation.h>
#import "UIDefines.h"
#import "BrickCell.h"

@protocol ScriptProtocol;

@interface BrickManager : NSObject

+ (instancetype)sharedBrickManager;

// helpers
- (NSArray*)selectableBricks;
- (NSArray *)selectableScriptBricks;
- (NSArray*)selectableBricksForCategoryType:(kBrickCategoryType)categoryType;
- (NSArray*)selectableBricksForCategoryType:(kBrickCategoryType)categoryType inBackground:(BOOL)inBackground;
- (kBrickCategoryType)brickCategoryTypeForBrickType:(kBrickType)brickType;
- (kBrickType)brickTypeForCategoryType:(kBrickCategoryType)categoryType andBrickIndex:(NSUInteger)index;
- (CGSize)sizeForBrick:(NSString *)brickName;
- (BOOL)isScript:(kBrickType)type;
- (NSInteger)checkEndLoopBrickTypeForDrawing:(BrickCell*)cell;
- (NSArray*)animateWithIndexPath:(NSIndexPath*)path Script:(Script*)script andBrick:(Brick*)brick;
- (NSArray*)scriptCollectionCopyBrickWithIndexPath:(NSIndexPath*)indexPath andBrick:(Brick*)brick;
- (NSArray*)getIndexPathsForRemovingBricks:(NSIndexPath*)indexPath andBrick:(Brick*)brick;

@end
