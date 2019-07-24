//
//  CountdownViewController.swift
//  Countdown
//
//  Created by Paul Solt on 5/8/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pickerView: CountDownPicker!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    private var countDown = Countdown()
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 6.0
        resetButton.layer.cornerRadius = 6.0
        
        pickerView.countdownDelegate = self
        countDown.delegate = self
        timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeLabel.font.pointSize, weight: .medium)
        countDown.duration = pickerView.duration
        updateViews()
    }
    
    private func updateViews(){
        switch countDown.state {
        case .started:
            timeLabel.text = string(from: countDown.timeRemaining)
        case .finished:
            timeLabel.text = string(from: 0)
        case .reset:
            timeLabel.text = string(from: countDown.duration)
        }
    
    }
    func string(from duration: TimeInterval) -> String{
        let date = Date(timeIntervalSinceReferenceDate: duration)
        return dateFormatter.string(from: date)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        countDown.start()
        updateViews()
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        countDown.reset()
        updateViews()
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "Timer Finished", message: "Your conuntdown is over.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            //cancel
        }))
        present(alert,animated: true)
    }
}
extension CountdownViewController : CountdownPickerDelegate{
    func countDownPickerDidSelect(duration: TimeInterval) {
        countDown.duration = duration
        updateViews()
    }
}

extension CountdownViewController : CountdownDelegate{
    func countdownDidUpdate(timeRemaining: TimeInterval) {
        updateViews()
    }
    
    func countdownDidFinish() {
        updateViews()
        showAlert()
        countDown.reset()
    }
    
    
}
