//
//  ViewController.swift
//  BMICalculatorAppTest
//
//  Created by Angadjot singh on 11/12/19.
//  Copyright © 2019 Angadjot singh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var submitOutlet: UIButton!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var toggleSwitch: UISwitch!
//    mSJHEnpl0EXuisQwBvXNxCc7p3K2
    
    var db:Firestore?
    var bmi:Int?
    var datetime=Date()
    
    var weightC:Int?
    var hightC:Int?
    var bmiString:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        print("date time",datetime)
    }


    @IBAction func submitAction(_ sender: UIButton) {
        calculateBMI()
    }
    
    
    func calculateBMI(){
        
        if toggleSwitch.isOn == true{
            
            weightC = Int(self.weight.text!)
            hightC = Int(self.height.text!)
            print("weight height is",weightC!,hightC!)
            
            hightC = hightC! * 39
            
            bmi = weightC!*703/hightC!*hightC!
            print("bmi is",bmi!)
            
            
            
        
            addData()
            
        }else if toggleSwitch.isOn == false{
            
            weightC = Int(self.weight.text!)
            hightC = Int(self.height.text!)
            print("weight height is",weightC!,hightC!)
            
            bmi = weightC!/hightC!*hightC!
            print("bmi is",bmi!)
            
            addData()
        }
    }
    
    
    func addData(){
        
//                self.indicator.startAnimating()
        

            db = Firestore.firestore()
            let docId = db?.collection("users").document().documentID
            let date = Date()
            print("date is",date)
        
            let agee = Int(age.text!)
        
        let parameters = ["name":name.text!,"age":agee!,"userUid":"mSJHEnpl0EXuisQwBvXNxCc7p3K2","docId":docId!,"gender":gender.text!,"weight":weightC!,"height":hightC!,"date":date,"bmi":bmi!] as [String : Any]
        
        db?.collection("users").document(docId!).setData(parameters as [String : Any]){
                    err in
                    if let error = err{
                        print(error.localizedDescription)
        //                self.indicator.stopAnimating()
                    }else{
                        print("document added successfully")
        //                self.indicator.stopAnimating()
                        self.showBmiMessage()
                      
                    }
        
                }
    }
    
    
    func showBmiMessage(){
        
        if bmi! < 16 {
            print("less than 16")
            showAlert(x: "Your BMI shows you are in category Severe Thickness")
        }else if bmi == 16 || bmi == 17{
             showAlert(x: "Your BMI shows you are in category Moderate Thickness")
        }else if bmi == 17 || bmi == 18{
            showAlert(x: "Your BMI shows you are in category Mild Thickness")
        }else if bmi == 18 || bmi == 25{
            showAlert(x: "Your BMI shows you are in category Normal")
        }else if bmi == 25 || bmi == 30{
            showAlert(x: "Your BMI shows you are in category Overweight")
        }else if bmi == 30 || bmi == 35{
            showAlert(x: "Your BMI shows you are in category Obese class 1")
        }else if bmi == 35 || bmi == 40{
            showAlert(x: "Your BMI shows you are in category Obese class 2")
        }else if bmi!>40{
            showAlert(x: "Your BMI shows you are in category Obese class 3")
        }
        
    }
    
    func showAlert(x:String){
        
        let alert = UIAlertController(title: "Message", message: x, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Done", style: .default, handler: { (action) in
        })
        alert.addAction(okay)
        self.present(alert, animated: true, completion: nil)
    
    
    }
    
    
    
    
    
}

