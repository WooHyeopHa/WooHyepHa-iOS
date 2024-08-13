//
//  TabBarItemType.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/13/24.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case home = 0, mating, map, chat, mypage
}

extension TabBarItemType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: "", image: UIImage(named: "tabbar_home_inactive")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar_home_active")?.withRenderingMode(.alwaysOriginal))
        case .mating:
            return UITabBarItem(title: "", image: UIImage(named: "tabbar_mating_inactive")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar_mating_active")?.withRenderingMode(.alwaysOriginal))
        case .map:
            return UITabBarItem(title: "", image: UIImage(named: "tabbar_map_inactive")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar_map_active")?.withRenderingMode(.alwaysOriginal))
        case .chat:
            return UITabBarItem(title: "", image: UIImage(named: "test1")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "test2")?.withRenderingMode(.alwaysOriginal))
        case .mypage:
            return UITabBarItem(title: "", image: UIImage(named: "tabbar_mypage_inactive")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar_mypage_active")?.withRenderingMode(.alwaysOriginal))
        }
    }
}
