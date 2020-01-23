//
//  ViewController.swift
//  MyForex
//
//  Created by apple on 09/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBAction func editBtn(_ sender: Any) {
        //tblTableView.isEditing = true
    }
    
    @IBOutlet weak var tblTableView: UITableView!
    
    var dataTaskObj:URLSessionDataTask!
    var URLReqObj:URLRequest!
       
    var arrData:[String:Any]!
    var titleGet = [String]()
    var des = [String]()
    var author = [String]()

   
    override func viewDidLoad() {
        super.viewDidLoad()
       //Here we call the funtion
        getData()
        titleData()
        descript()
        getAuthor()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
       // self.tblTableView.isEditing = true
        
}
    
    
    

    //this function is for fetching data from server
       func getData() -> [String:Any]
       {
        
        URLReqObj = URLRequest(url: URL(string:        "https://newsapi.org/v2/top-headlines?country=in&apiKey=29b3b9aa444a498b9d278056cb0700cb"
        )!)
    
               URLReqObj.httpMethod = "GET"
    
    
               dataTaskObj = URLSession.shared.dataTask( with: URLReqObj, completionHandler: {data, connDetails, error in
                   print("got data from server")
    
                   do{
                    self.arrData = try
                        JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : Any]
    
                    let json = self.arrData
                    let result = json!["articles"]
                  
    
    
               }
                   catch
                   {
                       print("Somethong Wrong with you")
                   }
    
    
               })
               dataTaskObj.resume()
    
            while arrData == nil {
    
            }
            return arrData
           }
    
    
    //here we append title
    func titleData()
    {
        var rr = arrData
        let qq = rr!["articles"]
        //print(qq)
        for i in qq as! [AnyObject]{
            titleGet.append(i["title"] as! String)
           // print(arr)
        }
    }
    
    
    //here we append description
    func descript()  {
         var rr = arrData
         let qq = rr!["articles"]
         //print(qq)
         for i in qq as! [AnyObject]{
             des.append(i["description"] as! String)
             //print(des)
         }
     }
    
    //here we append author
    func getAuthor()
    {
         var rr = arrData
         let qq = rr!["articles"]
         //print(qq)
         for i in qq as! [AnyObject]{
             author.append(i["author"] as? String ?? "no author" )
             print(author
            )
         }
     }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleGet.count
       
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        
        
        
        cell.titleLbl.text = titleGet[indexPath.row] as! String
        cell.titleLbl.numberOfLines = 0
        cell.desLbl.numberOfLines = 0
        cell.authorLbl.numberOfLines = 0
        
        cell.desLbl.text = (des[indexPath.row] as! String)
        cell.authorLbl.text = (author[indexPath.row] as! String)
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
        
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObj1 = self.titleGet[sourceIndexPath.row]
        titleGet.remove(at: sourceIndexPath.row)
        titleGet.insert(movedObj1, at: destinationIndexPath.row)
        

        
    }
    

 
}

