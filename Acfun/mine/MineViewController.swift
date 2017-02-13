//
//  MineViewController.swift
//  Acfun
//
//  Created by 魏星 on 2017/1/18.
//  Copyright © 2017年 wx. All rights reserved.
//

import UIKit
//我的
class MineViewController: UIViewController {

    
    @IBOutlet weak var mineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setUpTableview()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    private func setupNavBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setUpTableview(){
        self.mineTableView.delegate = self
        self.mineTableView.dataSource = self
        self.mineTableView.backgroundView = nil
        self.mineTableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.mineTableView.isOpaque = false
        
    }
    
}

extension MineViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    var cellDatas:[[MineTableCellModel]] {
        return [
            [MineTableCellModel(icon: #imageLiteral(resourceName: "ic_collection"), title: "我的收藏", rightDesc:"登陆解开封印"),
            MineTableCellModel(icon: #imageLiteral(resourceName: "ic_history"), title: "历史记录", rightDesc:nil),
            MineTableCellModel(icon: #imageLiteral(resourceName: "ic_download"), title: "离线缓存", rightDesc:nil)]
            ,[MineTableCellModel(icon: #imageLiteral(resourceName: "ic_setting"), title: "设置", rightDesc:nil),
              MineTableCellModel(icon: #imageLiteral(resourceName: "ic_feedback"), title: "意见反馈", rightDesc:nil)]
            ,[MineTableCellModel(icon: #imageLiteral(resourceName: "my_game_center_color_gray"), title: "游戏中心", rightDesc:nil)]
        ]
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDatas[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellDatas[indexPath.section][indexPath.row]
        
        var cell: UITableViewCell

        if let desc = model.rightDesc{
            if let mineCell = tableView.dequeueReusableCell(withIdentifier: "MineCell"){
                cell = mineCell
            }else{
                cell = UITableViewCell(style: .value1, reuseIdentifier: "MineCell")
            }
            
            cell.detailTextLabel?.text = desc
            cell.accessoryType = .none

        }else{
            if let mineCell = tableView.dequeueReusableCell(withIdentifier: "MineCell"){
                cell = mineCell
            }else{
                cell = UITableViewCell(style: .default, reuseIdentifier: "MineCell")
            }
            cell.accessoryType = .disclosureIndicator

        }
        cell.textLabel?.text = model.title
        cell.imageView?.image = model.icon
        return cell
    }
}
