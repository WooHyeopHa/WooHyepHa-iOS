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
        let item: UITabBarItem
        switch self {
        case .home:
            item = UITabBarItem(title: "홈", image: UIImage(named: "tabbar_home_inactive")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar_home_active")?.withRenderingMode(.alwaysOriginal))
        case .mating:
            item = UITabBarItem(title: "뮤즈찾기", image: UIImage(named: "tabbar_muse_inactive")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar_muse_active")?.withRenderingMode(.alwaysOriginal))
        case .map:
            item = UITabBarItem(title: "지도", image: UIImage(named: "tabbar_map_inactive")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar_map_active")?.withRenderingMode(.alwaysOriginal))
        case .chat:
            item = UITabBarItem(title: "채팅", image: UIImage(named: "tabbar_chat_inactive")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar_chat_active")?.withRenderingMode(.alwaysOriginal))
        case .mypage:
            item = UITabBarItem(title: "마이페이지", image: UIImage(named: "tabbar_mypage_inactive")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tabbar_mypage_active")?.withRenderingMode(.alwaysOriginal))
        }
        
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray5], for: .normal)
        
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray1], for: .selected)
        
        return item
    }
}
