//
//  GroupCreateVC.swift
//  NewTcpApp
//
//  Created by xslp on 2020/7/23.
//  Copyright © 2020 xslpiOS. All rights reserved.
//

import UIKit

class GroupCreateVC: BaseViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, BaseCellDelegate {
    
    //部门数据数据源
    var departDataArray:Array<RLMObject>?
    
    //其他部门的数据源
    var otherDepartDataArray:Array<RLMObject>?
    
    //选择的数据源
    var seleDepartArray:Array<RLMObject> = []
    var seleOtherDepartArray:Array<RLMObject> = []

    //是否是部门数据
    var isDepartmentData:Bool = true
    
    var isLoadDepartData  = false
    var isLoadOtherDepartData = false
    @objc override func rightBtnClick(button: UIButton) {
        
        if isDepartmentData {
            if self.seleDepartArray.count == 0 {return}
        }
        
        if !isDepartmentData {
            if self.seleOtherDepartArray.count == 0 {return}
        }
        
        let alert = UIAlertController.init(title: "群组名称", message: "请输入创建的群组名称", preferredStyle: .alert)
                   alert.addTextField { (textField) in
                       textField.placeholder = "请输入群组名称"
                   }
                   
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (cancelAction) in
            let isOpenVC = GroupIsOpenVC()
            isOpenVC.userArray = self.isDepartmentData ? self.seleDepartArray : self.seleOtherDepartArray
            self.navigationController?.pushViewController(isOpenVC, animated: true)
        }
                   
                   let okAction = UIAlertAction.init(title: "确认", style: .default) { (okAction) in
                      let isOpenVC = GroupIsOpenVC()
                      isOpenVC.groupName = alert.textFields?.first?.text
                      isOpenVC.userArray = self.isDepartmentData ? self.seleDepartArray : self.seleOtherDepartArray
                      self.navigationController?.pushViewController(isOpenVC, animated: true)
                   }
                   
