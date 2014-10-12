//
//  GameViewController.swift
//  Tetrift
//
//  Created by Vadim Drobinin on 12/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene: GameScene!
    var tetrift: Tetrift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick
        
        tetrift = Tetrift()
        tetrift.beginGame()
        
        // Present the scene
        skView.presentScene(scene)
        
        scene.addPreviewShapeToScene(tetrift.nextShape!) {
            self.tetrift.nextShape?.moveTo(StartingColumn, row: StartingRow)
            self.scene.movePreviewShape(self.tetrift.nextShape!) {
                let nextShapes = self.tetrift.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(nextShapes.nextShape!) {}
            }
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func didTick() {
        tetrift.fallingShape?.lowerShapeByOneRow()
        scene.redrawShape(tetrift.fallingShape!, completion: {})
    }
}
