//
//  SecondViewController.swift
//  MTA-Swift-Demo
//
//  Created by tyzual on 2018/6/20.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.title = NSLocalizedString("页面2", comment: "页面2")
		self.tabBarItem.image = UIImage(named: "second")
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		self.title = NSLocalizedString("页面2", comment: "页面2")
		self.tabBarItem.image = UIImage(named: "second")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@IBAction func duration(_ sender: Any) {
		MTA.trackCustomKeyValueEventDuration(10, withEventid: "Duration", props: nil)
		UIAlertView(title: "Event", message: "时长事件", delegate: nil, cancelButtonTitle: "OK").show()
	}
	
	@IBAction func clickExceptionButton(_ sender: Any) {
		let exception = NSException(name: NSExceptionName("DemoException"), reason: "NoReaseon", userInfo: nil)
		MTA.trackException(exception)
		
		UIAlertView(title: "Event", message: "生成Exception", delegate: nil, cancelButtonTitle: "OK").show()

	}
}
