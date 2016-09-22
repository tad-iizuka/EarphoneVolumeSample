//
//  ViewController.swift
//  EarphoneVolumeSample
//
//  Created by Tadashi on 2016/09/22.
//  Copyright © 2016 T@d. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

	var mpVolumeView : MPVolumeView? = nil

	override func viewDidLoad() {
		super.viewDidLoad()
		
		NotificationCenter.default.addObserver(self,
			selector: #selector(volumeChanged(notification:)),
			name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"),
			object: nil)

		self.mpVolumeView = MPVolumeView(frame: CGRect(x:-100.0, y:-100.0, width:10.0, height:10.0))
		self.view.addSubview(self.mpVolumeView!)

		do {
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
			try AVAudioSession.sharedInstance().setActive(true)
		} catch {
			print(String(format: "Error %@: %d",#file, #line))
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func volumeChanged(notification: NSNotification) {
		if let userInfo = notification.userInfo {
			if let volumeChangeType =
				userInfo["AVSystemController_AudioVolumeChangeReasonNotificationParameter"] as? String {
				if volumeChangeType == "ExplicitVolumeChange" {
					print(String(format: "%@", String(describing: NSDate())))
				}
			}
		}
	}
}

