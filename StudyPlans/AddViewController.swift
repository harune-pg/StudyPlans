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
    
    @IBOutlet var scrollView: UIScrollView!
    
    var wordArray: [[String]]!
    let saveData: UserDefaults = UserDefaults.standard
    
    let nowDate = NSDate()
    let dateFormat = DateFormatter()
    let dateFormat2 = DateFormatter()
    let inputDatePicker = UIDatePicker()
    
    var date2: String!

    let SCREEN_SIZE = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //ここでUIKeyboardWillShowという名前の通知のイベントをオブザーバー登録をしている
//        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        //ここでUIKeyboardWillHideという名前の通知のイベントをオブザーバー登録をしている
//        NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        // 保存
        if saveData.array(forKey: "WORD") != nil {
            wordArray = saveData.array(forKey: "WORD") as! [[String]]
        }
        
        // キーボード開閉
        TextField.delegate = self
        TextView.delegate = self
        // 日付フィールドの設定
        dateFormat.dateFormat = "yyyy/MM/dd"
        dateFormat2.dateFormat = "yyyyMMdd"
        dateSelecter.text = dateFormat.string(from: nowDate as Date)
        date2 = dateFormat2.string(from: nowDate as Date)
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
        // 右寄せのためのスペース設定
        let spaceBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: Selector(""))
        // 完了ボタンを設定
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(toolBarBtnPush))
        // ツールバーにボタンを表示
        pickerToolBar.items = [spaceBarBtn,toolBarBtn]
        dateSelecter.inputAccessoryView = pickerToolBar
        
        // TextViewの形
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
            let wordDictionary = [dateSelecter.text!, TextField.text!, TextView.text!, date2!]
            
            if wordArray.isEmpty {
                wordArray.append(wordDictionary)
                // wordArrayが空のとき一番後ろに追加
            } else {
                print(wordArray.count)
                let wordArrayCount = wordArray.count
                var number = 0
                
                for i in 0..<wordArray.count {
                    print(wordArray[i][0])
                    
                    if wordArray[i][0] > wordDictionary[0] {
                        wordArray.insert(wordDictionary, at: i)
                        break
                        // 既存のwordArrayの要素よりも小さいとき一番上に追加後for文停止
                    } else if wordArray[i][0] < wordDictionary[0] {
                        if wordArray[wordArrayCount - 1][0] < wordDictionary[0] {
                            wordArray.append(wordDictionary)
                            break
                            // 既存のwordArrayの要素よりも大きいとき一番後ろに追加後for文停止
                        } else {
                            number += 1
                            if wordArray[i + 1][0] > wordDictionary[0] {
                                wordArray.insert(wordDictionary, at: number)
                                break
                                // 既存のwordArrayの要素の真ん中のときfor文利用して位置を把握後そこに追加後for文停止
                            }
                        }
                    }
                }
            }
        
        saveData.set(wordArray, forKey: "WORD")
        print(wordArray)
        
        let alert: UIAlertController = UIAlertController(title: "保存完了",message: "登録が完了しました",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style: .default,handler: { action in}))
        self.present(alert, animated: true, completion: nil)
        TextField.text = ""
        TextView.text = ""
        dateSelecter.text = dateFormat.string(from: nowDate as Date)
            
        } else {
            
            let alert: UIAlertController = UIAlertController(title: "保存できません",message: "保存したい予定を入力してください",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",style: .default,handler: { action in}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self,selector: Selector(("keyboardWillBeShown:")),name: NSNotification.Name.UIKeyboardWillShow,object: nil)
//        NotificationCenter.default.addObserver(self,selector: Selector(("keyboardWillBeHidden:")),name: NSNotification.Name.UIKeyboardWillHide,object: nil)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillShow,object: nil)
//        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillHide,object: nil)
//    }
//
//    //UIKeyboardWillShow通知を受けて、実行される関数
//    @objc func keyboardWillShow(_ notification: NSNotification){
//        let keyboardHeight = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.height
//        TextView.frame.origin.y = SCREEN_SIZE.height - keyboardHeight - TextView.frame.height
//    }
//
//    //UIKeyboardWillShow通知を受けて、実行される関数
//    @objc func keyboardWillHide(_ notification: NSNotification){
//        TextView.frame.origin.y = SCREEN_SIZE.height - TextView.frame.height
//    }
//
//    func keyboardWillBeShown(notification: NSNotification) {
//    }
//
//    func keyboardWillBeHidden(notification: NSNotification) {
//    }
//    
//
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    // 完了を押すとデイトピッカーの値を、テキストフィールドに挿入して、ピッカーを閉じる
    @objc func toolBarBtnPush(sender: UIBarButtonItem) {
        let pickerDate = inputDatePicker.date
        dateSelecter.text = dateFormat.string(from: pickerDate)
        date2 = dateFormat2.string(from: pickerDate)
        self.view.endEditing(true)
    }
    
    // TextFieldで改行を押すと閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TextField.resignFirstResponder()
        return true
    }
    
//    // TextField外をタップするとキーボードを閉じる
//    private func textViewShouldEndEditing(_ textField: UITextField) -> Bool {
//        if (TextView.text == "\n") {
//        TextView.resignFirstResponder()
//        return false
//        }
//        return true
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
//    //Viewをタップした時に起こる処理を描く関数
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //キーボードを閉じる処理
//        view.endEditing(true)
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
