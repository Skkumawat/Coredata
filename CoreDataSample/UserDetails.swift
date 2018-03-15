//
//  UserDetails.swift
//  CoreDataSample
//
//  Created by Sharvan Kumawat on 14/03/18.
//  Copyright © 2018 Sharvan Kumawat. All rights reserved.
//

import UIKit

class UserDetails: UIViewController {
    
    static func storyboardInstance() -> UserDetails {
        let story = UIStoryboard(name: "Main",     bundle: nil)
        return story.instantiateViewController(withIdentifier:"UserDetails") as! UserDetails
    }
    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var btnDelete: UIButton!
    var user: UserModel?
    var index = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        if let us = user {
            txtName.text = us.name
            txtEmail.text = us.email
            txtPhone.text = us.phone
            btnSubmit.setTitle("Update", for: .normal)
            
        }
        else{
            btnDelete.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btn_Delete(_ sender: UIButton) {
        if let us = user {
            CoreDataManager.deleteUser(user: us)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    @IBAction func btn_Submit(_ sender: UIButton) {
        if let us = user {
            let user = UserModel()
            user.user_id = index
            user.name = txtName.text ?? ""
            user.email = txtEmail.text ?? ""
            user.phone = txtPhone.text ?? ""
            CoreDataManager.UpdateUser(user: user)
            self.navigationController?.popViewController(animated: true)
        }
        else{
            let user = UserModel()
            user.user_id = index
            user.name = txtName.text ?? ""
            user.email = txtEmail.text ?? ""
            user.phone = txtPhone.text ?? ""
            CoreDataManager.saveUserData(userData: user)
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
