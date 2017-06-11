//
//  LoginViewController.swift
//  Purchasing Broker
//
//  Created by 連翊涵 on 2017/6/5.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userAccount: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userCountry: UITextField!
    @IBOutlet weak var userPhoneNum: UITextField!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    
    @IBOutlet weak var loginLabel: UIButton!
    @IBOutlet weak var regLabel: UIButton!
    
    
    var currentState = "login"
    var users = [UserData]()
    let saveProduct = UserDefaults.standard
    var inputAccount = ""
    var inputPassword = ""
    var inputName = ""
    var inputCountry = ""
    var inputPhoneNum = ""
    
    var currentUser: UserData? = nil
    
    
    @IBAction func login(_ sender: Any) {
        currentState = "login"
        loginLabel.setTitleColor(UIColor.blue, for: .normal)
        regLabel.setTitleColor(UIColor.darkGray, for: .normal)
        viewDidLoad()
    }
    
    @IBAction func reg(_ sender: Any) {
        currentState = "reg"
        regLabel.setTitleColor(UIColor.blue, for: .normal)
        loginLabel.setTitleColor(UIColor.darkGray, for: .normal)
        viewDidLoad()
    }
    @IBAction func done(_ sender: Any) {
        if currentState == "login"{
            if let temp = saveProduct.object(forKey: "users"){
                users = NSKeyedUnarchiver.unarchiveObject(with: temp as! Data) as! [UserData]
            }
            if users.count != 0{
                for var i in 0...users.count-1{
                    if userAccount.text! == users[i].account{
                        if userPassword.text! == users[i].password{
                            currentUser = users[i]
                            
                            let notificationName = Notification.Name("userLogin")
                            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["PASS":currentUser!])
                            saveProduct.set(true, forKey: "loginState")
                            self.navigationController?.popToRootViewController(animated: true)

                            //viewDidLoad()
                        }
                    }
                }
            }
        }
        else{
            inputAccount = userAccount.text!
            inputPassword = userPassword.text!
            inputName = userName.text!
            inputCountry = userCountry.text!
            inputPhoneNum = userPhoneNum.text!
            let newUser = UserData(initName: inputName, initAccount: inputAccount, initPassword: inputPassword, initHometown: inputCountry, initCredit: 2, initPhone: inputPhoneNum)
            if let temp = saveProduct.object(forKey: "users"){
                users = NSKeyedUnarchiver.unarchiveObject(with: temp as! Data) as! [UserData]
            }
            users.append(newUser)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: users)
            saveProduct.set(encodedData, forKey: "users")
            viewDidLoad()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAccount.text = ""
        userPassword.text = ""
        userName.text = ""
        userCountry.text = ""
        userPhoneNum.text = ""
        
        if currentState == "login"{
            loginLabel.setTitleColor(UIColor.blue, for: .normal)
            name.isHidden = true
            country.isHidden = true
            phoneNum.isHidden = true
            userName.isEnabled = false
            userName.isHidden = true
            userCountry.isEnabled = false
            userCountry.isHidden = true
            userPhoneNum.isEnabled = false
            userPhoneNum.isHidden = true
        }
        else{
            name.isHidden = false
            country.isHidden = false
            phoneNum.isHidden = false
            userName.isEnabled = true
            userName.isHidden = false
            userCountry.isEnabled = true
            userCountry.isHidden = false
            userPhoneNum.isEnabled = true
            userPhoneNum.isHidden = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
