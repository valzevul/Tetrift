//
//  GameViewController.swift
//  Tetrift
//
//  Created by Vadim Drobinin on 12/10/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, TetriftDelegate {

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
        tetrift.delegate = self
        tetrift.beginGame()
        
        // Present the scene
        skView.presentScene(scene)
        
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func didTick() {
        tetrift.letShapeFall()
    }
    
    func nextShape() {
        let newShapes = tetrift.newShape()
        if let fallingShape = newShapes.fallingShape {
            self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
            self.scene.movePreviewShape(fallingShape) {
                self.view.userInteractionEnabled = true
                self.scene.startTicking()
            }
        }
    }
    
    func gameDidBegin(swiftris: Tetrift) {
        // The following is false when restarting a new game
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(swiftris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftris: Tetrift) {
        view.userInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(swiftris: Tetrift) {
        
    }
    
    func gameShapeDidDrop(swiftris: Tetrift) {
        
    }
    
    func gameShapeDidLand(swiftris: Tetrift) {
        scene.stopTicking()
        nextShape()
    }
    
    func gameShapeDidMove(swiftris: Tetrift) {
        scene.redrawShape(swiftris.fallingShape!) {}
    }
}
