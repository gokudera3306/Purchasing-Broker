//
//  ForthViewController.swift
//  Purchasing Broker
//
//  Created by 連翊涵 on 2017/5/28.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController {
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var account: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var userStar: UILabel!

    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    var currentUser: UserData? = nil
    
    @IBAction func login(_ sender: UIButton){
        performSegue(withIdentifier: "login", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(colorLiteralRed: 211/255, green: 221/255, blue: 235/255, alpha: 1.0)
        NotificationCenter.default.addObserver(self, selector: #selector(userDidExist(noti:)), name: Notification.Name("userLogin"), object: nil)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        currentUser = nil
        loginBtn.isHidden = false
        loginBtn.isEnabled = true
        logoutBtn.isHidden = true
        logoutBtn.isEnabled = false
        name.isHidden = true
        account.isHidden = true
        country.isHidden = true
        phone.isHidden = true
        userStar.isHidden = true
        star1.isHidden = true
        star2.isHidden = true
        star3.isHidden = true
        star4.isHidden = true
        star5.isHidden = true
        let notificationName = Notification.Name("userLogout")
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
    
    
    func userDidExist(noti:Notification){
        currentUser = noti.userInfo!["PASS"] as? UserData
        loginBtn.isHidden = true
        loginBtn.isEnabled = false
        logoutBtn.isHidden = false
        logoutBtn.isEnabled = true
        name.isHidden = false
        account.isHidden = false
        country.isHidden = false
        phone.isHidden = false
        userStar.isHidden = false
        star1.isHidden = false
        star2.isHidden = false
        star3.isHidden = false
        star4.isHidden = false
        star5.isHidden = false
        name.text = "暱稱："+(currentUser?.name)!
        account.text = "帳號："+(currentUser?.account)!
        country.text = "居住地區："+(currentUser?.hometown)!
        phone.text = "聯絡電話："+(currentUser?.phone)!
        userStar.text = "信用指數："
        if (currentUser?.credit)! >= 1 {
            star1.image = #imageLiteral(resourceName: "star")
        }
        if (currentUser?.credit)! >= 2 {
            star2.image = #imageLiteral(resourceName: "star")
        }
        if (currentUser?.credit)! >= 3 {
            star3.image = #imageLiteral(resourceName: "star")
        }
        if (currentUser?.credit)! >= 4 {
            star4.image = #imageLiteral(resourceName: "star")
        }
        if (currentUser?.credit)! >= 5 {
            star5.image = #imageLiteral(resourceName: "star")
        }
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
