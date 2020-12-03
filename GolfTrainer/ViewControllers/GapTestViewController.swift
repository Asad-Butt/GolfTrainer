//
//  GapTestViewController.swift
//  GolfTrainer
//
//  Created by Asad on 20/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import FirebaseDatabase
import UIKit
var clubSelected: String = ""
class GapTestViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    @IBOutlet var clubsTextField: UITextField!
    @IBOutlet var yardsTextField: UITextField!
    var clubsData = [String]()
    var yardsData = [String]()
    let childRef = Database.database().reference(withPath: "App/Category/")
    var selectedClub: String = ""
    var selectedYard: String = ""
    var isSave: Bool = false
    @IBAction func saveButtonTapped(_: UIButton) {
        if isSave {
            IntroductionViewController.alert(message: "Already saved", move: nil)
        } else {
            isSave = true
            IntroductionViewController.alert(message: "\(selectedClub) club and \(selectedYard) has been selected and saved", move: nil)
        }
    }

    @IBAction func nextButtonTapped(_: UIButton) {
        if isSave {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AccuracyViewController") as! AccuracyViewController
            present(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Note", message: "\(selectedClub) club and \(selectedYard) has been selected and saved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { _ in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccuracyViewController") as! AccuracyViewController
                self.present(vc, animated: true)
            }))
            present(alert, animated: true)
        }
    }

    @IBAction func backButtonTapped(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        yardsData = ["50 yards", "55 yards", "60 yards", "65 yards", "70 yards", "75 yards", "80 yards", "85 yards", "90 yards", "95 yards", "100 yards", "105 yards", "110 yards", "115 yards", "120 yards", "125 yards", "130 yards", "135 yards", "140 yards", "145 yards", "150 yards", "155 yards", "160 yards", "165 yards", "170 yards", "175 yards", "180 yards", "185 yards", "190 yards", "195 yards", "200 yards", "205 yards", "210 yards", "215 yards", "220 yards", "225 yards", "230 yards", "235 yards", "240 yards", "245 yards", "250 yards"]
        FetchClubs()
        NotificationCenter.default.addObserver(self, selector: #selector(FetchClubs), name: NSNotification.Name(rawValue: "FetchClubs"), object: nil)
        // Do any additional setup after loading the view.
    }

    @objc func FetchClubs() {
        childRef.observe(DataEventType.value, with: { [weak self] snapshot in
            if snapshot.childrenCount > 0 {
                self?.clubsData.removeAll()
                for shot in snapshot.children.allObjects as! [DataSnapshot] {
                    let shotsObject = shot.value as? [String: AnyObject]
                    let club = shotsObject?["club"]
                    let clubData = String(club as! String)

                    self?.clubsData.append(clubData)
                    self?.clubsTextField.text = club as? String
                }
                self?.yardsTextField.text = "65 yards"
            }
        })
    }

    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        if currentTextField == clubsTextField {
            return clubsData.count
        } else if currentTextField == yardsTextField {
            return yardsData.count
        } else {
            return 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        if currentTextField == clubsTextField {
            return clubsData[row] 
        } else if currentTextField == yardsTextField {
            return yardsData[row]
        } else {
            return ""
        }
    }

    // Capture the picker view selection
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        if currentTextField == clubsTextField {
            isSave = false
            clubSelected = clubsData[row]
            selectedClub = clubsData[row]
            clubsTextField.text = clubsData[row]

            view.endEditing(true)
        } else if currentTextField == yardsTextField {
            selectedYard = yardsData[row]
            yardsTextField.text = yardsData[row]
            view.endEditing(true)
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.delegate = self
        pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == clubsTextField {
            currentTextField.inputView = pickerView
        } else if currentTextField == yardsTextField {
            currentTextField.inputView = pickerView
        }
    }
}
