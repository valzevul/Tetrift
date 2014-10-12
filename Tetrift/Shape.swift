//
//  Shape.swift
//  Tetrift
//
//  Created by Vadim Drobinin on 12/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import SpriteKit

let NumOrientations: UInt32 = 4

enum Orientation: Int, Printable {
    case Zero = 0, Ninety, OneEighty, TwoSeventy
    
    var description: String {
        switch self {
        case .Zero:
            return "0"
        case .Ninety:
            return "90"
        case .OneEighty:
            return "180"
        case .TwoSeventy:
            return "270"
        }
    }
    
    static func random() -> Orientation {
        return Orientation.fromRaw(Int(arc4random_uniform(NumOrientations)))!
    }
    
    static func rotate(orientation: Orientation, clockwise: Bool) -> Orientation {
        
        var rotated = orientation.toRaw() + (clockwise ? 1 : -1)
        
        if rotated > Orientation.TwoSeventy.toRaw() {
            rotated = Orientation.Zero.toRaw()
        } else if rotated < 0 {
            rotated = Orientation.TwoSeventy.toRaw()
        }
        return Orientation.fromRaw(rotated)!
    }
}

// The number of total shape varietes
let NumShapeTypes: UInt32 = 7

// Shape indexes
let FirstBlockIdx: Int = 0
let SecondBlockIdx: Int = 1
let ThirdBlockIdx: Int = 2
let ForthBlockIdx: Int = 3

class Shape: Hashable, Printable {
    // the color of the same shape
    let color: BlockColor
    
    // the blocks comprising the shape
    var blocks = Array<Block>()
    
    // the current orientation of the shape
    var orientation: Orientation
    
    // the column and row representing the shape's anchor point
    var column, row: Int
    
    // Requireq overrides
    
    // subclasses must override this propery
    var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
    
    // subclasses must override this propery
    var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [:]
    }
    
    // subclasses must override this propery
    var BottomBlocks: Array<Block> {
        if let bottomBLocks = bottomBlocksForOrientations[orientation] {
            return bottomBLocks
        }
        return []
    }
    
    var hashValue: Int {
        return reduce(blocks, 0) { $0.hashValue ^ $1.hashValue }
    }
    
    var description: String {
        return "\(color) block facing \(orientation): \(blocks[FirstBlockIdx]), \(blocks[SecondBlockIdx]), \(blocks[ThirdBlockIdx]), \(blocks[ForthBlockIdx])"
    }
    
    init(column: Int, row: Int, color: BlockColor, orientation: Orientation) {
        self.color = color
        self.column = column
        self.row = row
        self.orientation = orientation
        
        initializeBlocks()
    }
    
    convenience init(column: Int, row: Int) {
        self.init(column: column, row: row, color: BlockColor.random(), orientation: Orientation.random())
    }
    
    final func initializeBlocks() {
        if let blockRowColumnTranslations = blockRowColumnPositions[orientation] {
            for i in 0..<blockRowColumnTranslations.count {
                let blockRow = row + blockRowColumnTranslations[i].rowDiff
                let blockColumn = column + blockRowColumnTranslations[i].columnDiff
                let newBlock = Block(column: blockColumn, row: blockRow, color: color)
                blocks.append(newBlock)
            }
        }
    }
}

func ==(lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
