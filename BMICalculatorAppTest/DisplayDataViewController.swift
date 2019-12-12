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

    
    var db:Firestore?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        
        return cell
    }
    
    
    func retrieveData(){
    
      db = Firestore.firestore()
        
    
    
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
