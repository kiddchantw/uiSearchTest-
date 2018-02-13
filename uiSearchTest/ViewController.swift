//
//  ViewController.swift
//  uiSearchTest
//
//  Created by kiddchantw on 2018/1/18.
//  Copyright © 2018年 kiddchantw. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    //@IBOutlet var mySearch: UISearchBar!
    
    var titleArray =   ["Inro+溫暖而綿長的，餘燼","擱淺的人","在你死後才想起曾經答應陪你去散步","你好","一隅之見","五里霧中","犬的視線","16分鐘聽完康士坦專輯","Eureka!Eureka!"]
    var subtitleArray = ["7:46","4:32","8:18","4:51","4:55","3:20","6:06","16:02","4:00"]
//    var titleArray:Array<String> = []
//    var subtitleArray:Array<String> = []
    var mapListDict:Dictionary<String,String> = [:]
    
    var searchDict:Dictionary<String,String> = ["Inro+溫暖而綿長的，餘燼":"7:46","擱淺的人":"4:32","在你死後才想起曾經答應陪你去散步":"8:18","你好":"4:51","一隅之見":"4:55","五里霧中":"3:20","犬的視線":"","16分鐘聽完康士坦專輯":"6:06","Eureka!Eureka!":"4:00"]
    //= [:]

    
    
    @IBOutlet var myTable: UITableView!
    
    var searchController: UISearchController!
    var shouldShowSearchResult = false

    
    @IBAction func btnR(_ sender: UIBarButtonItem) {
        navigationItem.title = "alertSearch"
        titleArray =   ["Inro+溫暖而綿長的，餘燼","擱淺的人","在你死後才想起曾經答應陪你去散步","你好","一隅之見","五里霧中","犬的視線","16分鐘聽完康士坦專輯","Eureka!Eureka!"]
        subtitleArray = ["7:46","4:32","8:18","4:51","4:55","3:20","6:06","16:02","4:00"]
        myTable.reloadData()
    }
    
    
    
    
    var arraySearchResult:Array<String> = []
    @IBAction func btnS(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController( title: "alert",message:"keyword for search",preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .destructive, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            //textField.placeholder = "請輸入狀況"
        }
        
        let okAction = UIAlertAction(title: "確認", style: .default){
            (action:UIAlertAction) -> () in
            let acc = (alertController.textFields?.first)! as UITextField
            self.searchFilter(strInsert: acc.text!)
        }
        alertController.addAction(okAction)

        self.present(alertController,animated: true, completion: nil)
        
        


    }
    
    func searchFilter(strInsert:String){
        
        
        let filtered:Array<String> = titleArray.filter { $0.contains(strInsert) }
        print("filtered.count \(filtered.count)")
        
        let fitered2 = subtitleArray.filter{$0.contains(strInsert)}
        print("fitered2.count  \(fitered2.count)")
        
        
        var temp1:Array<String> = []
        var temp2:Array<String> = []
        
        if filtered.count != 0{
            titleArray = filtered
            print(titleArray)
        }
        
        
        if fitered2.count != 0{
            for index in 0...fitered2.count-1{
                if let index = searchDict.values.index(of: fitered2[index]) {
                    let key = searchDict.keys[index]
                    //                    print(key)
                    temp1.append(key)
                }
            }
            print(temp1)

        }
        
        
        let unique = Array(Set(filtered + temp1))//.sorted()
        print(unique)
        print(unique.count)
        
        if unique.count != 0{
            titleArray = unique.sorted{$1<$0}
            for index in 0...titleArray.count-1{
                temp2.append(searchDict["\(titleArray[index])"]!)
            }
            subtitleArray = temp2
        }
        
        DispatchQueue.main.async {
            self.myTable.reloadData()
            self.navigationItem.title = "\(unique.count)"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //getDataList()
        
        myTable.delegate = self
        myTable.dataSource = self
        myTable.rowHeight = UITableViewAutomaticDimension
        myTable.estimatedRowHeight = 50
    

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
//        if shouldShowSearchResult {
//            return searchDict.count
//        } else {
            return titleArray.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text =  titleArray[indexPath.row]
        cell.detailTextLabel?.text = subtitleArray[indexPath.row]
        
       
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        return cell
    }
    
    
}


public extension Sequence where Element : Hashable {
    func contains(_ elements: [Element]) -> Bool {
        return Set(elements).isSubset(of:Set(self))
    }
}