                   alert.addAction(cancelAction)
                   alert.addAction(okAction)
                   self.present(alert, animated: true, completion: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "选择成员"
        
        view.backgroundColor = UIColor.white
        self.setRightBtnWithArray(items: ["确定"])
        
        self.createUI()
        
        
        //加载数据
        self.loadData()
    }
    
    
    func createUI() {
        
        view.addSubview(topBtnView)
        topBtnView.addSubview(departmentBtn)
        topBtnView.addSubview(otherDepartmentBtn)
        topBtnView.addSubview(topBtmLine)
        view.addSubview(searchView)
        view.addSubview(listTable)
        
        topBtnView.mas_makeConstraints { (make) in
            make?.left.right().equalTo()(view)
            make?.top.equalTo()(NAV_HEIGHT+heightOfAddtionalHeader)
            make?.height.equalTo()(55.0)
        }
        
        departmentBtn.mas_makeConstraints { (make) in
            make?.top.left().equalTo()(topBtnView)
            make?.width.equalTo()(topBtnView.mas_width)?.multipliedBy()(0.5)
            make?.bottom.equalTo()(-5.0)
        }
        
        otherDepartmentBtn.mas_makeConstraints { (make) in
            make!.top.centerY().width().height().equalTo()(departmentBtn)
            make?.right.equalTo()(topBtnView)
        }
        
        topBtmLine.mas_makeConstraints { (make) in
            make?.width.equalTo()(departmentBtn)
            make?.height.equalTo()(3)
            make?.bottom.equalTo()(topBtnView)?.offset()(-5)
        }
        searchView.mas_makeConstraints { (make) in
            make?.left.centerX()?.right()?.equalTo()(view)
            make?.height.equalTo()(50.0)
            make?.top.equalTo()(topBtnView.mas_bottom)
        }
        
        
        listTable.mas_makeConstraints { (make) in
            make?.top.equalTo()(searchView.mas_bottom)
            make?.left.right()?.centerX()?.equalTo()(view)
            make?.bottom.equalTo()(view)
        }
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    if !isDepartmentData {
        return otherDepartDataArray != nil ?Int((otherDepartDataArray?.count)!): 0
    }
    return departDataArray != nil ?Int((departDataArray?.count)!): 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil
        {
           
            let path:String? = Bundle.main.path(forResource: "BaseTableCell", ofType: "nib")
            if path == nil {
               let  aClass  = getClassWitnClassName("BaseTableCell") as! UITableViewCell.Type
                cell = aClass.init(style: .default, reuseIdentifier: "BaseTableCell")
            }
            else
            {
                cell = Bundle.main.loadNibNamed("BaseTableCell", owner: self, options: nil)?.last as! UITableViewCell?
                
            }

        }
        
        var model:RLMObject?
            
        if isDepartmentData {
            
            model = departDataArray![Int(indexPath.row)]
        }else {
            
            model = otherDepartDataArray![Int(indexPath.row)]
        }
            
        cell?.setValue(model, forKey: "model")
    
        let bCell = cell as! BaseTableCell
        bCell.delegate = self

        bCell.rightBtn.isHidden = true
        bCell.rightBtn.isHidden = true
        
        var seleMemberArray:Array<RLMObject>?
        if isDepartmentData {
            seleMemberArray = self.seleDepartArray
        }else {
            seleMemberArray = self.seleOtherDepartArray
        }
        
        bCell.selectImage.image = UIImage.init(named: "logic_normal")
        
        if seleMemberArray?.count ?? 0 > 0 {
            if (seleMemberArray?.contains(where: { (m) -> Bool in
                return (m as! FriendsModel).userid == (model as! FriendsModel).userid
            }))!{
                
                bCell.selectImage.image = UIImage.init(named: "logic_select")
            }
        }
        
//        if ((isDepartmentData ? seleDepartArray : seleOtherDepartArray)?.contains(where: { (m) -> Bool in
//            return (m as! FriendsModel).userid == (model as! FriendsModel).userid
//        }))!{
//            bCell.selectImage.backgroundColor = UIColor.green
//        }
//        else
//        {
//            bCell.selectImage.backgroundColor = UIColor.red
//            bCell.selectImage.image = UIImage.init(named: "logic_normal")
//        }
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:FriendsModel = (isDepartmentData ? departDataArray : otherDepartDataArray)?[Int(indexPath.row)] as! FriendsModel
        
        let index = (isDepartmentData ? seleDepartArray : seleOtherDepartArray).firstIndex(where: { (m) -> Bool in
             return (m as! FriendsModel).userid == model.userid
         })
         if (index != nil) {
            
            if isDepartmentData {
                seleDepartArray.remove(at: index!)
            }else {
                seleOtherDepartArray.remove(at: index!)
            }
            
         }
         else
         {
            if isDepartmentData {
                seleDepartArray.append(model)
            }else {
                seleOtherDepartArray.append(model)
            }
             
         }
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    //点击申请加入按钮
    func cellRightBtnClick(model: RLMObject) {
        
    }
    
    fileprivate lazy var topBtnView: UIView = {
        var topBtnView = UIView()
        topBtnView.backgroundColor = UIColor.groupTableViewBackground
        return topBtnView
    }()
    
     lazy var searchView: UISearchBar = {
        var searchView = UISearchBar.init()
        
        searchView.placeholder = "请输入用户名（邮箱/手机号）"
        searchView.returnKeyType = .search
        searchView.delegate = self
        if #available(iOS 13.0, *) {
            searchView.searchTextField.font = FONT_14
        }
        return searchView
    }()
    
