//
//  ClubsViewController.swift
//  GolfTrainer
//
//  Created by Asad on 21/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit
import FirebaseDatabase
struct Item {
  var imageName: String
    var clubName: String,
    isSelected: Bool = false
}

class ClubsViewController: UIViewController {
    
    let childRef = Database.database().reference(withPath: "App/Category/")
    var isSave: Bool = false
    var dictionarySelectedIndexPath: [IndexPath: Bool] = [:]
    var selectedClubs: [String] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [Item] = [Item(imageName: "1",clubName:"Wedge"),
    Item(imageName: "2",clubName:"Gap Wedge"),
    Item(imageName: "3",clubName:"Pitching Wedge"),
    Item(imageName: "4",clubName:"9 Iron"),
    Item(imageName: "5",clubName:"8 Iron"),
    Item(imageName: "6",clubName:"7 Iron"),
    Item(imageName: "7",clubName:"6 Iron"),
    Item(imageName: "8",clubName:"5 Iron"),
    Item(imageName: "9",clubName:"4 Iron"),
    Item(imageName: "10",clubName:"3 Iron"),
    Item(imageName: "11",clubName:"Other Iron"),
    Item(imageName: "12",clubName:"Other Wood"),
    Item(imageName: "13",clubName:"Hybrid"),
    Item(imageName: "14",clubName:"5 Wood"),
    Item(imageName: "15",clubName:"3 Wood"),
    Item(imageName: "16",clubName:"Driver"),
    Item(imageName: "17",clubName:"Putter")]
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonTaped(_ sender: UIButton) {
        if isSave{
            let alert = UIAlertController(title: "Clubs", message: "Already saved!.", preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                           self.present(alert,animated:true)
        }
        var selected: [String] = []
        items.map { (item) in
            if item.isSelected == true{
                selectedClubs.append(item.clubName)
                print("items\(item.clubName)")
                let itemData = [
                    "Accurate":0,
                    "Left":0,
                    "ShortLeft":0,
                    "ShortAccurate":0,
                    "Right":0,
                    "ShortRight":0,
                    "Shots":0,
                    "club":item.clubName] as [String : Any]
                childRef.child(item.clubName).setValue(itemData)
                let alert = UIAlertController(title: "Clubs", message: "Clubs saved!.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {  action in
                    self.isSave = true
                }))
                self.present(alert,animated:true)
            }
        }
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if isSave{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GapTestViewController") as! GapTestViewController
            self.present(vc,animated: true)
        }else{
       items.map { (item) in
            if item.isSelected == true{
                print("items\(item.clubName)")
                let itemData = [
                    "Accurate":0,
                    "Left":0,
                    "ShortLeft":0,
                    "ShortAccurate":0,
                    "Right":0,
                    "ShortRight":0,
                    "Shots":0,
                    "club":item.clubName] as [String : Any]
                childRef.child(item.clubName).setValue(itemData)
                let alert = UIAlertController(title: "Note", message: "Club saved!", preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "GapTestViewController") as! GapTestViewController
                       self.present(vc,animated: true)
                     }))
                self.present(alert,animated: true)
            }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.isUserInteractionEnabled = true
        collectionView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    }

    extension ClubsViewController : UICollectionViewDelegate,UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return items.count
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClubsCVC", for: indexPath) as! ClubsCVC
                   cell.clubsImage.image = UIImage(named: items[indexPath.item].imageName)
            cell.clubName.text = items[indexPath.item].clubName
                   return cell
            }
            

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let index = indexPath.row
            let item = collectionView.cellForItem(at: indexPath) as! ClubsCVC
            items[index].isSelected = !items[index].isSelected
            item.checkImage.isHidden =  !items[index].isSelected
    }
}

    extension ClubsViewController : UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return   CGSize(width: UIScreen.main.bounds.width/9, height: UIScreen.main.bounds.height/6)
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 5
            }
            
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 8
                
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
