//
//  ChatCoordinator.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 8/13/24.
//

import UIKit

final class ChatCoordinator: Coordinator {
   weak  var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToChatViewController()
    }
}

private extension ChatCoordinator {
    func goToChatViewController() {
        let chatViewController = ChatViewController()
        navigationController.pushViewController(chatViewController, animated: true)
    }
}
