import SpriteKit
import UIKit

class GameScene: SKScene {
    var questionNum: Int
    var rightAnswer: SKLabelNode!
    var backCol: UIColor
    
    var questions = [Question]()
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init (coder: has not been implemeneted")
    }
    
    init(size: CGSize, backCol: UIColor, questionNum: Int) {
        self.backCol = backCol
        self.questionNum = questionNum
        super.init(size: size)
    }
    
    override func didMoveToView(view: SKView) {
        setupQuestions()
        backgroundColor = backCol
        if questionNum < questions.count {
            let question = SKLabelNode(text: questions[questionNum].question)
            question.fontName = "Menlo"
            question.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - 30)
            
            let answer1 = SKLabelNode(text: questions[questionNum].answers[0])
            answer1.fontName = "Menlo"
            answer1.fontColor = SKColor.redColor()
            answer1.position = CGPointMake(CGRectGetMidX(frame) - 90, CGRectGetMidY(frame) - 70)
            
            let answer2 = SKLabelNode(text: questions[questionNum].answers[1])
            answer2.fontName = "Menlo"
            answer2.fontColor = SKColor.greenColor()
            answer2.position = CGPointMake(CGRectGetMidX(frame) + 90, CGRectGetMidY(frame) - 70)
            
            let answer3 = SKLabelNode(text: questions[questionNum].answers[2])
            answer3.fontName = "Menlo"
            answer3.fontColor = SKColor.yellowColor()
            answer3.position = CGPointMake(CGRectGetMidX(frame) - 90, CGRectGetMidY(frame) - 140)
            
            let answer4 = SKLabelNode(text: questions[questionNum].answers[3])
            answer4.fontName = "Menlo"
            answer4.fontColor = SKColor.blueColor()
            answer4.position = CGPointMake(CGRectGetMidX(frame) + 90, CGRectGetMidY(frame) - 140)
            
            switch(questions[questionNum].correctAnswer){
            case 1?:
                rightAnswer = answer1
                break
            case 2?:
                rightAnswer = answer2
                break
            case 3?:
                rightAnswer = answer3
                break
            case 4?:
                rightAnswer = answer4
                break
            default: break
            }
            
            addChild(question)
            addChild(answer1)
            addChild(answer2)
            addChild(answer3)
            addChild(answer4)
        }
        else {
            let question = SKLabelNode(text: "You Win!")
            question.fontName = "Menlo"
            question.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - 30)
            addChild(question)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        let touchLocation = touch.locationInNode(self)
        
        if rightAnswer.containsPoint(touchLocation){
            nextScene()
        }
        else{
            backgroundColor = UIColor.redColor()
            let delay = 2 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.backgroundColor = UIColor.blackColor()
            }
        }
    }
    
    func nextScene(){
        let nextScene: GameScene
        if backgroundColor == UIColor.blackColor(){
            nextScene = GameScene(size: size, backCol: UIColor.blueColor(), questionNum: questionNum + 1)
        }
        else {
            nextScene = GameScene(size: size, backCol: UIColor.blackColor(), questionNum: questionNum + 1)
        }
        
        let fade = SKTransition.doorsCloseHorizontalWithDuration(2)
        view?.presentScene(nextScene, transition: fade)
    }
    
    func setupQuestions(){
        var questionArray: NSArray?
        if let path = NSBundle.mainBundle().pathForResource("Questions", ofType: "plist") {
            questionArray = NSArray(contentsOfFile: path)
        }
        if let qArray = questionArray {
            for qDict in qArray{
                let q = Question()
                for (key, value) in qDict as! NSDictionary{
                    switch(key as! String){
                        case "correctAnswer":
                        q.correctAnswer = value as? Int
                        break
                    case "question":
                        q.question = value as? String
                        break
                    case "answers":
                        q.answers = value as! [String]
                        break
                    default: break
                    }
//                    print("\(key) -> \(value)")
                }
                questions.append(q)
            }
        }
//        questions.append(Question(question: "Who won WW2", answer1: "Britain", answer2: "Germany", answer3: "Uganda", answer4: "Australia", correctAnswer: 1))
//        questions.append(Question(question: "Answer is 2", answer1: "1", answer2: "2", answer3: "3", answer4: "4", correctAnswer: 2))
//        questions.append(Question(question: "Answer is 3", answer1: "1", answer2: "2", answer3: "3", answer4: "4", correctAnswer: 3))
//        questions.append(Question(question: "Answer is 4", answer1: "1", answer2: "2", answer3: "3", answer4: "4", correctAnswer: 4))
        
    }
}
