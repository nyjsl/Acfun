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
//        self.mineTableView.backgroundView = nil
//        self.mineTableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
//        self.mineTableView.isOpaque = false
        
        self.mineTableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "ac_mine_bg"))
        self.mineTableView.sectionFooterHeight = 0.0
        self.mineTableView.showsVerticalScrollIndicator = false
        self.mineTableView.showsHorizontalScrollIndicator = false
        contentOffSet = self.mineTableView.contentOffset
    }
    
    var contentOffSet:CGPoint?
    
    @IBOutlet weak var bgViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!
    
    var cellHeight:CGFloat = 0.0{
        didSet{
            if oldValue != cellHeight{
                self.mineTableView.reloadData()
                contentOffSet = self.mineTableView.contentOffset
 
            }
        }
    }
    
    
}

extension MineViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        if contentOffSet?.y == -20{
            let offSet = scrollView.contentOffset.y - (contentOffSet?.y)!
            bgViewHeightConstraint.constant = offSet
            
        }
        
    }
    
    
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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            if cellHeight != 0 {
                var tableCellsHeight:CGFloat = 0.0
                for i in 0 ..< cellDatas.count{
                    tableCellsHeight += 4
                    for _ in 0 ..< cellDatas[i].count{
                        tableCellsHeight += cellHeight
                    }
                }
                return Constants.SCREEN_FRAME.size.height.advanced(by:  -tableCellsHeight).advanced(by: -Constants.TAB_BAR_FRAM.size.height-Constants.STATUSBAR_FRAME.size.height)
            }else{
                return Constants.SCREEN_FRAME.size.height.divided(by: 2)

            }
        }else{
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == cellDatas.count - 1{
            return 4
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = MineHeaderView.genereate()
            var frame = view?.frame
            frame?.size.height = Constants.SCREEN_FRAME.size.height.divided(by: 2)
            view?.frame = frame!
            return view
        }else{
            let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.mineTableView.bounds.size.width, height: 4.0))
            view.backgroundColor = UIColor.groupTableViewBackground
            return view
        }
        
    }
    
   
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.mineTableView.bounds.size.width, height: 4.0))
        view.backgroundColor = UIColor.groupTableViewBackground
        
        return view
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
        cellHeight = cell.frame.size.height
        return cell
    }
}
