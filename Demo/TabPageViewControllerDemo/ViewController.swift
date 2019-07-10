//
//  ViewController.swift
//  TabPageViewController
//
//  Created by EndouMari on 03/19/2016.
//  Copyright (c) 2016 EndouMari. All rights reserved.
//

import UIKit
import TabPageViewController

class ViewController: UIViewController {

    @IBAction func LimitedButton(_ button: UIButton) {
        let tc = LimitedTabPageViewController()
        navigationController?.pushViewController(tc, animated: true)
    }

    @IBAction func InfinityButton(_ button: UIButton) {
        let tc = InfiniteTabPageViewController()
        
        let navi = storyboard?.instantiateViewController(withIdentifier: "NavigationController") as? NavigationController
        navi?.pushViewController(tc, animated: false)
        
        present(navi!, animated: true)
    }
}
