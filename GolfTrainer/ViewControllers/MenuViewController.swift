//
//  MenuViewController.swift
//  GolfTrainer
//
//  Created by Asad on 23/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit
import FirebaseDatabase
class MenuViewController: UIViewController {
    let childRef = Database.database().reference()
    var result : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        DataChecked()
          NotificationCenter.default.addObserver(self, selector: #selector(DataChecked), name: NSNotification.Name(rawValue: "DataChecked"), object: nil)
//NotificationCenter.default.addObserver(self, selector: #selector(updateOwedMoneyStatus), name: NSNotification.Name(rawValue: "updateHome"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectClubsBotton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClubsViewController") as! ClubsViewController
        self.present(vc,animated: true)
    }
    
    @IBAction func GapTestButton(_ sender: UIButton) {
        if result != nil{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GapTestViewController") as! GapTestViewController
                         self.present(vc,animated: true)
        }
        else{
            let alert = UIAlertController(title: "Note", message: "Please select the Club", preferredStyle: .alert)
                                   alert.addAction(UIAlertAction(title: "ok", style: .default, handler:nil))
                                  self.present(alert,animated: true)        }
    }
    @IBAction func AccuracyDrillButton(_ sender: UIButton) {
        if result != nil{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccuracyViewController") as! AccuracyViewController
                             self.present(vc,animated: true)
            }
            else{
                IntroductionViewController.alert(message: "Please select the club", move: nil)
            }
       
    }
    @IBAction func ResultsButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        self.present(vc,animated: true)
    }
   @objc func DataChecked(){
        childRef.observe(DataEventType.value, with: {(snapshot) in
                      if snapshot.childrenCount > 0 {
                        self.result = true
                      }else{
                        self.result = nil
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
