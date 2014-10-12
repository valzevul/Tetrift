//
//  SquareShape.swift
//  Tetrift
//
//  Created by Vadim Drobinin on 12/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

class SquareShape: Shape {
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.OneEighty: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.Ninety: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.TwoSeventy: [(0, 0), (1, 0), (0, 1), (1, 1)]
            ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero: [blocks[ThirdBlockIdx], blocks[ForthBlockIdx]],
            Orientation.OneEighty: [blocks[ThirdBlockIdx], blocks[ForthBlockIdx]],
            Orientation.Ninety: [blocks[ThirdBlockIdx], blocks[ForthBlockIdx]],
            Orientation.TwoSeventy: [blocks[ThirdBlockIdx], blocks[ForthBlockIdx]]
            ]
    }
}
