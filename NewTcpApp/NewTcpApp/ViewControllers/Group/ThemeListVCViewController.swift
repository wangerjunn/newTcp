//
//  ThemeListVCViewController.swift
//  GroupChatPlungSwiftPro
//
//  Created by harry on 17/3/8.
//  Copyright © 2017年 柴进. All rights reserved.
//

import UIKit

class ThemeListVCViewController: BaseViewController {

    var table:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
        
    }

    func configUI(){
       table = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH-64-49), style: .plain)
       view.addSubview(table!)
       table?.dataSource = self
       table?.delegate = self
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


extension ThemeListVCViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIde = "cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIde)
        if cell == nil  {
            
           cell = (Bundle.main.loadNibNamed("ThemeListCell", owner: self, options:nil)?.last as! ThemeListCell?)!
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rcb = ThemeChatVC.init(conversationType: RCConversationType.ConversationType_PRIVATE, targetId: "2222")
        
            self.navigationController?.pushViewController(rcb!, animated: true)
    }
}
