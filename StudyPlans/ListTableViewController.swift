//
//  ListTableViewController.swift
//  StudyPlans
//
//  Created by 牧野晴音 on 2018/06/20.
//  Copyright © 2018年 牧野晴音. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var wordArray: [[String]]!
    
    var saveData = UserDefaults.standard
    
    let nowDate = NSDate()
    let datedateFormat = DateFormatter()
    var datedate: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "cell")
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        datedateFormat.dateFormat = "yyyyMMdd"
        datedate = datedateFormat.string(from: nowDate as Date)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if saveData.array(forKey: "WORD") != nil {
            wordArray = saveData.array(forKey: "WORD") as! [[String]]
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wordArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! ListTableViewCell
            
            var nowIndexPathDictionary = wordArray[indexPath.row]
            
            cell.dateLabel.text = nowIndexPathDictionary[0]
            cell.subjectLabel.text = nowIndexPathDictionary[1]
            cell.contentsLabel.text = nowIndexPathDictionary[2]
            
            let date3 = Int(nowIndexPathDictionary[3])!
            let datedate2 = Int(datedate)!
            let deffrence = date3 - datedate2
            
            if deffrence <= 0 {
                let color3 = UIColor(red: 0.9, green: 0.1, blue: 0.7, alpha: 0.5)
                cell.contentView.backgroundColor = color3
            } else if deffrence <= 3 {
                let color2 = UIColor(red: 0.7, green: 0.9, blue: 0.1, alpha: 0.5)
                cell.contentView.backgroundColor = color2
            } else {
                let color = UIColor(red: 0.1, green: 0.7, blue: 0.9, alpha: 0.5)
                cell.contentView.backgroundColor = color
            }
            
            return cell
    }
    
    // 削除
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            self.wordArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.saveData.set(self.wordArray, forKey: "WORD")
        }
        
        deleteButton.backgroundColor = UIColor.red
        
        return [deleteButton]
    }
    
//    // cell背景色
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.contentView.backgroundColor = UIColor.lightGray
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
