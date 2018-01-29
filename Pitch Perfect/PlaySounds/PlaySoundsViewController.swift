//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Luiz Hammerli on 28/01/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import  AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    var audioFileURL: URL?
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(.notPlaying)
        setupAudio()
        setUpViews()
    }
    
    func setUpViews(){
        snailButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        vaderButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        pauseButton.imageView?.contentMode = .scaleAspectFit
    }
    @IBAction func goToRecordSoundsViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        guard let selectedTag = ButtonType(rawValue: sender.tag) else {return}
        switch (selectedTag) {
            
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func pauseAudio(_ sender: Any) {
        stopAudio()
    }
}


