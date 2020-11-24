//
//  AccuracyViewController.swift
//  GolfTrainer
//
//  Created by Asad on 20/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AccuracyViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    let childRef = Database.database().reference(withPath: "App/Category/")
    var shotsData: [ShotsResult] = [ShotsResult]()
    var shotPlace: Int?
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    @IBOutlet weak var clubsTextField: UITextField!
    var clubsData:[String] = [String]()
    var selectedClub: String = ""

    @IBOutlet var buttons: [UIButton]!


    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      FetchClubs()
            }
    func FetchClubs() {
           childRef.observe(DataEventType.value, with: {(snapshot) in
               if snapshot.childrenCount > 0 {
                   self.clubsData.removeAll()
                   for shot in snapshot.children.allObjects as! [DataSnapshot]{
                       let shotsObject = shot.value as? [String: AnyObject]
                       let club = shotsObject?["club"]
                        let Shots = shotsObject?["Shots"]
                        let Accurate = shotsObject?["Accurate"]
                        let Left = shotsObject?["Left"]
                        let ShortLeft = shotsObject?["ShortLeft"]
                        let ShortAccurate = shotsObject?["ShortAccurate"]
                        let Right = shotsObject?["Right"]
                        let ShortRight = shotsObject?["ShortRight"]
                        let shotData = ShotsResult(club: club as! String,Shots: Shots as! Int,Accurate: Accurate as! Int, Left:Left as! Int, ShortLeft: ShortLeft as! Int, ShortAccurate: ShortAccurate as! Int, Right: Right as! Int, ShortRight: ShortRight as! Int)
                    self.shotsData.append(shotData)
                    let clubData = String(club as! String)
                    self.clubsData.append(clubData)
                }
                if self.clubsData[0] != nil{
                                  self.clubsTextField.text = self.clubsData[0]
                              }else{
                                  self.clubsTextField.text = ""
                              }
               }
           })
       }
    @IBAction func buttonPressed(_ sender: UIButton) {
        buttons.forEach { (button) in
            button.layer.borderWidth = 0
        }
        buttons[sender.tag].layer.borderWidth = 3
        buttons[sender.tag].layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        shotTaken(shot: sender.tag)
    }
    func shotTaken(shot: Int) {
        shotPlace = shot
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
           saveDirection(tag: sender.tag)
   }
    func saveDirection(tag: Int) {
    shotsData.map { (shots) in
           if shots.club == selectedClub{
               if shotPlace != nil{
                   if shotPlace == 0{
                       if shots.Shots<=10{
               let itemData = [
                   "Accurate":shots.Accurate+1,
                   "Left":shots.Left,
                   "ShortLeft":shots.ShortLeft,
                   "ShortAccurate":shots.ShortAccurate,
                   "Right":shots.Right,
                   "ShortRight":shots.ShortRight,
                   "Shots":shots.Shots+1,
                   "club":shots.club] as [String : Any]
               childRef.child(shots.club).setValue(itemData)
                        if tag == 2{
               IntroductionViewController.alert(message: "You have Saved Your Direction against Club",move: nil)
                        }else{
                            moveNext()
                        }
           }else{
               IntroductionViewController.alert(message: "You have Already Played your 10 shots against this club",move: nil)
           }
      }
               else if shotPlace == 1{
           if shots.Shots<=10{
               let itemData = [
                   "Accurate":shots.Accurate,
                   "Left":shots.Left,
                   "ShortLeft":shots.ShortLeft,
                   "ShortAccurate":shots.ShortAccurate + 1,
                   "Right":shots.Right,
                   "ShortRight":shots.ShortRight,
                   "Shots":shots.Shots+1,
                   "club":shots.club] as [String : Any]
               childRef.child(shots.club).setValue(itemData)
            if tag == 2{
         IntroductionViewController.alert(message: "You have Saved Your Direction against Club",move: nil)
                  }else{
                      moveNext()
                  }
           }else{
               IntroductionViewController.alert(message: "You have Already Played your 10 shots against this club",move: nil)
                       }
                   }
               else if shotPlace == 2{
                       if shots.Shots<=10 {
               let itemData = [
                   "Accurate":shots.Accurate,
                   "Left":shots.Left+1,
                   "ShortLeft":shots.ShortLeft,
                   "ShortAccurate":shots.ShortAccurate,
                   "Right":shots.Right,
                   "ShortRight":shots.ShortRight,
                   "Shots":shots.Shots+1,
                   "club":shots.club] as [String : Any]
               childRef.child(shots.club).setValue(itemData)
           if tag == 2{
            IntroductionViewController.alert(message: "You have Saved Your Direction against Club",move: nil)
                     }else{
                         moveNext()
                     }
           }else{
            IntroductionViewController.alert(message: "You have Already Played your 10 shots against this club",move: nil)
           }
       }
               else if shotPlace == 3{
               if shots.Shots<=10{
               let itemData = [
                   "Accurate":shots.Accurate,
                   "Left":shots.Left,
                   "ShortLeft":shots.ShortLeft + 1,
                   "ShortAccurate":shots.ShortAccurate,
                   "Right":shots.Right,
                   "ShortRight":shots.ShortRight,
                   "Shots":shots.Shots+1,
                   "club":shots.club] as [String : Any]
               childRef.child(shots.club).setValue(itemData)
                if tag == 2{
                 IntroductionViewController.alert(message: "You have Saved Your Direction against Club",move: nil)
                          }else{
                              moveNext()
                          }
           }else{
                IntroductionViewController.alert(message: "You have Already Played your 10 shots against this club",move: nil)
           }
       }
               else if shotPlace == 4{
                       if shots.Shots<=10{
               let itemData = [
                   "Accurate":shots.Accurate,
                   "Left":shots.Left,
                   "ShortLeft":shots.ShortLeft,
                   "ShortAccurate":shots.ShortAccurate,
                   "Right":shots.Right + 1,
                   "ShortRight":shots.ShortRight,
                   "Shots":shots.Shots+1,
                   "club":shots.club] as [String : Any]
               childRef.child(shots.club).setValue(itemData)
         if tag == 2{
        IntroductionViewController.alert(message: "You have Saved Your Direction against Club",move: nil)
                 }else{
                     moveNext()
                 }
       }else{
            IntroductionViewController.alert(message: "You have Already Played your 10 shots against this club",move: nil)
       }
       }
              else if shotPlace == 5{
               if shots.Shots<=10{
               let itemData = [
                   "Accurate":shots.Accurate,
                   "Left":shots.Left,
                   "ShortLeft":shots.ShortLeft,
                   "ShortAccurate":shots.ShortAccurate,
                   "Right":shots.Right,
                   "ShortRight":shots.ShortRight + 1,
                   "Shots":shots.Shots+1,
                   "club":shots.club] as [String : Any]
               childRef.child(shots.club).setValue(itemData)
                if tag == 2{
             IntroductionViewController.alert(message: "You have Saved Your Direction against Club",move: nil)
                      }else{
                          moveNext()
                      }
           }
       else{
            IntroductionViewController.alert(message: "You have Already Played your 10 shots against this club",move: nil)
       }
   }
}
           else{
               IntroductionViewController.alert(message: "Please Select the Direction!",move: nil)
      }
   }
}
    }
    
    func moveNext () {
        let alert = UIAlertController(title: "Note", message: "You have Saved Your Direction against Club", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
                           let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                           self.present(vc,animated: true)
                         }))
                    self.present(alert,animated: true)
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        saveDirection(tag: sender.tag)
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
        selectedClub = clubsData[row]
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
