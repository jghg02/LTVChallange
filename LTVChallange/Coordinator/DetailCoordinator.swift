//
//  DetailCoordinator.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 11-12-21.
//

import UIKit

class DetailCoordinator: Coordinator {
    
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .detail }
    
    var webUrl: String?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DetailViewController()
        vc.url = webUrl
        let navBar = UINavigationController(rootViewController: vc)
        self.navigationController.present(navBar, animated: true, completion: nil)
    }
    
}