    fileprivate lazy var departmentBtn: UIButton = {
        var departmentBtn = UIButton.init()
        departmentBtn.setTitleColor(UIColor.hexString(hexString: "333333"), for: .normal)
        departmentBtn.setTitleColor(UIColor.hexString(hexString: "1972D8"), for: .selected)
        departmentBtn.titleLabel?.font = FONT_14
        departmentBtn.setTitle("搜本部门", for: .normal)
        departmentBtn.addTarget(self, action: #selector(searchBtnClick(_ :)), for: .touchUpInside)
        departmentBtn.isSelected = true
        departmentBtn.tag = 100
        return departmentBtn
    }()
    
    
    fileprivate lazy var otherDepartmentBtn: UIButton = {
        var otherDepartmentBtn = UIButton.init()
        otherDepartmentBtn.setTitleColor(UIColor.hexString(hexString: "333333"), for: .normal)
        otherDepartmentBtn.setTitleColor(UIColor.hexString(hexString: "1972D8"),for: .selected)
        otherDepartmentBtn.titleLabel?.font = FONT_14
        otherDepartmentBtn.setTitle("搜其他部门", for: .normal)
        otherDepartmentBtn.addTarget(self, action: #selector(searchBtnClick(_ :)), for: .touchUpInside)
        otherDepartmentBtn.tag = 101
        return otherDepartmentBtn
    }()
    
    fileprivate lazy var topBtmLine: UIView = {
        var topBtmLine = UIView.init()
        topBtmLine.backgroundColor = UIColor.hexString(hexString: "1972D8")
        
        return topBtmLine
    }()
    
    lazy var  listTable: UITableView = {
        var listTable = UITableView.init(frame: .zero, style: .plain)
        listTable.delegate = self
        listTable.dataSource = self
        
        listTable.tableFooterView = UIView.init()
        self.automaticallyAdjustsScrollViewInsets = false
        listTable.backgroundColor = UIColor.groupTableViewBackground
        let path:String? = Bundle.main.path(forResource: "BaseTableCell", ofType: "nib")
               
               
               if path == nil {
                   
                   listTable.register(NSClassFromString("BaseTableCell"), forCellReuseIdentifier: "BaseTableCell")
               }
               else
               {
                   listTable.register(UINib.init(nibName: "BaseTableCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
               }
               
               listTable.rowHeight = 50
        return listTable
    }()
    
    
    //MARK: 搜索按钮点击
    @objc func searchBtnClick(_ btn:UIButton) {
        self.view.endEditing(true)
        
        departmentBtn.isSelected = false
        otherDepartmentBtn.isSelected = false
        btn.isSelected = true
        
        UIView.animate(withDuration: 0.25) {
            self.topBtmLine.mas_updateConstraints { (make) in
                make?.left.equalTo()(CGFloat((btn.tag-100))*kScreenW/2.0)
            }
            
            self.topBtmLine.superview?.layoutIfNeeded()
        }
        
        if btn.tag == 100 {
            //部门人员
            if isDepartmentData {
                return;
            }
            
            isDepartmentData = true
            if !isLoadDepartData {
                self.loadData()
            }
            
        }else {
            //其他部门人员
            if !isDepartmentData {
                return;
            }
            
            isDepartmentData = false
            if !isLoadOtherDepartData {
                self.loadData()
            }
            
        }
        
        listTable.reloadData()
    }

    //MARK: 请求列表数据
    /**
     type 查询类型（0:不限；1：本部门；2：非本部门）
     */
    func loadData()  {
        var params = Dictionary<String, Any>()
        params["app_token"] = sharePublicDataSingle.token
        params["keyword"] = searchView.text ?? ""
        params["type"] = (isDepartmentData) ? 1 : 2
        UserRequest.coachSearchUser(params: params, hadToast: true, fail: { (Error) in
                    print(Error.localizedDescription)
                }) {[weak self] (success) in
                    
                    print("获取部门列表\(success)");
                    
                    if let code = success["code"] {
                        if "\(code)" != "1" {
                            self?.showAlert(content: success["msg"] as! String)
                            return
                        }
                    }
                    
//                    获取部门列表["user_list": <__NSArray0 0x7fff8062d570>(
//
//                    )
//                    , "keyword": , "count": 0]
                    
                    let user_list = success["user_list"] as! [Dictionary<String, Any>]
                    
                    var list:Array<RLMObject> = []
                    
                    for any in user_list {
                        let model = FriendsModel.init(value: any)
                        list.append(model)
                    }
                    
                    
                    if !self!.isDepartmentData {
                        self?.isLoadOtherDepartData = true
                        self?.otherDepartDataArray =  list 
                    }else {
                        self?.isLoadDepartData = true
                        self?.departDataArray =  list
                    }
                    
                    self?.listTable.reloadData()
                    
                }
    }
    
    
    
    //刘海屏额外的高度
    let heightOfAddtionalHeader:CGFloat = {
        var heightOfAddtionalHeader = 0.0
        
        if UIDevice.current.isiPhoneXorLater() {
            heightOfAddtionalHeader = 24.0
        }
        return CGFloat(heightOfAddtionalHeader)
    }()
    
    //MARK:UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        
        if searchBar.text!.count > 0 {
            self.loadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIDevice {
    //判断设备是不是iPhoneX以及以上
    
    public func isiPhoneXorLater() ->Bool {
        let screenHieght = UIScreen.main.nativeBounds.size.height
        
        if screenHieght == 2436 || screenHieght == 1792 || screenHieght == 2688 || screenHieght == 1624 {
            return true
        }
        
        return false
    }
}
