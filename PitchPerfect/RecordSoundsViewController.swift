//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Son Hoang on 2/9/17.
//  Copyright © 2017 SoHo Software. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

	var audioRecorder: AVAudioRecorder!
	
	@IBOutlet weak var recordButton: UIButton!
	@IBOutlet weak var recordingLabel: UILabel!
	@IBOutlet weak var stopButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		stopButton.isEnabled = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	@IBAction func recordAudio(_ sender: Any) {
		recordingLabel.text = "Recording in  Progress"
		stopButton.isEnabled = true
		recordButton.isEnabled = false
		
		let dirthPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
		let recordingName = "recordedVoice.wav"
		let pathArray = [dirthPath, recordingName]
		let filePath = URL(string: pathArray.joined(separator: "/"))
		print(filePath!)
		
		let session = AVAudioSession.sharedInstance()
		try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
		
		try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
		audioRecorder.delegate = self
		audioRecorder.isMeteringEnabled = true
		audioRecorder.prepareToRecord()
		audioRecorder.record()
	}

	@IBAction func stopRecording(_ sender: Any) {
		recordingLabel.text = "Tap to Record"
		stopButton.isEnabled = false
		recordButton.isEnabled = true
		
		audioRecorder.stop()
		let audioSession = AVAudioSession.sharedInstance()
		try! audioSession.setActive(false)
	}
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		if flag {
			performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
		} else {
			print("Recording not successful")
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "stopRecording" {
			let playSoundsVC = segue.destination as! PlaySoundsViewController
			let recordedAudioURL = sender as! URL
			playSoundsVC.recordedAudioURL = recordedAudioURL
		}
	}
}

