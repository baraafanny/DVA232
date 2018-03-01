//
//  RegisterPopupViewController.swift
//  PsykAkuten
//
//  Created by Fanny Danielsson on 2017-12-20.
//  Copyright © 2017 Linus Sens Ingels. All rights reserved.
//

import UIKit
import SQLite
import AVFoundation

class RegisterPopupViewController: UIViewController {
    
    var CloseSound = AVAudioPlayer();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimate()
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        PopupBubbleBackround.backgroundColor = UIColor(white: 1, alpha: 0)
        
        StatusLabel.text = ""
        
        do{
            CloseSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "CloseSound", ofType: "m4a")!))
            CloseSound.prepareToPlay()
        }
        catch{
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var UsernameBox: UITextField!
    
    @IBOutlet weak var PasswordBox: UITextField!
    @IBOutlet weak var PopupBubbleBackround: UIView!
    
    @IBAction func RegisterButton(_ sender: Any) {
        RegisterCheck()
    }
    
    @IBAction func CloseButton(_ sender: Any) {
        CloseSound.play()
        self.removeAnimate()
    }
    func RegisterCheck()
    {
        if(UsernameBox.text == "" && PasswordBox.text == "")
        {
            StatusLabel.text = "Skriv något i Användarnamnfältet och Lösenordsfältet!"
            return
        }
        
        if(UsernameBox.text == "")
        {
            StatusLabel.text = "Skriv något i Användarnamnfältet!"
            return
        }
        if(PasswordBox.text == "")
        {
            StatusLabel.text = "Skriv något i Lösenordsfältet!"
            return
        }
        
        let users = Table("Users")
        let username = Expression<String?>("Username")
        let password = Expression<String?>("Password")
        
        do{
            for user in try PsykakutenDatabase.prepare(users){
                if(UsernameBox.text == user[username])
                {
                    StatusLabel.textColor = UIColor.red
                    StatusLabel.text = "Upptaget användarnamn"
                    return
                }
            }
        }catch {
            print("error")
        }
        
        do{
            let insert = users.insert(username <- UsernameBox.text, password <- PasswordBox.text)
            try PsykakutenDatabase.run(insert)
        }catch {
            print(error)
            print("No Values where inserted into Database")
        }
        StatusLabel.textColor = UIColor.green
        StatusLabel.text = "Success!"
        removeAnimate()
    }
    func showAnimate()
    {
        //För att få bubblan att dyka upp på ett snyggare sätt
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

}
