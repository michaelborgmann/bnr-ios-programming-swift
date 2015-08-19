//
//  QuizViewController.swift
//  Quiz
//
//  Created by Michael Borgmann on 01/06/15.
//  Copyright (c) 2015 Michael Borgmann. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    var currentQuestionIndex = 0
    
    let questions = [
        "From what is cognac made?",
        "What is 7+7?",
        "What is the capital of Vermont?",
    ]
    
    let answers = [
        "Grapes",
        "14",
        "Montpelier",
    ]
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func showQuestionButtonPressed(sender: UIButton) {
        self.currentQuestionIndex++

        if (self.currentQuestionIndex == self.questions.count) {
            // Go back to the first question
            self.currentQuestionIndex = 0
        }
        
        var question = self.questions[self.currentQuestionIndex]
        self.questionLabel.text = question;
        self.answerLabel.text = "???"
    }
    
    @IBAction func showAnswerButtonPressed(sender: UIButton) {
        var answer = self.answers[self.currentQuestionIndex]
        self.answerLabel.text = answer
    }
    
}
