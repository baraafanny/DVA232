//
//  LoginViewController.swift
//  PsykAkuten
//
//  Created by Linus Sens Ingels on 2017-12-13.
//  Copyright © 2017 Linus Sens Ingels. All rights reserved.
//

import Foundation
import UIKit
import SQLite
// Totala poängen som plusas på för varje fråga.
var TotalScore:Int = 0
var CaseGrade = ""
var MaxScoreForCase:Int = 0

class QuizzViewController: UIViewController {
    

    @IBOutlet weak var AnswerOneButtonLabel: Roundbutton!
    @IBOutlet weak var AnswerTwoButtonLabel: Roundbutton!
    
    @IBOutlet weak var AnswerThreeButtonLabel: Roundbutton!
    @IBOutlet weak var AnswerFourButtonLabel: Roundbutton!
    
    @IBOutlet weak var TimerOnScreen: UILabel!
    var timer = Timer()
    var totalTime = 60
    
    @IBOutlet weak var QuestionTextfield: UITextView!
    //Håller koll på poäng för varje fråga
    var AnswerOnePoints:Int = 0
    var AnswerTwoPoints:Int = 0
    var AnswerThreePoints:Int = 0
    var AnswerFourPoints:Int = 0
    // Hur många frågor som ställts
    var QuestionCounter:Int = 0
    //Nuvarande frågan
    var CurrentQuestion:String = ""
    var QID:Int = 1
    var GatheredQids:[Int] = []
    var randomizedQid:Int = 0
    var aquiredID:Int = 0
    var GatherUserQids:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        //print(CurrentCaseID, QID ,"\n \n")
        randomizedQid = randomizeQID()
        getLevelData()
    }
    
    @IBAction func AnswerOneButton(_ sender: Any) {
        TotalScore += AnswerOnePoints
        insertCompletedQuestionIntoDB()
        randomizedQid = randomizeQID()
        QuizEnd()
        getLevelData()
    }
    
    @IBAction func AnswerTwoButton(_ sender: Any) {
        TotalScore += AnswerTwoPoints
        insertCompletedQuestionIntoDB()
        randomizedQid = randomizeQID()
        QuizEnd()
        getLevelData()
    }
    
    @IBAction func AnswerThreeButton(_ sender: Any) {
        TotalScore += AnswerThreePoints
        insertCompletedQuestionIntoDB()
        randomizedQid = randomizeQID()
        QuizEnd()
        getLevelData()
    }
    
    @IBAction func AnswerFourButton(_ sender: Any) {
        TotalScore += AnswerFourPoints
        insertCompletedQuestionIntoDB()
        randomizedQid = randomizeQID()
        QuizEnd()
        getLevelData()
    }
    
    func randomizeQID() -> Int{
        
       
        GatheredQids.removeAll()
        GatherUserQids.removeAll()
        let query = "SELECT DISTINCT CaseInformation.QID FROM CaseInformation WHERE CaseInformation.CID = \(CurrentCaseID)"
        
        let query1 = "SELECT DISTINCT UserCompletedQuestions.QID FROM UserCompletedQuestions WHERE UserCompletedQuestions.Username = '\(userInlogged)'"
        
        do{
            for userIDs in try PsykakutenDatabase.prepare(query1)
            {
                GatherUserQids += [Int(userIDs[0]! as! Int64)]
                print("UserQID: ", GatherUserQids)
            }
        }catch{
            print("Error: Something went wrong")
        }
        
        do{
            for Randomise in try PsykakutenDatabase.prepare(query)
            {
                if(GatherUserQids.contains(Int(Randomise[0]! as! Int64)))
                {
                    continue
                }
                else
                {
                    GatheredQids += [Int(Randomise[0]! as! Int64)]
                }
            }
        }catch{
            print("error: RandomizeQID")
        }
        
        let index = Int(arc4random_uniform(UInt32(GatheredQids.count)))
       
        QID = GatheredQids[index]
        
        print(GatheredQids[index])
        
        
        
        return QID
    }
    
    
    func getLevelData()
    {
        let query = " SELECT DISTINCT Questions.QID, Question, Difficulty, Answer,AnswerID, Points FROM CaseInformation JOIN Questions ON CaseInformation.QID = Questions.QID JOIN Answers ON Answers.QID = Questions.QID Where CaseInformation.CID = \(CurrentCaseID) AND Questions.QID = \(randomizedQid)"
        var i:Int = 0
        do{
            for Question in try PsykakutenDatabase.prepare(query) {
                if(i == 0)
                {
                    QuestionTextfield.text = "\(String(describing: Question[1]!)) " //Skriver ut aktiv fråga.
                    
                    AnswerOneButtonLabel.setTitle("\(String(describing: Question[3]!)) ", for: .normal)
                    
                    AnswerOnePoints = Int(Question[5]! as! Int64)
                }
                if(i == 1)
                {
                    AnswerTwoButtonLabel.setTitle("\(String(describing: Question[3]!)) ", for: .normal)
                    AnswerTwoPoints = Int(Question[5]! as! Int64)
                   
                }
                if(i == 2)
                {
                    AnswerThreeButtonLabel.setTitle("\(String(describing: Question[3]!)) ", for: .normal)
                    AnswerThreePoints = Int(Question[5]! as! Int64)
                }
                if(i == 3)
                {
                    AnswerFourButtonLabel.setTitle("\(String(describing: Question[3]!)) ", for: .normal)
                    AnswerFourPoints = Int(Question[5]! as! Int64)
                    break
                }
                i+=1
            }
            
       }catch{
        print("error:GetLevelData")
        }
        
        QuestionCounter += 1 //Håller koll på hur många frågor vi ställt
    }
    func insertCompletedQuestionIntoDB(){
        let UserCQ = Table("UserCompletedQuestions")
        let UN = Expression<String>("Username")
        let QID = Expression<Int>("QID")
        
       // let query = "INSERT INTO UserCompletedQuestions VALUES ('\(userInlogged) , '\(randomizedQid)' "
        do {
            try PsykakutenDatabase.run(UserCQ.insert(UN <- userInlogged, QID <- randomizedQid))
        }catch {
            print("insertion failed: \(error)")
        }
    }
    
    func QuizEnd()
    {
        if(totalTime == 0)
        {
            summarizeResult()
            performSegue(withIdentifier: "ResultSegue", sender: UIViewController.self)

        }
        
        if(QuestionCounter == 5)
        {
            summarizeResult()
            performSegue(withIdentifier: "ResultSegue", sender: UIViewController.self)
        }
    }
    func summarizeResult()
    {
        let ResultsTable = Table("UserResults")
        let Username = Expression<String?>("Username")
        let Case = Expression<Int>("Case")
        let Result = Expression<Int>("Result")
        let Grade = Expression<String?>("Grade")
    
        let query = "SELECT MaximumScore FROM CaseInformation WHERE CaseInformation.QID == \(self.randomizedQid)"
    
        do{
            for MaxScores in try PsykakutenDatabase.prepare(query) {
                MaxScoreForCase = Int(MaxScores[0]! as! Int64)
            }
        } catch{
            print(error)
        }
        getGrade(MaxScore: (Double(MaxScoreForCase)))
        //Sätt in resultat i databasen
        if(CaseGrade != "U")
        {
            let insert = ResultsTable.insert(Username <- userInlogged, Case <- CurrentCaseID, Result <- TotalScore, Grade <- CaseGrade)
            
            do{
                 try PsykakutenDatabase.run(insert)
            } catch{
                print(error)
            }
        }
        else
        {
            removeData()
        }
        
        //Tömmer data
        AnswerOnePoints = 0
        AnswerOneButtonLabel.setTitle("", for: .normal)
        AnswerTwoPoints = 0
        AnswerTwoButtonLabel.setTitle("", for: .normal)
        AnswerThreePoints = 0
        AnswerThreeButtonLabel.setTitle("", for: .normal)
        AnswerFourPoints = 0
        AnswerFourButtonLabel.setTitle("", for: .normal)
        
        performSegue(withIdentifier: "ResultSegue", sender: nil)
    }
    func getGrade(MaxScore: Double) {
        let HalfMaxscore:Double = MaxScore/2
        let SeventyProcentMaxScore:Double = MaxScore*0.7
        let NinetyProcentMaxScore:Double = MaxScore*0.9
        
        if((Double(TotalScore)) < HalfMaxscore)//Om man får mindre än halva
        {
            CaseGrade = "U"
            return
        }
        else if((Double(TotalScore)) >= HalfMaxscore && (Double(TotalScore)) < SeventyProcentMaxScore)//Om man får mer eller likamed halva men mindre än 70%
        {
            CaseGrade = "3"
            return
        }
        else if((Double(TotalScore)) >= SeventyProcentMaxScore && (Double(TotalScore)) < NinetyProcentMaxScore)//Om man får mer eller likamed 70% men mindre än 90%
        {
            CaseGrade = "4"
            return
        }
        else if((Double(TotalScore)) >= NinetyProcentMaxScore)//Om man får mer eller likamed 90%
        {
            CaseGrade = "5"
            return
        }
    }
    func removeData()
    {
        for Elements in 0..<GatherUserQids.count
        {
            let query = "DELETE FROM UserCompletedQuestions WHERE Username = '\(userInlogged)' AND QID=\(GatherUserQids[Elements])"
            do{
                try PsykakutenDatabase.run(query)
            } catch{
                print(error)
            }
        }
    }
    // Sköter allt med timern
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    @objc func updateTime() {
        TimerOnScreen.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
            if totalTime < 6 {
                TimerOnScreen.textColor = UIColor.red
            }
        }
        else {
            endTimer()
        }
    }
    func endTimer() {
        timer.invalidate()
        TotalScore += 0
        QuizEnd()
        
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        
        
        return String(format: "%02d", seconds)
    }
    // Ovanför är bara timer
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
