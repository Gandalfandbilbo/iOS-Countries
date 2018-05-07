//
//  QuizViewController.swift
//  Countries
//
//  Created by SHAISHAV ILESH VALERA on 5/23/17.
//  Copyright © 2017 SHAISHAV ILESH VALERA. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController
{
    var typeString: String?
    
    let questionsMedium = ["Cairo is the Capital of which Country?",
                           "Zagreb is the Capital of which Country?",
                           "New Delhi is the Capital of which Country?",
                           "Cranberra is the Capital of Which Country?",
                           "Washington DC is the Capital of which Country?"]
    let answersMedium = [["Egypt", "Haiti", "Georgia"],
                         ["Croatia", "Costa Rica", "Argentina"],
                         ["India", "Georgia", "Cameroon"],
                         ["Australia","Cuba","Chile"],
                         ["United States of America","Jamaica","Ecuador"]]
    
    let questionsEasy = ["Estonia is in Which Continent?",
                           "Brazil is in Which Continent?",
                           "Kenya is in Which Continent?",
                           "Canada is in Which Continent?",
                           "India is in Which Continent?"]
    let answersEasy = [["Europe", "Australia", "Asia"],
                         ["South America", "North America", "Asia"],
                         ["Africa", "Australia", "Antartica"],
                         ["North America", "Europe", "Antartica"],
                         ["Asia", "Africa", "Europe"]]
    
    let questionsHard = ["Population of Austria is",
                           "Population of Gambia is",
                           "Population of Japan is",
                           "Population of Peru is",
                           "Population of Tunisia is"]
    let answersHard = [["8725931", "10114505", "92206005"],
                         ["1882450", "48759958", "9531712"],
                         ["126960000", "47251000", "5988000"],
                         ["31488700","2587564","5223256"],
                         ["11154400","1894194","14799859"]]
    
    var num: Int = 0
    
    @IBAction func easy(_ sender: Any)
    {
        num = 1
        rotateQuestion(questions: questionsEasy, answers: answersEasy)
        show()
        typeString = "Easy"
    }
    @IBAction func medium(_ sender: Any)
    {
        num = 2
        rotateQuestion(questions: questionsMedium, answers: answersMedium)
        show()
        typeString = "Medium"
    }
    @IBAction func hard(_ sender: Any)
    {
        num = 3
        rotateQuestion(questions: questionsHard, answers: answersHard)
        show()
        typeString = "Hard"
    }
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var tryButton: UIButton!
    
    
    @IBAction func tryagain(_ sender: Any)
    {
        pointsscored.isHidden = true
        self.start(sender : Any.self)
        tryButton.isHidden = true
        currentQuestion = 0
        quizpoints = 0
        clearcolor()
    }
    
    var currentQuestion = 0
    var answer:UInt32 = 0
    var quizpoints = 0
    @IBOutlet weak var start1: UIButton!
    @IBAction func start(_ sender: Any)
    {
        currentQuestion = 0
        start1.isHidden = true
        easyButton.isHidden = false
        hardButton.isHidden = false
        mediumButton.isHidden = false
        difficultyLabel.isHidden = false
    }
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var pointsscored: UILabel!
    
    @IBOutlet weak var question: UILabel!
    @IBAction func back(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func quizHistory(_ sender: Any)
    {
        performSegue(withIdentifier: "history", sender: Any.self)
    }
    @IBAction func answerButton(_ sender: AnyObject)
    {
        let tag1:Int = sender.tag
        if(sender.tag == Int(answer))
        {
            quizpoints += 1
            changeColorToGreen(tag: tag1)
        }
        else
        {
            changeColorToRed(tag: tag1)
        }
        if (currentQuestion != 5)
        {
            if(num == 1)
            {
                rotateQuestion(questions: questionsEasy, answers: answersEasy)
            }
            else if (num == 2)
            {
                rotateQuestion(questions: questionsMedium, answers: answersMedium)
            }
            else
            {
                rotateQuestion(questions: questionsHard, answers: answersHard)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {self.clearcolor()})
        }
        else
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.hide()
                self.start1.isHidden = true
                self.pointsscored.text = "Your Score: \(self.quizpoints)"
                self.pointsscored.isHidden = false
                self.tryButton.isHidden = false
            })
            insertPoints()
        }
    }
    func rotateQuestion(questions:[String], answers: [[String]])
    {
        question.text = questions[currentQuestion]
        
        answer = arc4random_uniform(3)+1
        
        var button:UIButton = UIButton()
        
        var x = 1
        
        for i in 1...3
        {
            button = view.viewWithTag(i) as! UIButton
            if(i == Int(answer))
            {
                button.setTitle(answers[currentQuestion][0], for: .normal)
            }
            else
            {
                button.setTitle(answers[currentQuestion][x], for: .normal)
                x = 2
            }
        }
        currentQuestion += 1
    }
    override func viewDidDisappear(_ animated: Bool)
    {
        quizpoints = 0
        pointsscored.isHidden = true
        currentQuestion = 0
        tryButton.isHidden = true
        hide()
    }
    override func viewDidLoad()
    {
        hide()
        tryButton.isHidden = true
        pointsscored.isHidden = true
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        _ = segue.destination as! QuizHistory
    }
    func hide()
    {
        question.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button1.isHidden = true
        start1.isHidden = false
        easyButton.isHidden = true
        mediumButton.isHidden = true
        hardButton.isHidden = true
        difficultyLabel.isHidden = true
    }
    func show()
    {
        question.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button1.isHidden = false
        start1.isHidden = true
        easyButton.isHidden = true
        mediumButton.isHidden = true
        hardButton.isHidden = true
        difficultyLabel.isHidden = true
    }
    func changeColorToRed(tag: Int)
    {
        if(tag == 1)
        {
            button1.backgroundColor = UIColor.red
        }
        else if (tag == 2)
        {
            button2.backgroundColor = UIColor.red
        }
        else
        {
            button3.backgroundColor = UIColor.red
        }
    }
    func changeColorToGreen(tag: Int)
    {
        if(tag == 1)
        {
            button1.backgroundColor = UIColor.green
        }
        else if (tag == 2)
        {
            button2.backgroundColor = UIColor.green
        }
        else
        {
            button3.backgroundColor = UIColor.green
        }
    }
    func clearcolor()
    {
        button1.backgroundColor = UIColor.clear
        button2.backgroundColor = UIColor.clear
        button3.backgroundColor = UIColor.clear
    }
    func insertPoints()
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let currentDate = formatter.string(from: date)
        let quiz = UserHistory(context: context)
        
        quiz.points = Int16(quizpoints)
        quiz.date = currentDate
        quiz.type = typeString
        
        appdelegate.saveContext()
    }

}
