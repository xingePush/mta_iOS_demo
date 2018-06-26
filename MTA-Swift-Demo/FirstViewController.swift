//
//  FirstViewController.swift
//  MTA-Swift-Demo
//
//  Created by tyzual on 2018/6/20.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.title = NSLocalizedString("页面1", comment: "页面1")
		self.tabBarItem.image = UIImage(named: "first")
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		self.title = NSLocalizedString("页面1", comment: "页面1")
		self.tabBarItem.image = UIImage(named: "first")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@IBAction func clickNormalButton(_ sender: Any) {
		MTA.trackCustomKeyValueEvent("NormalEvent", props: ["para1":"value1"])
		
		UIAlertView(title: "Event", message: "普通事件", delegate: nil, cancelButtonTitle: "OK").show()
	}
	
	@IBAction func clickErrorButton(_ sender: Any) {
		MTA.trackError("I\'m an unexpected error")
		
		UIAlertView(title: "Event", message: "Error件", delegate: nil, cancelButtonTitle: "OK").show()
	}
	
	@IBAction func clickStartButton(_ sender: Any) {
		MTA.trackCustomKeyValueEventBegin("TimeEvent", props: nil)
		
		UIAlertView(title: "Event", message: "开始计时事件", delegate: nil, cancelButtonTitle: "OK").show()
	}
	
	@IBAction func clickEndButton(_ sender: Any) {
		MTA.trackCustomKeyValueEventEnd("TimeEvent", props: nil)
		
		UIAlertView(title: "Event", message: "结束计时事件", delegate: nil, cancelButtonTitle: "OK").show()
	}
}
