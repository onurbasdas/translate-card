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
    let graveViewController = storyboard.instantiateViewController(withIdentifier: "one")
    let bumpkinViewController = storyboard.instantiateViewController(withIdentifier: "navTest")
    let fireworkViewController = storyboard.instantiateViewController(withIdentifier: "three")

    viewControllers = [
      graveViewController,
      bumpkinViewController,
      fireworkViewController
    ]
  }
}
