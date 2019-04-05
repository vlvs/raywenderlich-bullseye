import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var hitValue = 0
    var targetValue = 0
    var roundNumber = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    @IBAction func hitButtonAlert() {
        let valueDifference = abs(targetValue - hitValue)
        var points = 50 - valueDifference
        if points < 0 {
            points = 0
        }
        let title: String
        var message: String
        message = "You scored \(points) points."
        if valueDifference == 0 {
            title = "Perfect!"
            message = "You scored 100 points!!!"
            points += 50
        } else if valueDifference < 5 {
            title = "You almost had it!"
            if valueDifference == 1 {
                points += 31
                message = "You scored 80 points!"
            }
        } else if valueDifference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        score += points
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        hitValue = Int(slider.value.rounded())
    }
    
    @IBAction func startNewGame() {
        score = 0
        roundNumber = 0
        startNewRound()
    }
    
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        slider.value = 50
        hitValue = Int(slider.value.rounded())
        roundNumber += 1
        updateLabels()
    }
    
    func updateLabels() {
        scoreLabel.text = String(score)
        roundLabel.text = String(roundNumber)
        targetLabel.text = String(targetValue)
    }
}
