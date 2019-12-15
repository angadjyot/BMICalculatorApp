//
//  UpdateBMIViewController.swift
//  BMICalculatorAppTest
//
//  Created by Angadjot singh on 13/12/19.
//  Copyright © 2019 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase

class UpdateBMIViewController: UIViewController {

    
    
    @IBOutlet weak var weight: UITextField!
//    @IBOutlet weak var height: UITextField!
    
    
 // declaring the variables
    var dictIndex = [String:AnyObject]()

    var weightC = 0.0
    var hightC = 0.0
    var bmi = 0.0
    var db:Firestore?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("dictindex",self.dictIndex)
    }
    

 // action for updating the particular record
    @IBAction func updateBMI(_ sender: UIButton) {

        weightC = Double(self.weight.text!)!
        hightC = (dictIndex["height"] as? Double)!

        print("weight height is",weightC,hightC)
        let h = hightC * hightC
        
        
        print("h is",h)
        
        
        bmi = (weightC/(h))
        print("bmi is",bmi)
        
  
        updateData()
        
    }
  
 // function for showing the bmi category in alert view
    func showBmiMessage(){
        
        if bmi < 16 {
            print("less than 16")
            showAlert(x: "Your BMI shows you are in category Severe Thickness")
        }else if bmi >= 16 || bmi <= 17{
            showAlert(x: "Your BMI shows you are in category Moderate Thickness")
        }else if bmi >= 17 || bmi <= 18{
            showAlert(x: "Your BMI shows you are in category Mild Thickness")
        }else if bmi >= 18 || bmi <= 25{
            showAlert(x: "Your BMI shows you are in category Normal")
        }else if bmi >= 25 || bmi <= 30{
            showAlert(x: "Your BMI shows you are in category Overweight")
        }else if bmi >= 30 || bmi <= 35{
            showAlert(x: "Your BMI shows you are in category Obese class 1")
            showAlert(x: "Your BMI shows you are in category Obese class 2")
        }else if bmi>40{
            showAlert(x: "Your BMI shows you are in category Obese class 3")
        }
        
    }
    
// show alert function
    func showAlert(x:String){
        
        let alert = UIAlertController(title: "Message", message: x, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Done", style: .default, handler: { (action) in
        self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(okay)
        self.present(alert, animated: true, completion: nil)
    }
    
    
// function for updating the data on firstore
    func updateData(){
        db = Firestore.firestore()
        
        dictIndex["weight"] = weightC as AnyObject?
        dictIndex["height"] = hightC as AnyObject?
        dictIndex["bmi"] = bmi as AnyObject?
        let date = Date()
        dictIndex["date"] = date as AnyObject
        
        
        db?.collection("users").document(dictIndex["docId"] as! String).updateData(dictIndex){
            err in
            if let error = err{
                print(error.localizedDescription)
               
            }else{
                print("document updated successfully")
                self.showBmiMessage()
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
