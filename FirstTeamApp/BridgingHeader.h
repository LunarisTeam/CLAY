//
//  MetalBridgeHeader.h
//  FirstTeamApp
//
//  Created by Davide Castaldi on 17/07/24.
//

/**
 To use the metal or C header files, we need to bridge them. It's like the very good old times... let's import them, then.
 
 Don't forget to put in the project navigator, under "Objective-C Bridging Header" the $(SRCROOT) to find it on the disc, then refer to directories/sub-directories on the project navigator, on the left
 **/

#pragma once

#import "Brush/Solid/SolidBrushVertex.h"
#import "Brush/Sparkle/SparkleBrushVertex.h"
