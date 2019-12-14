//
//  DisplayDataViewController.swift
//  BMICalculatorAppTest
//
//  Created by Angadjot singh on 11/12/19.
//  Copyright © 2019 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase


class DisplayDataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var table: UITableView!
    
    
    var db:Firestore?
    var dict = [[String:AnyObject]]()
    var datee:Date?
    var BMIdate:String?
    var dictIndex = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      self.navigationController?.navigationBar.tintColor = UIColor.white
        
      retrieveData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dict.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let indexx = self.dict[indexPath.row]
        let weight = indexx["weight"] as? Int
        let height = indexx["height"] as? Int
        let bmi = indexx["bmi"] as? Double
        let dat = indexx["date"] as? Timestamp
        print("dat is",dat!,dat?.dateValue() as Any)
        
        
        if let date = indexx["date"] as? Date {
            self.datee = date
            print("date is is",self.datee!)
            let p = getDate()
            print("p is ",p)
            BMIdate = p
        }
        
        self.datee = dat?.dateValue()
         let p = getDate()
        
        if let d = cell.viewWithTag(4) as? UILabel{
            d.text = p
        }

        if let x = cell.viewWithTag(1) as? UILabel{
            x.text = "\(String(describing: weight!))"
        }
        
        if let y = cell.viewWithTag(2) as? UILabel{
            y.text = "\(String(describing: height!))"
        }
        
        if let z = cell.viewWithTag(3) as? UILabel{
            z.text = "\(String(describing: bmi!))"
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dictIndex = self.dict[indexPath.row]
        
        print("did select working")
        self.performSegue(withIdentifier: "nextVC", sender: nil)
//        deleteData(docId: docId)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let indexx = self.dict[indexPath.row]
            let docId = (indexx["docId"] as? String)!
            deleteData(docId: docId)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextVC"{
            let vc = segue.destination as? UpdateBMIViewController
            vc?.dictIndex = dictIndex
        }
    }
    
    
    
    func getDate()->String{
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "dd-MM-yyyy"
        let dateNew = dateFormatt.string(from: self.datee!)
        print(dateNew)
        return dateNew
    }
    
    
    func retrieveData(){
    
        db = Firestore.firestore()
       
        db?.collection("users").whereField("userUid", isEqualTo: "mSJHEnpl0EXuisQwBvXNxCc7p3K2").addSnapshotListener({ (snapshots, err) in
            if let error = err{
                print("err",error.localizedDescription)
            }else{
                
                if snapshots?.documents.isEmpty == true{
                    let alert = UIAlertController(title: "Message", message: "There are no records of BMI Available right now .", preferredStyle: .alert)
                    let okay = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                    self.dismiss(animated: true, completion: nil)
                     self.navigationController?.popViewController(animated: true)
                        
                    })
                    alert.addAction(okay)
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    self.dict.removeAll()
                    for i in snapshots!.documents{
                        self.dict.append(i.data() as [String : AnyObject])
                        //  print("data is",self.dict)
                    }
                    self.table.reloadData()
                }
            }

        })
    }
    
    
    func deleteData(docId:String){
        db = Firestore.firestore()
        db?.collection("users").document(docId).delete(){
            err in
            if let error = err{
                print(error.localizedDescription)
               
            }else{
                print("document deleted successfully")
                
            }
            
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
