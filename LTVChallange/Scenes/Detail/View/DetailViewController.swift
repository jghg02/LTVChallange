//
//  DetailViewController.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 11-12-21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    
    var url: String?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var webView: WKWebView!
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        
        guard let url = url else { return }
        let myUrl = URL(string: url)
        let request = URLRequest(url: myUrl!)
        webView.load(request)
        
    }

    // MARK: - Methods
    
    func configNavBar() {
        title = "Detail"
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: - Actions
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }


}
