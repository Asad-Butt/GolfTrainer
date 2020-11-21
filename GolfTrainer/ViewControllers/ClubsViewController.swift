//
//  ClubsViewController.swift
//  GolfTrainer
//
//  Created by Asad on 21/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit

struct Item {
  var imageName: String
    var clubName: String
}

class ClubsViewController: UIViewController {

   
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
                   
                   return cell
            }
            
//            let keyboardCollectionViewWidthPerCentageOfMainView = 67.00
        
//        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//                cell.layer.cornerRadius = 30.0
//                cell.layer.masksToBounds = true
//                }
        //    private func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        // handle tap events
        //        print("You selected cell #\(indexPath.item)!")
        //    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         print("nbsdfnbuiw")
        
    }
}

    extension ViewController : UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return   CGSize(width: 100, height: 75)
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//                let minimumInteritemSpacingForSectionAt : CGFloat =  4.83
//                return self.view.frame.width/100 * minimumInteritemSpacingForSectionAt//40
//                return 20
                //                    let minimumInteritemSpacingForSectionAt : CGFloat = 9.66
                let minimumInteritemSpacingForSectionAt : CGFloat = 5.66//4.79499
                return self.view.frame.width/100 * minimumInteritemSpacingForSectionAt//40
            }
            
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            
                let minimumLineSpacingForSectionAt : CGFloat = 9.66
                return self.view.frame.height/100 * minimumLineSpacingForSectionAt//40
                
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
