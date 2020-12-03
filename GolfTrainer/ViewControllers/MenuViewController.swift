//
//  MenuViewController.swift
//  GolfTrainer
//
//  Created by Asad on 23/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import FirebaseDatabase
import UIKit
class MenuViewController: UIViewController {
    let childRef = Database.database().reference()
    var result: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        DataChecked()
        NotificationCenter.default.addObserver(self, selector: #selector(DataChecked), name: NSNotification.Name(rawValue: "DataChecked"), object: nil)
        // NotificationCenter.default.addObserver(self, selector: #selector(updateOwedMoneyStatus), name: NSNotification.Name(rawValue: "updateHome"), object: nil)
        // Do any additional setup after loading the view.
    }

    @IBAction func selectClubsBotton(_: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ClubsViewController") as! ClubsViewController
        present(vc, animated: true)
    }

    @IBAction func GapTestButton(_: UIButton) {
        if result != nil {
            let vc = storyboard?.instantiateViewController(withIdentifier: "GapTestViewController") as! GapTestViewController
            present(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Note", message: "Please select the Club", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }

    @IBAction func AccuracyDrillButton(_: UIButton) {
        if result != nil {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AccuracyViewController") as! AccuracyViewController
            present(vc, animated: true)
        } else {
            IntroductionViewController.alert(message: "Please select the club", move: nil)
        }
    }

    @IBAction func ResultsButton(_: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        present(vc, animated: true)
    }

    @objc func DataChecked() {
        childRef.observe(DataEventType.value, with: { [weak self] snapshot in
            if snapshot.childrenCount > 0 {
                self?.result = true
            } else {
                self?.result = nil
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
