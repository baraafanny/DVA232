//
//  LoadingScreen.swift
//  PsykAkuten
//
//  Created by Louise Bergman on 2017-12-29.
//  Copyright © 2017 Linus Sens Ingels. All rights reserved.
//

import UIKit
import SpriteKit


class LoadingScreen: UIViewController {

    
    @IBOutlet weak var sceneView: SKView!
   
    
    var scene:LoadingAnimation?
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            self.scene = LoadingAnimation(size: CGSize(width: self.sceneView.frame.size.width, height:
                self.sceneView.frame.size.height))
            self.sceneView.presentScene(self.scene)
        let when = DispatchTime.now() + 3.5 // change to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.performSegue(withIdentifier: "Loginscreen", sender: UIViewController.self)
        }
        
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
