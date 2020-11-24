//
//  GapTestViewController.swift
//  GolfTrainer
//
//  Created by Asad on 20/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GapTestViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    @IBOutlet weak var clubsTextField: UITextField!
    @IBOutlet weak var yardsTextField: UITextField!
    var clubsData: [String] = [String]()
    var yardsData:[String] = [String]()
    let childRef = Database.database().reference(withPath: "App/Category/")
    var selectedClub: String = ""
    var selectedYard: String = ""
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        IntroductionViewController.alert(message: "\(selectedClub) club and \(selectedYard) has been selected", move: nil) 
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Note", message: "You selection has been saved!", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccuracyViewController") as! AccuracyViewController
                    self.present(vc,animated: true)
                  }))
             self.present(alert,animated: true)
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        yardsData = ["50 yards","55 yards","60 yards","65 yards","70 yards","75 yards","80 yards","85 yards","90 yards","95 yards","100 yards","105 yards","110 yards","115 yards","120 yards","125 yards","130 yards","135 yards","140 yards","145 yards","150 yards","155 yards","160 yards","165 yards","170 yards","175 yards","180 yards","185 yards","190 yards","195 yards","200 yards","205 yards","210 yards","215 yards","220 yards","225 yards","230 yards","235 yards","240 yards","245 yards","250 yards"]
        FetchClubs()

        // Do any additional setup after loading the view.
    }
    func FetchClubs() {
           childRef.observe(DataEventType.value, with: {(snapshot) in
               if snapshot.childrenCount > 0 {
                   self.clubsData.removeAll()
                   for shot in snapshot.children.allObjects as! [DataSnapshot]{
                       let shotsObject = shot.value as? [String: AnyObject]
                       let club = shotsObject?["club"]
                    let clubData = String(club as! String)
                       
                       self.clubsData.append(clubData)
                   }
                if self.clubsData[0] != nil{
                    self.clubsTextField.text = self.clubsData[0]
                }else{
                    self.clubsTextField.text = ""
                }
                self.yardsTextField.text = "165 yards"
               }
           })
           
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
                    selectedClub = clubsData[row]
            clubsTextField.text = clubsData[row]

            self.view.endEditing(true)
        }
        else if currentTextField == yardsTextField{
                    selectedYard = yardsData[row]
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
