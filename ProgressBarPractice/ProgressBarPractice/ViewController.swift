//
//  ViewController.swift
//  ProgressBarPractice
//
//  Created by Chae_Haram on 2022/05/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    var time: Float = 1.0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIprogressView()
    }
    
    @IBAction func downloadButton(_ sender: UIButton) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        timer.invalidate()
    }
    
    func UIprogressView() {
        progressView.progressViewStyle = .default
        progressView.progressTintColor = .systemBlue
        progressView.trackTintColor = .lightGray
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 8
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 8
        progressView.subviews[1].clipsToBounds = true
        progressView.setProgress(time, animated: true)
    }
    
    @objc func setProgress() {
        time -= 0.001
        progressView.setProgress(time, animated: true)
        if time >= 1.0 { timer.invalidate() }
    }
}

