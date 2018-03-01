//
//  ResultViewController.swift
//  PsykAkuten
//
//  Created by Linus Sens Ingels on 2017-12-13.
//  Copyright © 2017 Linus Sens Ingels. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var ResultImage: UIImageView!
    @IBOutlet weak var LargeText: UILabel!
    @IBOutlet weak var SmallerText: UITextView!
    @IBOutlet weak var tryagain: Roundbutton!
    
    
    @IBAction func backToMap(_ sender: Roundbutton) {
        self.performSegue(withIdentifier: "BackToMapSegue", sender: Roundbutton.self)
       // self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tryAgain(_ sender: Roundbutton) {
        self.performSegue(withIdentifier: "TryAgainSegue", sender: Roundbutton.self)
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2, delay: 0.5, options: .curveLinear, animations:  {
            self.ResultImage.transform = CGAffineTransform(scaleX: 10, y: 10)
            self.LargeText.transform = CGAffineTransform(scaleX: 2, y: 2)
            
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
        
        if(CaseGrade == "U"){
            ResultImage.image = #imageLiteral(resourceName: "QuizFail")
            LargeText.text = "Under all kritik"
            SmallerText.text = "Med dessa handlingar kommer patienten inte att klara sig. Du kan ha gett patienten men för livet, eller ännu värre, kostat patienten livet."
        }
        
        else if(CaseGrade == "3"){
            ResultImage.image = #imageLiteral(resourceName: "QuizWin")
            LargeText.text = "OK"
            SmallerText.text = "Du agerade delvis rätt i denna situation. Det finns en del saker du lär se över och tänka om på. Läs på mera om det du tyckte var svårt."
            tryagain.removeFromSuperview()
            
        }
        
        else if(CaseGrade == "4"){
            ResultImage.image = #imageLiteral(resourceName: "QuizWin")
            LargeText.text = "Bättre än OK"
            SmallerText.text = "Du agerade mestadels rätt i denna situation. Det finns en del saker du lär se över och tänka om på. Läs på mera om det du tyckte var svårt. "
             tryagain.removeFromSuperview()
        }
        
        else if(CaseGrade == "5"){
            ResultImage.image = #imageLiteral(resourceName: "QuizWin")
            LargeText.text = "Fantastiskt"
            SmallerText.text = "Du agerade helt rätt i situationen och tack vare dig kommer patienten förhoppningsvis leva ett normalt liv igen."
             tryagain.removeFromSuperview()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
