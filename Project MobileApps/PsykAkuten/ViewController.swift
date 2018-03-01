//
//  ViewController.swift
//  PsykAkuten
//
//  Created by Linus Snorre Sens Ingels on 2017-12-11.
//  Copyright © 2017 Linus Snorre Sens Ingels. All rights reserved.
//

import UIKit
import SQLite
import AVFoundation


var userInlogged:String = ""
//Skriv in Databasfilvägen här nedanför
var PsykakutenDatabase = try! Connection("/Users/fannydanielsson/Downloads/PsykakutenDatabas-7.sqlite")
//var PsykakutenDatabase = try! Connection("/Users/erikawejlander/Documents/Projektet/PsykakutenDatabas.sqlite")
//var PsykakutenDatabase = try! Connection("/Users/linussensingels/Desktop/PsykAkuten/PsykakutenDatabas.sqlite")
//var PsykakutenDatabase = try! Connection("/Users/LouiseGris/Desktop/psykakuten/PsykakutenDatabas.sqlite")

var CurrentLevel:String = ""
var CurrentCaseID:Int = 0
var CurrentCase:String = ""

class ViewController: UIViewController {

    var OpenSound = AVAudioPlayer();
    
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var UsernameBox: UITextField!
    
    @IBOutlet weak var PasswordBox: UITextField!
    
    @IBAction func Login(_ sender: UIButton) {
        LoginCheck()
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterPopup") as! RegisterPopupViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        //För att spela upp CloseSound.m4a
        OpenSound.play()
        
    }
    func LoginCheck()
    {
        let users = Table("Users")
        let username = Expression<String?>("Username")
        let password = Expression<String?>("Password")
       
        do{
            for user in try PsykakutenDatabase.prepare(users){
                if(UsernameBox.text == user[username] && PasswordBox.text == user[password])
                {
                    userInlogged = String(user[username]!)
                    StatusLabel.text = "Success!"
                    StatusLabel.textColor = UIColor.green
                    performSegue(withIdentifier: "LoginToMap", sender: UIButton.self())
                    return
                }
                    StatusLabel.text = "Fel användarnamn eller lösenord."
                    StatusLabel.textColor = UIColor.red
            }
        }catch {
            print("error")
        }
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
           // LoginCheck()
        do{
            OpenSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "OpenSound", ofType: "m4a")!))
            OpenSound.prepareToPlay()
        }
        catch{
            print(error)
        }
    }
    
    //Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UsernameBox.resignFirstResponder()
        PasswordBox.resignFirstResponder()
        
        return true
        
        
    }
}
