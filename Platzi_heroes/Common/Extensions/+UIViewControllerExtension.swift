//
//  +UIViewControllerExtension.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import Foundation
import UIKit

extension UIViewController {
  func configureNavigationBarInViewController(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.configureWithOpaqueBackground()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
      navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
      navBarAppearance.backgroundColor = backgoundColor
      navigationController?.navigationBar.standardAppearance = navBarAppearance
      navigationController?.navigationBar.compactAppearance = navBarAppearance
      navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
      navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
      navigationController?.navigationBar.isTranslucent = false
      navigationController?.navigationBar.tintColor = tintColor
      navigationItem.title = title
    } else {
      // Fallback on earlier versions
      navigationController?.navigationBar.barTintColor = backgoundColor
      navigationController?.navigationBar.tintColor = tintColor
      navigationController?.navigationBar.isTranslucent = false
      navigationItem.title = title
    }
  }
}
