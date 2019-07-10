//
//  InfiniteTabPageViewController.swift
//  TabPageViewController
//
//  Created by Tomoya Hayakawa on 2017/08/05.
//
//

import UIKit
import TabPageViewController

class InfiniteTabPageViewController: TabPageViewController {
    
    override init() {
        super.init()
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController")
        vc1.view.backgroundColor = UIColor(red: 251/255, green: 252/255, blue: 149/255, alpha: 1.0)
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor(red: 252/255, green: 150/255, blue: 149/255, alpha: 1.0)
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor(red: 149/255, green: 218/255, blue: 252/255, alpha: 1.0)
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor(red: 149/255, green: 252/255, blue: 197/255, alpha: 1.0)
        let vc5 = UITableViewController(style: .plain)
        vc5.view.backgroundColor = UIColor(red: 252/255, green: 182/255, blue: 106/255, alpha: 1.0)
        tabItems = [
            (vc1, TabItem(title: "Mon", icon: UIImage(named: "Search"))),
            (vc2, TabItem(title: "Tue.")),
            (vc3, TabItem(title: "Wed.")),
            (vc4, TabItem(title: "Thu.")),
            (vc5, TabItem(title: "Fri."))
        ]
        isInfinity = true
        
//        option.tabBackgroundColor = UIColor(red: 241.0 / 255.0, green: 107.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
        option.tabBackgroundColor = nil
        option.tabHeight = 44
        option.defaultColor = UIColor.white
        option.currentColor = UIColor(red: 241.0 / 255.0, green: 107.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
        option.markerStyle = .rounded(height: 24)
        option.tabWidth = 110
        option.isTranslucent = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = tabView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(red: 241.0 / 255.0, green: 107.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
    }
}
