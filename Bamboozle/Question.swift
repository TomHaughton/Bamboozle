import Foundation

class Question {
    var question: String?
    var answers = [String]()
    var correctAnswer: Int?
    
    init(question: String, answer1: String, answer2: String, answer3: String, answer4: String, correctAnswer: Int) {
        self.question = question
        self.answers.append(answer1)
        self.answers.append(answer2)
        self.answers.append(answer3)
        self.answers.append(answer4)
        self.correctAnswer = correctAnswer
    }
    
    init(){
    }
}