//
//  PopUpViewController.swift
//  PsykAkuten
//
//  Created by Fanny Danielsson on 2017-12-12.
//  Copyright © 2017 Linus Sens Ingels. All rights reserved.
//

import UIKit
import AVFoundation

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var StartButton: Roundbutton!
    @IBOutlet weak var CStringLabel: UILabel!
    @IBOutlet weak var CIDLabel: UILabel!
    @IBOutlet weak var LevelLabel: UILabel!
    //För att spela upp CloseSound.m4a
    var CloseSound = AVAudioPlayer();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideStartButton()
        //För att spela upp CloseSound.m4a
        do{
            CloseSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "CloseSound", ofType: "m4a")!))
            CloseSound.prepareToPlay()
            LevelLabel.text! = CurrentLevel
            CStringLabel.text! = CurrentCase
            CIDLabel.text = String(CurrentCaseID)
        
        }
        catch{
            print(error)
        }
        //Bakgrunden som bubblan är på
        ChatBubbleBackground.backgroundColor = UIColor(white: 1, alpha: 0)
        
        //Hela ViewController bakgrunden
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.showAnimate()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    
    @IBAction func StartButton(_ sender: Any) {
        
        performSegue(withIdentifier: "QuizzViewController", sender: UIButton.self())
        
    }
    @IBAction func closePopup(_ sender: UIButton) {
        //self.view.removeFromSuperview()
        //För att spela upp CloseSound.m4a
        CloseSound.play()
        self.removeAnimate()
        
    }
    @IBOutlet weak var ChatBubbleBackground: UIView!
    
    func showAnimate()
    {
        //För att få bubblan att dyka upp på ett snyggare sett
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
       
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool) in
            if(finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    func hideStartButton()
    {
        let query = "SELECT DISTINCT UserResults.\"Case\" FROM UserResults WHERE UserResults.Username = '\(userInlogged)' AND UserResults.\"Case\" = \(CurrentCaseID) AND NOT UserResults.Grade = 'U'"
        do{
            for Question in try PsykakutenDatabase.prepare(query)
            {
                print(Question[0] as! Int64)
                if((Question[0]! as! Int64) == CurrentCaseID)
                {
                    self.StartButton.isHidden = true
                }
            }
        }catch{
            print(error)
        }
    }

}
