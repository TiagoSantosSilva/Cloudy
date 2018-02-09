//
//  AddLocationViewController.swift
//  Cloudy
//
//  Created by Tiago Santos on 06/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol AddLocationViewControllerDelegate {
    func controller(_ controller: AddLocationViewController, didAddLocation location: Location)
}

class AddLocationViewController: UIViewController {

    // MARK: - View Components
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Delegates
    
    var delegate: AddLocationViewControllerDelegate?
    
    // MARK: - View Model
    
    var viewModel: AddLocationViewModel!
    
    // MARK: - Dispose Bag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupView()
    }
    
    // MARK: - View Model Functions
    
    func setupViewModel() {
        viewModel = AddLocationViewModel(query: searchBar.rx.text.orEmpty.asDriver())
        
        viewModel.locations
            .drive(onNext: { [unowned self] (_) in
                // Update Table View
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // Drive Activity Indicator View
        viewModel.querying.drive(activityIndicatorView.rx.isAnimating).disposed(by: disposeBag)
    }
    
    // MARK: - Setups
    
    func setupView() {
        title = "Add Location"
        registerLocationCell()
        setupDelegates()
        setupSearchBar()
    }
    
    func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    func registerLocationCell() {
        let cellNib = UINib(nibName: LocationCell.nibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: LocationCell.reuseIdentifier)
    }
    
    // TODO: - Setup the search bar.
    func setupSearchBar() {
        searchBar.becomeFirstResponder()
        
        // Search Button Clicked
        searchBar.rx.searchButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [unowned self] in
                self.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        // Cancel Button Clicked
        searchBar.rx.cancelButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [unowned self] in
                self.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
    
    // TODO: - Setup 'Back' and 'Done' buttons.
    func setupNavigationButtons() {
        
    }
}

extension AddLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLocations
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseIdentifier, for: indexPath) as? LocationCell else {
            fatalError("Unexpected Table View Cell")
        }
        
        guard let viewModel = viewModel.viewModelForLocation(at: indexPath.row) else {
            return cell
        }
        
        cell.configure(withViewModel: viewModel)
        return cell
    }
}

extension AddLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let location = viewModel.location(at: indexPath.row) else { return }
        
        // Notify Delegate
        delegate?.controller(self, didAddLocation: location)
        
        // Pop View Controller From Navigation Stack
        navigationController?.popViewController(animated: true)
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    
}
