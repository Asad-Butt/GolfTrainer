//
//  ResultViewController.swift
//  GolfTrainer
//
//  Created by Asad on 21/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct ShotsResult {
    var club: String = ""
    var Shots: Int = 0
    var Accurate: Int = 0
    var Left: Int = 0
    var ShortLeft: Int = 0
    var ShortAccurate: Int = 0
    var Right: Int = 0
    var ShortRight: Int = 0
}

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var shotsData: [ShotsResult] = [ShotsResult]()
    let childRef = Database.database().reference(withPath: "App/Category/")
    var data: [String] = [String]()
    @IBOutlet weak var tableView: UITableView!
    var empty:Int?
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FetchData()
      
        let nib = UINib(nibName: "ResultTableViewCell", bundle: nil)
               tableView.register(nib, forCellReuseIdentifier: "ResultTableViewCell")
              tableView.delegate = self
              tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    func FetchData() {
       
 self.startIndicatingActivity()
        childRef.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                self.shotsData.removeAll()
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
                    self.empty = self.shotsData.count
                }
                self.stopIndicatingActivity()
                self.tableView.reloadData()
            }else{
                self.stopIndicatingActivity()
             let alert = UIAlertController(title: "Note", message: "No record found!", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
                     let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                     
                     self.present(vc,animated: true)
                   }))
                self.present(alert,animated: true)
            }
        })
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shotsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
        let shot: ShotsResult = shotsData[indexPath.row]
        
        cell.clubsLabel.text = "\(shot.club)"//[indexPath.row]
                 cell.shotsLabel.text = "\(shot.Shots)"//discription[indexPath.row]
                 cell.accurateLabel.text = "\(shot.Accurate)"//amount[indexPath.row]
        cell.leftLabel.text = "\(String(describing: shot.Left))"
        cell.shortLeftLabel.text = "\(String(describing: shot.ShortLeft))"
                 cell.shortAccurateLabel.text = "\(shot.ShortAccurate)"
                 cell.rightLabel.text = "\(shot.Right)"
                 cell.shortRightLabel.text = "\(shot.ShortRight)"
        cell.deleteResultButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        cell.deleteResultButton.tag = indexPath.row
                 return cell
    }
    @objc func deleteButtonTapped(sender : UIButton!) {
        print("sender\(sender.tag)")
        let shot: ShotsResult = shotsData[sender.tag]
        let id:String = shot.club
        empty = shotsData.count - 1
        childRef.child(id).setValue(nil)
        let alert = UIAlertController(title: "Note", message: "\(id) club has been deleted", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
             self.tableView.reloadData()
            if self.empty == 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            self.present(vc,animated: true)
            }
         }))
        self.present(alert,animated: true)
 }
}
extension ResultViewController {
    public final class ObjectAssociation<T: AnyObject> {

           private let policy: objc_AssociationPolicy

           /// - Parameter policy: An association policy that will be used when linking objects.
           public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {

               self.policy = policy
           }

           /// Accesses associated object.
           /// - Parameter index: An object whose associated object is to be accessed.
           public subscript(index: AnyObject) -> T? {

               get { return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T? }
               set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
           }
       }
    private static let association = ObjectAssociation<UIActivityIndicatorView>()

    var indicator: UIActivityIndicatorView {
        set { ResultViewController.association[self] = newValue }
        get {
            if let indicator = ResultViewController.association[self] {
                return indicator
            } else {
                ResultViewController.association[self] = UIActivityIndicatorView.customIndicator(at:   self.view.center)
                return ResultViewController.association[self]!
            }
        }
    }

    // MARK: - Acitivity Indicator
    public func startIndicatingActivity() {
        DispatchQueue.main.async {
            self.view.addSubview(self.indicator)
            self.indicator.startAnimating()
            //UIApplication.shared.beginIgnoringInteractionEvents() // if desired
        }
    }

    public func stopIndicatingActivity() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            //UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}
extension UIActivityIndicatorView {
    public static func customIndicator(at center: CGPoint) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        indicator.layer.cornerRadius = 10
        indicator.center = center
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        indicator.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 0.5)
        return indicator
    }
}
extension UIViewController{
    
    // see ObjectAssociation<T> class below
   
}
