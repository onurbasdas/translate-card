//
//  TabBarViewController.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 8.09.2021.
//

import UIKit
import AMTabView

class TabBarViewController: AMTabsViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setTabsControllers()
    selectedTabIndex = 0
  }

  private func setTabsControllers() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let uploadViewController = storyboard.instantiateViewController(withIdentifier: "one")
    let feedViewController = storyboard.instantiateViewController(withIdentifier: "navTest")
    let settingskViewController = storyboard.instantiateViewController(withIdentifier: "three")

    viewControllers = [
      uploadViewController,
      feedViewController,
      settingskViewController
    ]
  }
}
