//
//  IntroductionViewController.swift
//  GolfTrainer
//
//  Created by Asad on 23/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import FirebaseDatabase
import UIKit

class IntroductionViewController: UIViewController {
    let childRef = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkData()
        // Do any additional setup after loading the view.
    }

    func checkData() {
        childRef.observe(DataEventType.value, with: { snapshot in
            if snapshot.childrenCount > 0 {
                NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: "DataChecked")))
            }
        })
    }

    @IBAction func nextButtonTapped(_: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        present(vc, animated: true)
    }

    class func alert(message: String, move _: String?) {
        let alert = UIAlertController(title: "Note", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        if var topController = UIApplication.shared.windows.first?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            if topController is UIAlertController {
                if let vc = topController.presentingViewController {
                    topController = vc
                    vc.dismiss(animated: true, completion: nil)
                }
            }
        }
    } 
}
