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
    @IBOutlet weak var myStepper: UIStepper!
    
    @IBOutlet weak var alert: UIImageView!
    
    var dateString = ""
    var done = 1
    var checked = [false, false, false, false, false]
    var previousNum = 1
    
    var products = [ProductData]()
    var chosen: dataBaseData? = nil
    var order: ProductData? = nil
    var currentUser: UserData? = nil
    
    var state = "Taiwan"
    var key = "productListT2"
    
    @IBAction func stepperClick(_ sender: UIStepper) {
        productAmount.text = String(NSString(format: "%.0f", sender.value))
        if checked[2] == true{
            if previousNum != 0{
                productPrice.text = "\(Int(productPrice.text!)! * Int(productAmount.text!)! / previousNum)"
            }
            else{
                productPrice.text = productPrice.text
            }
        }
        previousNum = Int(productAmount.text!)!
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
        done = 1
        checked[0] = false
        checked[1] = false
        checked[2] = false
        checked[3] = false
        checked[4] = false
        performSegue(withIdentifier: "showHotItem", sender: nil)
    }
    
    
    @IBAction func doneAndSent(_ sender: UIButton) {
         if done == 6
        {
            products.removeAll()
            let alerController_done = UIAlertController(title: nil , message: "確認送出？", preferredStyle: UIAlertControllerStyle.alert)
            let doneAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.cancel )
            { (action:UIAlertAction) in
                let saveProduct = UserDefaults.standard
                if let temp = saveProduct.object(forKey: self.key){
                    self.products = NSKeyedUnarchiver.unarchiveObject(with: temp as! Data) as! [ProductData]
                }
                
                self.order = ProductData(initStore: String(self.storeName.text!), initName: String(self.productName.text!), initNumber: Int(self.productAmount.text!)!, initPrice: Int(self.productPrice.text!)!, initDestination: "中國", initPurchacePlace: "台灣", initBuyer: self.currentUser!, initPicture: (self.chosen?.picture)!, initDeadLine: self.dateString, initOfferPrice: Int(self.offerPrice.text!)!)
                
                self.products.append(self.order!)
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.products)
                saveProduct.set(encodedData, forKey: self.key)
              
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
                
                self.clear()
                self.dismiss(animated: true, completion: nil)
                /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "thirdRoot") as! UINavigationController
                self.present(viewController, animated: true, completion: nil)*/                
            }
            
            let notYetAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.default, handler: nil)
            alerController_done.addAction(doneAction)
            alerController_done.addAction(notYetAction)
            self.present(alerController_done, animated: true, completion: nil)
         }
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
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor(colorLiteralRed: 211/255, green: 221/255, blue: 235/255, alpha: 1.0)
        
        storeName.delegate = self
        productName.delegate = self
        productPrice.delegate = self
        offerPrice.delegate = self
        
        let saveProduct = UserDefaults.standard
        let didExist = saveProduct.bool(forKey: "loginState")
        if didExist == true{
            alert.isHidden = true
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(addNewProduct(noti:)), name: Notification.Name("NewProduct"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userDidExist(noti:)), name: Notification.Name("userLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userNotExist(noti:)), name: Notification.Name("userLogout"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    func clear()
    {
        done = 1
        checked = [false, false, false, false, false]
        previousNum = 1
        
        picture.image = UIImage(named: "暫時")
        storeName.text = ""
        productName.text = ""
        productPrice.text = ""
        offerPrice.text = ""
        myStepper.value = 1
        productAmount.text = "1"
        myDatePicker.setDate(Date(), animated: true)
        deadLine.setTitle("選擇日期", for: .normal)
    }
    
    func addNewProduct(noti:Notification){
        chosen = noti.userInfo!["PASS"] as? dataBaseData
        picture.image = UIImage(named: (chosen?.picture)!)
        storeName.text = chosen?.store
        productName.text = chosen?.name
        productPrice.text = "\(Int((chosen?.price)!) * Int(productAmount.text!)!)"
        
        done += 3
        checked[0] = true
        checked[1] = true
        checked[2] = true
    }
    func userDidExist(noti:Notification){
        currentUser = noti.userInfo!["PASS"] as? UserData
        alert.isHidden = true
        if currentUser?.hometown == "台灣"
        {
            state = "China"
            key = "productListC2"
        }
        else
        {
            state = "Taiwan"
            key = "productListT2"
        }
    }
    
    func userNotExist(noti:Notification){
        currentUser = nil
        alert.isHidden = false
        clear()
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
        if segue.identifier == "showHotItem" {
            let controller = segue.destination as! UINavigationController
            let targetController = controller.topViewController as! StoreTableViewController
            targetController.state = state
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
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
