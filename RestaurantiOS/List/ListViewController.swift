//
//  ViewController.swift
//  RestaurantiOS
//
//  Created by Marcelo Fernandez on 05/09/2022.
//

import UIKit
import Combine

class ListViewController: UIViewController {

    let activityIndicator = UIActivityIndicatorView()
    private var restaurantsTableView: UITableView!
    let listViewModel = ListViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureActivityIndicator()
        configureTableView()
        bind()
        listViewModel.getRestaurants()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func configureTableView() {
        let barHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let screenHeight = view.frame.height
        let screenWidth = view.frame.width
        
        restaurantsTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: screenWidth, height: screenHeight - barHeight))
        restaurantsTableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
        view.addSubview(restaurantsTableView)
    }
    
    private func bind() {
        listViewModel.$errorMessage
            .dropFirst()
            .sink { [weak self] errorMessage in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.showErrorWith(message: errorMessage ?? "")
                }
            }
            .store(in: &cancellables)
        
        listViewModel.$dataArray
            .sink { [weak self] restaurants in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.restaurantsTableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    private func setConstraints() {
        let constraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 40),
            activityIndicator.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func showErrorWith(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as! RestaurantTableViewCell
        let item = listViewModel.dataArray[indexPath.row]
        cell.configureCellWith(model: RestaurantCellModel.fromServiceModel(item))
        return cell
    }
    
    
}
