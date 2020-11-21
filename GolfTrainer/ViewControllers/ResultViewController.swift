//
//  ResultViewController.swift
//  GolfTrainer
//
//  Created by Asad on 21/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        let nib = UINib(nibName: "ResultTableViewCell", bundle: nil)
               tableView.register(nib, forCellReuseIdentifier: "ResultTableViewCell")
              tableView.delegate = self
              tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
                 cell.clubsLabel.text = "5 Iron"//[indexPath.row]
                 cell.shotsLabel.text = "2"//discription[indexPath.row]
                 cell.accurateLabel.text = "0"//amount[indexPath.row]
                 cell.leftLabel.text = "0"
                 cell.shortLeftLabel.text = "0"
                 cell.accurateLabel.text = "1"
                 cell.shortAccurateLabel.text = "0"
                 cell.rightLabel.text = "0"
                 cell.rightLabel.text = "0"
                 return cell
    }
    

//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
//               cell.clubsLabel.text = "5 Iron"//[indexPath.row]
//               cell.shotsLabel.text = "2"//discription[indexPath.row]
//               cell.accurateLabel.text = "0"//amount[indexPath.row]
//               cell.leftLabel.text = "0"
//               cell.shortLeftLabel.text = "0"
//               cell.accurateLabel.text = "1"
//               cell.shortAccurateLabel.text = "0"
//               cell.rightLabel.text = "0"
//               cell.rightLabel.text = "0"
//               return cell
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//extension ResultViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 1000, height: UIScreen.main.bounds.height)
//    }
//}

