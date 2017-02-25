//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Son Hoang on 2/23/17.
//  Copyright © 2017 SoHo Software. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
	
	var recordedAudioURL: URL!

	@IBOutlet weak var snailButton: UIButton!
	@IBOutlet weak var chipmunkButton: UIButton!
	@IBOutlet weak var rabbitButton: UIButton!
	@IBOutlet weak var vaderButton: UIButton!
	@IBOutlet weak var echoButton: UIButton!
	@IBOutlet weak var reverbButton: UIButton!
	@IBOutlet weak var stopButton: UIButton!
	
	var audioFile:AVAudioFile!
	var audioEngine:AVAudioEngine!
	var audioPlayerNode: AVAudioPlayerNode!
	var stopTimer: Timer!
	
	enum ButtonType: Int {
		case slow = 0, fast, chipmunk, vader, echo, reverb
	}
	
	@IBAction func playSoundForButton(_ sender: UIButton) {
		print("Play Sound Button Pressed")
		switch ButtonType(rawValue: sender.tag)! {
		case .slow:
			playSound(rate: 0.5)
		case .fast:
			playSound(rate: 1.5)
		case .chipmunk:
			playSound(pitch: 1000)
		case .reverb:
			playSound(reverb: true)
		case .vader:
			playSound(pitch: -1000)
		case .echo:
			playSound(echo: true)
		}
		stopButton.isEnabled = true
	}
	
	@IBAction func stopButtonPressed(_ sender: AnyObject) {
		print("Stop Audio Button Pressed")
		stopAudio()
		stopButton.isEnabled = false
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setupAudio()
		configureUI(.notPlaying)
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	


}
