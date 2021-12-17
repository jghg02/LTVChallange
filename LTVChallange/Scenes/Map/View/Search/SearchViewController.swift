//
//  SearchViewController.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 13-12-21.
//

import UIKit
import CoreLocation

protocol SearchViewControllerDelegate: AnyObject {
    func didTapPlace(with coordinates: CLLocationCoordinate2D)
}


class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    private var viewModel: MapViewModel!
    weak var delegate: SearchViewControllerDelegate?
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    

    private var places = [Place]()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MapViewModel()
        
        view.addSubview(tableView)
        view.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Methods
    
    public func update(with places: [Place]) {
        self.tableView.isHidden = false
        self.places = places
        tableView.reloadData()
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = places[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isHidden = true
        let placeSelected = places[indexPath.row]
        viewModel.resolveLocation(for: placeSelected) {  [weak self] result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self?.delegate?.didTapPlace(with: result)
                }
            case .failure(let error):
                print(error)
            }
                
        }
        
    }
}
