//
//  AppCoordinator.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 09-12-21.
//

import UIKit

/// Define what type of flows can be started from this Coordinator
protocol AppCoordinatorProtocol: Coordinator {
    func showMainView()
}

/// App coordinator is the only one coordinator which will exist during app's life cycle
class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .app }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func start() {
        showMainView()
    }
    
    func showMainView() {
        let tabBarCoordinator = TabCoordinator.init(navigationController)
        tabBarCoordinator.finishDelegate = self
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
        
  
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()

        default:
            break
        }
    }
}


