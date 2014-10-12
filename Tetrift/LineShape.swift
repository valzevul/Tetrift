//
//  LineShape.swift
//  Tetrift
//
//  Created by Vadim Drobinin on 12/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

class LineShape:Shape {
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [(0, 0), (0, 1), (0, 2), (0, 3)],
            Orientation.Ninety:     [(-1,0), (0, 0), (1, 0), (2, 0)],
            Orientation.OneEighty:  [(0, 0), (0, 1), (0, 2), (0, 3)],
            Orientation.TwoSeventy: [(-1,0), (0, 0), (1, 0), (2, 0)]
            ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[ForthBlockIdx]],
            Orientation.Ninety:     blocks,
            Orientation.OneEighty:  [blocks[ForthBlockIdx]],
            Orientation.TwoSeventy: blocks
            ]
    }
}
