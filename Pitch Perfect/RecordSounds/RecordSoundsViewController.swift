//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Luiz Hammerli on 28/01/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import  AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder:AVAudioRecorder?
    let session = AVAudioSession.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func starRecording(_ sender: Any) {
        configureUI(true, stopButtonIsHidden: false, recordingLabelText: Strings.finishingRecordLabel)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = Strings.audioFileName
        let pathArray = [dirPath, recordingName]
        guard let filePath = URL(string: pathArray.joined(separator: "/")) else{return}
        
        try? session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        audioRecorder = try? AVAudioRecorder(url: filePath, settings: [:])
        
        audioRecorder?.delegate = self
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.prepareToRecord()
        audioRecorder?.record()
    }
    
    @IBAction func stopRecord(_ sender: Any) {
        audioRecorder?.stop()
        try? session.setActive(false)        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        configureUI(false, stopButtonIsHidden: true, recordingLabelText: Strings.recordingLabel)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        self.performSegue(withIdentifier: Strings.segueIdentifier, sender: self)
    }
    
    func configureUI(_ recordButtonIsHidden: Bool, stopButtonIsHidden: Bool, recordingLabelText: String){
        recordButton.isHidden = recordButtonIsHidden
        stopButton.isHidden = stopButtonIsHidden
        recordingLabel.text = recordingLabelText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Strings.segueIdentifier){
            let playSoundsViewController = segue.destination as! PlaySoundsViewController
            playSoundsViewController.audioFileURL = audioRecorder?.url
        }
    }
}
