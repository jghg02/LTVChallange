//
//  BlogViewController.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 09-12-21.
//

import UIKit

class BlogViewController: UIViewController {

    // MARK: - Properties
    
    private let viewModel = BlogViewModel()
    private var data: Articles?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigationBar()
        viewModel.fetchArticlesData()
        
        tableView.register(UINib(nibName: "BlogTableViewCell", bundle: nil), forCellReuseIdentifier: "BlogTableViewCell")
        
        viewModel.data.bind { [weak self] data in
            self?.data = data
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Methods
    
    func configNavigationBar() {
        title = "Blog"
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UITableViewDataSource
extension BlogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articles = self.data?.articles else { return 0 }
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogTableViewCell", for: indexPath)
        guard let blogCell = cell as? BlogTableViewCell else { return UITableViewCell() }
        blogCell.configCell(with: (self.data?.articles[indexPath.row])!)
        
        return blogCell
    }
}

// MARK: - UITableViewDelegate
extension BlogViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellTapped = self.data?.articles[indexPath.row] else { return }
        
        let detailCoordinator = DetailCoordinator(self.navigationController!)
        detailCoordinator.webUrl = cellTapped.link
        detailCoordinator.start()
        
    }
    
}
