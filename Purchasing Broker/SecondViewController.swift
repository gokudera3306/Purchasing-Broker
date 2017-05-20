//
//  SecondViewController.swift
//  Purchasing Broker
//
//  Created by 連翊涵 on 2017/5/19.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var storeName: UITextField!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var offerPrice: UITextField!
    @IBOutlet weak var productAmount: UILabel!
    @IBOutlet weak var deadLine: UIButton!
    @IBOutlet weak var deadLineLabel: UILabel!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var send: UIButton!
    
    
    var dateString = ""
    var done = 1
    var checked = [false, false, false, false, false]
    
    let defaultUser = UserData(initName: "TEST1", initAccount: "aaa", initPassword: "0000", initHometown: "台灣", initCredit: 2)
    var products = [ProductData]()
    var chosen: dataBaseData? = nil
    
    @IBAction func stepperClick(_ sender: UIStepper) {
        productAmount.text = String(NSString(format: "%.0f", sender.value))
    }

    @IBAction func chooseDate(_ sender: UIButton) {
        myDatePicker.isHidden = false
        deadLine.setTitle("", for: .normal)
        deadLineLabel.text = ""
        deadLine.isEnabled = false
        doneBtn.isHidden = false
        send.isEnabled = false
        send.isHidden = true
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        dateString = dateFormatter.string(from: myDatePicker.date)
        doneBtn.setTitle("確認", for: .normal)
        
    }
    
    @IBAction func doneChaged(_ sender: Any) {
        myDatePicker.isHidden = true
        deadLine.isEnabled = true
        deadLine.setTitle(dateString, for: .normal)
        deadLineLabel.text = "交貨期限"
        doneBtn.isHidden = true
        send.isEnabled = true
        send.isHidden = false
        
        if checked[4] == false
        {
            checked[4] = true
            done += 1
        }
        
    }
    
    @IBAction func showHotItem(_ sender: UIButton) {
        performSegue(withIdentifier: "showHotItem", sender: nil)
    }
    
    
    @IBAction func doneAndSent(_ sender: UIButton) {
         if done == 6
        {
            let alerController_done = UIAlertController(title: nil , message: "確認送出？", preferredStyle: UIAlertControllerStyle.alert)
            let doneAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.cancel )
            { (action:UIAlertAction) in
                let saveProduct = UserDefaults.standard

                if let temp = saveProduct.object(forKey: "productList2"){
                    self.products = NSKeyedUnarchiver.unarchiveObject(with: temp as! Data) as! [ProductData]
                }
                let order = ProductData(initStore: String(self.storeName.text!), initName: String(self.productName.text!), initNumber: Int(self.productAmount.text!)!, initPrice: Int(self.productPrice.text!)!, initDestination: "中國", initPurchacePlace: "台灣", initBuyer: self.defaultUser, initPicture: "暫時", initDeadLine: self.dateString, initOfferPrice: Int(self.offerPrice.text!)!)
                self.products.append(order)
                    
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.products)
                saveProduct.set(encodedData, forKey: "productList2")
            }
            
            let notYetAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.default, handler: nil)
            alerController_done.addAction(doneAction)
            alerController_done.addAction(notYetAction)
            self.present(alerController_done, animated: true, completion: nil)        }
        else
        {
            let alerController_wrong = UIAlertController(title: "錯誤！", message: "資料尚未完整", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.cancel, handler: nil)
            alerController_wrong.addAction(cancelAction)
            self.present(alerController_wrong, animated: true, completion: nil)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeName.delegate = self
        productName.delegate = self
        productPrice.delegate = self
        offerPrice.delegate = self
        
        if chosen != nil{
            storeName.text = chosen?.store
            productName.text = chosen?.name
            productPrice.text = "\((chosen?.price)!)"
            done += 3
            checked[0] = true
            checked[1] = true
            checked[2] = true
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == storeName
        {
            if storeName.text != "" && checked[0] == false
            {
                checked[0] = true
                done += 1
            }
        }
        else if textField == productName
        {
            if productName.text != "" && checked[1] == false
            {
                checked[1] = true
                done += 1
            }
        }
        else if textField == productPrice
        {
            if productPrice.text != "" && checked[2] == false
            {
                checked[2] = true
                done += 1
            }
        }
        else
        {
            if offerPrice.text != "" && checked[3] == false
            {
                checked[3] = true
                done += 1
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == storeName
        {
            productName.becomeFirstResponder()
        }
        else if textField == productName
        {
            productPrice.becomeFirstResponder()
        }
        else if textField == productPrice
        {
            offerPrice.becomeFirstResponder()
        }
        else
        {
            offerPrice.resignFirstResponder()
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHotItem"{
            //let controller = segue.destination as! StoreTableViewController
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
