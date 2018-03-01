//
//  NurseAnimation.swift
//  PsykAkuten
//
//  Created by Louise Bergman on 2017-12-18.
//  Copyright © 2017 Linus Sens Ingels. All rights reserved.
//

import UIKit
import SpriteKit


class LoadingAnimation: SKScene {
    
    
    var LoadingFrames:[SKTexture]?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        self.backgroundColor = UIColor.white
      
        
        var frames:[SKTexture] = []
        let LoadingAtlas = SKTextureAtlas(named: "Loading")
        
        for index in 1 ... 40 {
            let textureName = "Load_\(index).png"
            let texture = LoadingAtlas.textureNamed(textureName)
            frames.append(texture)
        }
        
        self.LoadingFrames = frames
        
        let texture = self.LoadingFrames![0]
        let animation = SKSpriteNode(texture: texture)
        
        animation.size = CGSize(width: 430, height: 760)
        animation.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(animation)
        
        animation.run(SKAction.animate(with: self.LoadingFrames!, timePerFrame: 0.1, resize: false, restore: false))
        }
    
        
    }


