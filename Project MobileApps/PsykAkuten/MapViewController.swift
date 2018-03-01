//
//  MapViewController.swift
//  PsykAkuten
//
//  Created by Linus Sens Ingels on 2017-12-13.
//  Copyright © 2017 Linus Sens Ingels. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MapViewController: UIViewController {
    
    @IBOutlet weak var nurse: UIImageView!
    @IBOutlet weak var Start: UIButton!
    var passedCases:[Int] = []
    //@IBOutlet weak var level3: Roundbutton!
    @IBOutlet var levelButtons: [Roundbutton]!
    
    /* @IBOutlet weak var level5: Roundbutton!
     
     @IBOutlet weak var level1ButtonText: Roundbutton!
     @IBOutlet weak var level2ButtonText: Roundbutton!*/
    
    //För att spela upp CloseSound.m4a
    
    var OpenSound = AVAudioPlayer();
    
    var SelectedButton = 0;
    
    override func viewDidLoad() {
        
        UIView.animate(withDuration: 2, delay: 2, options: .curveLinear, animations:  {
            
            let StartX = self.Start.frame.origin.x
            let StartY = self.Start.frame.origin.y
            self.nurse.center.x = StartX
            self.nurse.center.y = StartY
            //self.nurse.center.y = NextLevelY
        }, completion: nil)
        
        super.viewDidLoad()
        getClearedLevel()
        
        //För att spela upp CloseSound.m4a
        do{
            OpenSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "OpenSound", ofType: "m4a")!))
            OpenSound.prepareToPlay()
        }
        catch{
            print(error)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showPopup(_ sender: Roundbutton)
    {
        let buttonCoordinatesX = sender.frame.origin.x
        let buttonCoordinatesY = sender.frame.origin.y
        
        let buttonTitle = sender.title(for: .normal)
        let Query = "SELECT CaseInfo FROM Cases WHERE CID = \(buttonTitle!)"
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations:  {
            let NextLevelY = buttonCoordinatesY
            let NextLevelX = buttonCoordinatesX
            
            self.nurse.center.y = NextLevelY
            self.nurse.center.x = NextLevelX
        }, completion: nil)
        do{
            for Caseinfo in try PsykakutenDatabase.prepare(Query)
            {
                CurrentCase = ("Fall: " + (Caseinfo[0]! as! String))
            }
        }catch{
            print(error)
        }
        CurrentLevel = "\(buttonTitle!)"
        CurrentCaseID = Int(buttonTitle!)!
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpID") as! PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        //För att spela upp CloseSound.m4a
        OpenSound.play()
    }
    
    func getClearedLevel()
    {
        var j:Int  = 0;
        let query = "SELECT DISTINCT UserResults.\"Case\" FROM UserResults WHERE UserResults.Username = '\(userInlogged)' AND NOT UserResults.Grade = 'U'"
        do{
            for Question in try PsykakutenDatabase.prepare(query)
            {
                
                passedCases += [Int(Question[0]! as! Int64)]
                print("Passedcases ", passedCases)
                print("level ",levelButtons[j].title(for: .normal)!)
                if(Int(levelButtons[j].title(for: .normal)!) == passedCases[j])
                {
                    levelButtons[j].backgroundColor = UIColor(red:0 , green: 0.8, blue: 0, alpha: 0.2)
                    j += 1
                }
                else
                {
                    continue
                }
            }
        }catch{
            print(error)
        }
    }
    
}
