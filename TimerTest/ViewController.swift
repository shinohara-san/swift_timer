//
//  ViewController.swift
//  TimerTest
//
//  Created by Yuki Shinohara on 2020/06/01.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    var prevTimer:Double = 30
    
    private var timer = Timer()
    private var count = 10.0{
        didSet{
            timerLabel.text = String(count)
            if count < 0{
                count = 0
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        print(screenSize.width)
        title = "タイマー"
        timerLabel.text = String(count)
        startButton.layer.cornerRadius = 10
        stopButton.layer.cornerRadius = 10
        resetButton.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor(red: 245/255, green: 255/255, blue: 250/255, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        //画面閉じるときにタイマー止める
    }
    
    @IBAction func changeTimer(_ sender: Any) {
        //        print("add")
        
        let ac = UIAlertController(title: "Timerをセット", message: nil, preferredStyle: .alert)
        
        ac.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.placeholder = "Tap here"
        }
        
        let add = UIAlertAction(title: "追加", style: .default) { (void) in
            let textField = ac.textFields![0] as UITextField
            
            //ワンクッション
            if let text = textField.text{
                self.count = Double(text) ?? 10
                self.prevTimer = Double(text) ?? 10
                self.timer.invalidate()
            }
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        ac.addAction(add)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    @IBAction func startTimer(_ sender: Any) {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        if timer.isValid {
            timer.invalidate()
        }
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        timer.invalidate()
        count = prevTimer
        timerLabel.textColor = .black
        timerLabel.text = String(format: "%.1f", count)
    }
    
    @objc private func updateTimer() {
        if count > 0{
            count -= 0.1
            timerLabel.text = String(format: "%.1f", count)
        }
        
        if count == 0{
            timerLabel.textColor = .red
        }else{
            timerLabel.textColor = .black
        }
    }
    
}

