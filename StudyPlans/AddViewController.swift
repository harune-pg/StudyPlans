//
//  AddViewController.swift
//  StudyPlans
//
//  Created by 牧野晴音 on 2018/06/20.
//  Copyright © 2018年 牧野晴音. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet var TextField: UITextField!
    @IBOutlet var TextView: UITextView!
    @IBOutlet var dateSelecter: UITextField!
    
    var wordArray: [Dictionary<String, String>] = []
    
    let saveData: UserDefaults = UserDefaults.standard
    
    let nowDate = NSDate()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if saveData.array(forKey: "WORD") != nil {
            wordArray = saveData.array(forKey: "WORD") as! [Dictionary<String, String>]
        }
        
        // キーボード開閉
        TextField.delegate = self
        TextView.delegate = self
        
        // 日付フィールドの設定
        dateFormat.dateFormat = "yyyy/MM/dd"
        dateSelecter.text = dateFormat.string(from: nowDate as Date)
        self.dateSelecter.delegate = self
        
        // DatePickerの設定
        inputDatePicker.datePickerMode = UIDatePickerMode.date
        dateSelecter.inputView = inputDatePicker
        
        // キーボードに表示するツールバーの表示
        let pickerToolBar = UIToolbar(frame: CGRect(x:0, y:0, width: view.frame.size.width, height: 35))
        pickerToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        pickerToolBar.barStyle = .blackTranslucent
        pickerToolBar.tintColor = UIColor.white
        pickerToolBar.backgroundColor = UIColor.black
        // ボタンの設定
        // 右寄せのためのスペース設定
        let spaceBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: Selector(""))
        // 完了ボタンを設定
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(toolBarBtnPush))
        // ツールバーにボタンを表示
        pickerToolBar.items = [spaceBarBtn,toolBarBtn]
        dateSelecter.inputAccessoryView = pickerToolBar
        
        TextView.layer.borderColor = UIColor.lightGray.cgColor
        TextView.layer.borderWidth = 0.5
        TextView.layer.cornerRadius = 10.0
        TextView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveWord() {
        if TextField.text != "" && TextView.text != "" && dateSelecter.text != ""{
            let wordDictionary = ["date": dateSelecter.text!, "subject": TextField.text!, "contents": TextView.text!] as [String : Any]
        
        wordArray.append(wordDictionary as! [String : String])
        saveData.set(wordArray, forKey: "WORD")
        print(wordArray)
//        var sortedwordArray: [Dictionary<String, String>] = wordArray.sorted { $0 < $1 }
        
        let alert: UIAlertController = UIAlertController(
            title: "保存完了",
            message: "登録が完了しました",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    print("OKボタンが押されました！")
            }))
        self.present(alert, animated: true, completion: nil)
        TextField.text = ""
        TextView.text = ""
        dateSelecter.text = dateFormat.string(from: nowDate as Date)
        } else {
            let alert: UIAlertController = UIAlertController(
                title: "保存できません",
                message: "保存したい予定を入力してください",
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: { action in
                        print("OKボタンが押されました！")
                }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // 完了を押すとピッカーの値を、テキストフィールドに挿入して、ピッカーを閉じる
    @objc func toolBarBtnPush(sender: UIBarButtonItem) {
        let pickerDate = inputDatePicker.date
        dateSelecter.text = dateFormat.string(from: pickerDate)
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TextField.resignFirstResponder()
        return true
    }
    
    private func textViewShouldEndEditing(_ textField: UITextField) -> Bool {
        if (TextView.text == "\n") {
        TextView.resignFirstResponder()
        return false
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
