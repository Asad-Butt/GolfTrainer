//
//  GapTestViewController.swift
//  GolfTrainer
//
//  Created by Asad on 20/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit

class GapTestViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    @IBOutlet weak var clubsTextField: UITextField!
    @IBOutlet weak var yardsTextField: UITextField!
    var clubsData:[String] = [String]()
    var yardsData:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubsData = ["5 iron", "6 iron", "7 iron", "8 iron"]
        yardsData = ["50 yards","55 yards","60 yards","65 yards","70 yards","75 yards","80 yards","85 yards","90 yards","95 yards","100 yards","105 yards","110 yards","115 yards","120 yards","125 yards","130 yards","135 yards","140 yards","145 yards","150 yards","155 yards","160 yards","165 yards","170 yards","175 yards","180 yards","185 yards","190 yards","195 yards","200 yards","205 yards","210 yards","215 yards","220 yards","225 yards","230 yards","235 yards","240 yards","245 yards","250 yards"]

        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }

     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == clubsTextField{
            return clubsData.count
        }
        else if currentTextField == yardsTextField{
            return yardsData.count
        }
        else{
            return 0
        }
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           if currentTextField == clubsTextField{
                 return clubsData[row]
             }
             else if currentTextField == yardsTextField{
                 return yardsData[row]
             }
             else{
                 return ""
             }
    }

    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                if currentTextField == clubsTextField{
            clubsTextField.text = clubsData[row]

                    print("dksfmks\(clubsData[row])")
            self.view.endEditing(true)
        }
        else if currentTextField == yardsTextField{
                   yardsTextField.text = yardsData[row]
                   self.view.endEditing(true)
               }

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == clubsTextField {
            currentTextField.inputView = pickerView
        }
        else if currentTextField == yardsTextField {
            currentTextField.inputView = pickerView
        }
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
