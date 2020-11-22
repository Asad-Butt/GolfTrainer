//
//  AccuracyViewController.swift
//  GolfTrainer
//
//  Created by Asad on 20/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit

class AccuracyViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    @IBOutlet weak var clubsTextField: UITextField!
    var clubsData:[String] = [String]()
    @IBOutlet var buttons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        clubsData = ["5 iron", "6 iron", "7 iron", "8 iron"]

        // Do any additional setup after loading the view.
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        buttons.forEach { (button) in
            button.layer.borderWidth = 0
        }
        buttons[sender.tag].layer.borderWidth = 3
        buttons[sender.tag].layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }

     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return clubsData.count
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clubsData[row]
    }

    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            clubsTextField.text = clubsData[row]
            self.view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
            currentTextField.inputView = pickerView
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
