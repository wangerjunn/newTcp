//
//  BaseTableVC.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/10.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit
import Realm

class BaseTableVC: BaseViewController {

    var memberArray:Array<GroupUserModel>?
    
    var table:UITableView?
    
     var cellName:String?
    
     var modelName:String?
    
    //基础数据源
    var allDataArray:RLMResults<RLMObject>?
    
    //当前显示的数据源
    var dataArray:RLMResults<RLMObject>?
    
    
    
    //搜索结果数据源
     var searchArray:Array<RLMObject>?
    
    //是否显示搜索框
     var isShowSearch:Bool?
    
    //定义cell高度   没有做高度自动处理（目前看到的界面没有必要去做，后续添加）
    fileprivate var cellHeight:CGFloat?
    
    //选中结果集
     var selectedArray:Array<RLMObject>?
    
    
    var searchView:BaseSearchView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.configUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: - ---------------------相关初始化----------------------

extension BaseTableVC{

    
   
   /// UI初始化
   fileprivate func configUI()
   {
    
    self.view.backgroundColor = UIColor.groupTableViewBackground
    
    selectedArray = Array()
    
    table = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: kScreenW, height: kScreenH-64))
    table?.backgroundColor = UIColor.groupTableViewBackground
    self.view.addSubview(table!)
    table?.delegate = self;
    table?.dataSource = self;
    table?.tableFooterView = UIView.init()
    self.automaticallyAdjustsScrollViewInsets = false
    
   }
    
    
    
}


//MARK: - ---------------------TableDelegate AND DataSource----------------------
extension BaseTableVC:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (cellHeight != nil) {
            return cellHeight!
        }
        else
        {
            return 44
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray != nil ?Int((dataArray?.count)!): 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil
        {
           
            let path:String? = Bundle.main.path(forResource: cellName, ofType: "nib")
            if path == nil {
               let  aClass  = getClassWitnClassName(cellName!) as! UITableViewCell.Type
                cell = aClass.init(style: .default, reuseIdentifier: cellName)
            }
            else
            {
                cell = Bundle.main.loadNibNamed(cellName!, owner: self, options: nil)?.last as! UITableViewCell?
                
            }

        }
        
        let model:RLMObject = self.dataArray![UInt(indexPath.row)]
        cell?.setValue(model, forKey: "model")
        
        
        if cell is  BaseTableCell {
            let bCell = cell as! BaseTableCell
            bCell.delegate = self
            
            //MARK: - ---------------------一段垃圾代码  先这么写  要整个整理这个类----------------------
            if model is FriendsModel {
                
                bCell.rightBtn.isHidden = true
                if (self.selectedArray?.contains(where: { (m) -> Bool in
                    return (m as! FriendsModel).userid == (model as! FriendsModel).userid
                }))!{
                    
                    bCell.selectImage.image = UIImage.init(named: "logic_select")
//                    bCell.selectImage.backgroundColor = UIColor.green
                }
                else
                {
                    bCell.selectImage.image = UIImage.init(named: "logic_normal")
//                    bCell.selectImage.backgroundColor = UIColor.red
                }
                
                
                if (self.memberArray?.contains(where: { (m) -> Bool in
                    return m.userid == (model as!FriendsModel).userid
                }) == true) {
                     bCell.selectImage.image = UIImage.init(named: "logic_normal")
                }
                
            }
            else if (model is GroupUserModel){
            //删除群成员
                if (self.selectedArray?.contains(where: { (m) -> Bool in
                    return (m as! GroupUserModel).userid == (model as! GroupUserModel).userid
                }))!{
                    
                    
                    bCell.selectImage.image = UIImage.init(named: "logic_select")
                }
                else
                {
                    bCell.selectImage.image = UIImage.init(named: "logic_normal")
                }
                
                
                if (self.memberArray?.contains(where: { (m) -> Bool in
                    return m.userid == (model as!GroupUserModel).userid
                }) == true) {
//                    bCell.selectImage.backgroundColor = UIColor.yellow
                }

                
                
            }
            
            
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


//MARK: - ---------------------使用该类需要用到的方法----------------------
extension BaseTableVC
{

    
    /// 初始化配置
    ///
    /// - Parameters:
    ///   - fromCellName: cell 名称
    ///   - fromIsShowSearch: 是否有搜索框
    ///   - fromSearchType: 搜索框是否显示选择项目
    ///   - fromCellHeight: cell高度
    func configUIWith(fromCellName:String,fromIsShowSearch:Bool,fromSearchType:Bool,fromCellHeight:CGFloat)
    {
        self.cellName = fromCellName
        guard self.cellName != nil else {
            return
        }
        let path:String? = Bundle.main.path(forResource: cellName, ofType: "nib")
        
        
        if path == nil {
            
            self.table?.register(NSClassFromString(cellName!), forCellReuseIdentifier: cellName!)
        }
        else
        {
            self.table?.register(UINib.init(nibName: cellName!, bundle: Bundle.main), forCellReuseIdentifier: "cell")
        }
        
        self.cellHeight = fromCellHeight
        self.isShowSearch = fromIsShowSearch

        if self.isShowSearch! {
            searchArray = Array()
            searchView = Bundle.main.loadNibNamed("BaseSearchView", owner: self, options: nil)?.last as? BaseSearchView
            searchView?.frame = CGRect.init(x: 0, y: 64, width: kScreenW, height: 50)
            searchView?.configCollectionViewWith(isShowCollect: fromSearchType)
            searchView?.delegate = self
            self.view.addSubview(searchView!)
            
            self.table?.frame = CGRect.init(x: 0, y:50+64, width: kScreenW, height:kScreenH-64-50)
            
        }
        
        
        
        
    }
    
    
    
    
    /// 添加数据
    ///
    /// - Parameter dataArray: 要显示的数据
    func setDataArray(dataArray:RLMResults<RLMObject>)
    {
        self.allDataArray = dataArray
        self.dataArray = dataArray
        self.table?.reloadData()
    
    }
}

extension BaseTableVC:BaseSearchViewDelegate
{
    @objc func searchDeleteItem(item: RLMObject)
    {
    }

    func searchBarTextChangedWith(nowText:String)
    {
        
    }
    
    
    
//    //获取工程的名字
//    func getBundleName() -> String{
//        var bundlePath = Bundle.main.bundlePath
//        bundlePath = bundlePath.components(separatedBy: "/").last!
//        bundlePath = bundlePath.components(separatedBy: ".").first!
//        return bundlePath
//    }
//    //通过类名返回一个AnyClass
//    func getClassWitnClassName(_ name:String) ->AnyClass?{
//        let type = getBundleName() + "." + name
//        return NSClassFromString(type)
//    }

    
    
   
    
}

extension BaseTableVC:BaseCellDelegate{
    
    /// cell右边按钮点击
    ///
    /// - Parameter model: <#model description#>
    func cellRightBtnClick(model: RLMObject) {
        
    }
}
