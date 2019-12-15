//
//  ViewController.swift
//  BMICalculatorAppTest
//
//  Created by Angadjot singh on 11/12/19.

// File name - ViewController.swift
// Author's name - Angadjot Singh Modi
// Student id - 301060981
// Date - 11/12/19

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController,UITextFieldDelegate {

 // outlets dor the UI
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var submitOutlet: UIButton!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var resetOutlet: UIButton!
    //    mSJHEnpl0EXuisQwBvXNxCc7p3K2
    
    
 // declaring the variables
    var db:Firestore?
    var bmi = 0.0
    var datetime=Date()
    
    var weightC = 0.0
    var hightC = 0.0
    var bmiString:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        //print("date time",datetime)
        
 //   code for corner radius button
        self.submitOutlet.layer.cornerRadius = 10.0
        self.submitOutlet.layer.masksToBounds = true
        
        
        self.resetOutlet.layer.cornerRadius = 10.0
        self.resetOutlet.layer.masksToBounds = true
        
    }
    
 //  method to close keyboard on pressing returb button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
// action for calculating the bmi
    @IBAction func submitAction(_ sender: UIButton) {
        
//        validating the textfields
        if self.name.text == "" || self.age.text == "" || self.gender.text == "" || self.weight.text == "" || self.height.text == ""{
            let alert = UIAlertController(title: "Message", message: "Please add all the fields to calculate your BMI!!", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Done", style: .default, handler: { (action) in
            })
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
            
        }else{
   // function for calculating the bmi
          calculateBMI()
        }
       
    }
    
// function for calculating the bmi
    func calculateBMI(){
    
   // if toggle switch is on bmi will be calculated in imperial units
        if toggleSwitch.isOn == true{
            
            weightC = Double(self.weight.text!)!
            hightC = Double(self.height.text!)!
            print("weight height is",weightC,hightC)

            hightC = hightC / 39
            print("hightC",hightC)

//            0.453592
//            let x = Double(weightC!)
            
            weightC = weightC * 2
            print("hightC",weightC)


            bmi = weightC*703/hightC*hightC
            print("bmi is",bmi)

        
            addData()
            
        }else if toggleSwitch.isOn == false{
// if toggle switch is off bmi will be calculated in metric units
            
            weightC = Double(self.weight.text!)!
            hightC = Double(self.height.text!)!
            print("weight height is",weightC,hightC)
            let h = hightC * hightC
            
            
//            weightC = weightC
            hightC = hightC*0.305
            print("weight height is",weightC,hightC)
            print("h is",h)
            
            
            bmi = (weightC/(h))
            print("bmi is",bmi)
            
            addData()
        }
    }
    
 // function for adding the data to the firestore
    func addData(){
        
//                self.indicator.startAnimating()
    // seeting the data to firstore
            db = Firestore.firestore()
            let docId = db?.collection("users").document().documentID
            let date = Date()
            print("date is",date)
            
            let agee = Int(age.text!)
            
            let parameters = ["name":name.text!,"age":agee!,"userUid":"mSJHEnpl0EXuisQwBvXNxCc7p3K2","docId":docId!,"gender":gender.text!,"weight":weightC,"height":hightC,"date":date,"bmi":bmi] as [String : Any]
   
        
    // setdata function for adding data
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
    
 // function for showing the bmi category in alert view
    func showBmiMessage(){
        
        if bmi < 16 {
            print("less than 16")
            showAlert(x: "Ypur BMI is \(bmi). \n Your BMI shows you are in category Severe Thickness")
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
            self.name.text = ""
            self.age.text = ""
            self.gender.text = ""
            self.weight.text = ""
            self.height.text = ""
            
            
            self.performSegue(withIdentifier: "nextVC", sender: nil)
            
        })
        alert.addAction(okay)
        self.present(alert, animated: true, completion: nil)
    
    
    }
    
    
    
  // action for viewing the records on next page
    @IBAction func records(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "nextVC", sender: nil)
        
    }
    
    
   // action for resetting the values
    @IBAction func resetAction(_ sender: UIButton) {
        self.name.text = ""
        self.age.text = ""
        self.gender.text = ""
        self.weight.text = ""
        self.height.text = ""
    }
    
    
    
}

