//
//  CountDownPicker.swift
//  Countdown
//
//  Created by Bradley Yin on 7/24/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

protocol CountdownPickerDelegate: AnyObject {
    func countDownPickerDidSelect(duration: TimeInterval)
}

class CountDownPicker: UIPickerView {

    var duration: TimeInterval {
        // Convert from minutes + seconds to total seconds
        let minuteString = self.selectedRow(inComponent: 0)
        let secondString = self.selectedRow(inComponent: 2)
        
        let minutes = Int(minuteString)
        let seconds = Int(secondString)
        
        let totalSeconds = TimeInterval(minutes * 60 + seconds)
        return totalSeconds
    }
    
    lazy var countdownPickerData: [[String]] = {
        // Create string arrays using numbers wrapped in string values: ["0", "1", ... "60"]
        let minutes: [String] = Array(0...60).map { String($0) }
        let seconds: [String] = Array(0...59).map { String($0) }
        
        // "min" and "sec" are the unit labels
        let data: [[String]] = [minutes, ["min"], seconds, ["sec"]]
        return data
    }()
    
    weak var countdownDelegate: CountdownPickerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
        
        //set dafault duration to 1 min 30 sec
        
        selectRow(1, inComponent: 0,animated: false)
        selectRow(30, inComponent: 2, animated: false)
        countdownDelegate?.countDownPickerDidSelect(duration: duration)
    }

}

extension CountDownPicker: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countdownPickerData[component].count
    }
    
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return countdownPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countdownPickerData[component][row]
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countdownDelegate?.countDownPickerDidSelect(duration: duration)
    }
    
}
