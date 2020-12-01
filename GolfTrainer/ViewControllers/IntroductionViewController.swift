//
//  IntroductionViewController.swift
//  GolfTrainer
//
//  Created by Asad on 23/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit
import FirebaseDatabase

class IntroductionViewController: UIViewController {
    let childRef = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
       checkData()
        // Do any additional setup after loading the view.
    }
    func checkData(){
           childRef.observe(DataEventType.value, with: {[weak self](snapshot) in
                         if snapshot.childrenCount > 0 {
             NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: "DataChecked")))
               }
           })
       }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                      self.present(vc,animated: true)
    }
    class func alert(message: String,move:String?){
        let alert = UIAlertController(title: "Note", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler:nil))
//        if let topController = UIApplication.shared.keyWindow?.rootViewController {
//            topController.present(alert,animated: true)}
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            // Dismissing an UIAlertController which is being displayed and setting the topController down one level
            if topController is UIAlertController {
                if let vc = topController.presentingViewController {
                    topController = vc
                    vc.dismiss(animated: true, completion: nil)
                }

            }

            // Now present the alert controller
            topController.present(alert, animated: true, completion: nil)
        }
    }
  
    
    /*let vc = self.storyboard?.instantiateViewController(withIdentifier: "VC") as! VC
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
