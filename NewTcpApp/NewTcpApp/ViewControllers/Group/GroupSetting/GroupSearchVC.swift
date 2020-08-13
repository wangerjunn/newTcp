//
//  GroupSearchVC.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/22.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class GroupSearchVC: BaseViewController {
    var table:UITableView?
    var dataArray:Array<GroupModel>?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "查找群组"
        configUI()
    }
    fileprivate func configUI()
    {
        dataArray = Array()
        let searchView = UISearchBar.init(frame: CGRect.init(x: 0, y: 64, width: kScreenW, height: 50))
        searchView.delegate = self
        self.view.addSubview(searchView)
        
        
        table = UITableView.init(frame: CGRect.init(x: 0, y: 64+50, width: kScreenW, height: kScreenH-64-50))
        self.view.addSubview(table!)
        table?.delegate = self;
        table?.dataSource = self;
        table?.tableFooterView = UIView.init()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
//         self.configUIWith(fromCellName: "BaseTableCell", fromIsShowSearch: true,fromSearchType: false ,fromCellHeight: 50)
//         configData()
//        self.allDataArray = FriendsModel.allObjects()
//        
//        //
//        self.setDataArray(dataArray: self.allDataArray!)
        // Do any additional setup after loading the view.
    

//    func configData(){
//    
//        self.allDataArray = GroupModel.allObjects()
//        self.setDataArray(dataArray: self.allDataArray!)
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func searchBarTextChangedWith(nowText: String) {
//        
//        if nowText.isEmpty {
//            self.dataArray = self.allDataArray
//        }
//        else
//        {
//            
//        let predicate = NSPredicate.init(format: "group_name Contains %@", argumentArray: ([nowText]))
//        self.dataArray = self.dataArray?.objects(with: predicate)
//        }
//        
//        self.table?.reloadData()
//      }
//    
//    
//    /// cell右边按钮点击事件
//    ///
//    /// - Parameter model: <#model description#>
//    override func cellRightBtnClick(model: RLMObject) {
//        
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


extension GroupSearchVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 44
        }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray != nil ?Int((dataArray?.count)!): 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:BaseTableCell? = tableView.dequeueReusableCell(withIdentifier: "cell") as! BaseTableCell?
        if cell == nil
        {
                cell = Bundle.main.loadNibNamed("BaseTableCell", owner: self, options: nil)?.last as! UITableViewCell? as! BaseTableCell?
        }
        
        if self.dataArray!.count > indexPath.row {
            let model:RLMObject = self.dataArray![indexPath.row]
            cell?.setValue(model, forKey: "model")
            cell?.delegate = self
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}


extension GroupSearchVC:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
        var params = Dictionary<String, Any>()
        params["app_token"] = sharePublicDataSingle.token
        params["keyword"] = searchBar.text
        
        GroupRequest.search(params: params, hadToast: true, fail: { (e) in
            
        }, success: { (sdic) in
           
            if let code = sdic["code"] {
                if "\(code)" != "1" {
                    self.showAlert(content: sdic["msg"] as! String)
                    return
                }
            }
            
           self.dataArray?.removeAll()
           let array = sdic["list"] as! Array<Dictionary<String, Any>>
            if array.isEmpty{
            self.table?.reloadData()
             return
            }
            for i in 0...array.count-1  {
                let model = GroupModel()
                let dic:Dictionary = array[i]
               model.setValuesForKeys(dic)
             self.dataArray?.append(model)
           }
       self.table?.reloadData()
    })
    }
}

extension GroupSearchVC:BaseCellDelegate{
   
    func cellRightBtnClick(model: RLMObject) {
        let applyJoinGroupVc = ApplyJoinGroupViewController()
        applyJoinGroupVc.groupModel = model as? GroupModel
        self.navigationController?.pushViewController(applyJoinGroupVc, animated: true)

    }
    
}
