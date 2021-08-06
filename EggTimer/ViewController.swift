import UIKit
import AVFoundation

class ViewController: UIViewController
{
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let boilTime = ["Soft": 2, "Medium": 3, "Hard": 5]
    
    var totalBoilTime = 0
    var timePassed = 0
    
    var timer = Timer()
    
    @IBAction func hardnessSelection(_ sender: UIButton)
    {
        let hardness = sender.currentTitle!
        titleLabel.text = sender.currentTitle!
        
        totalBoilTime = boilTime[hardness]!
        
        progressBar.progress = 0.0
        timePassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer()
    {
        if timePassed < totalBoilTime
        {
            timePassed += 1
            progressBar.progress = Float(timePassed)/Float(totalBoilTime)
            
        }
        else
        {
            timer.invalidate()
            titleLabel.text = "Eggs Done"
            playSound()
        }
    }
    
    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
