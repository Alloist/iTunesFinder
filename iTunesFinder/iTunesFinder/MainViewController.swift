//
//  ViewController.swift
//  iTunesFinder
//
//  Created by Aliaksei Gorodji on 27.05.22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let searchBar = UISearchController()
    private let tableView = UITableView()
    private let moreBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "ellipsis")
        return button
    }()
    private let backgroundSegmentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let segmentController: UISegmentedControl = {
        let controller = UISegmentedControl(items: [MediaType.music.rawValue.capitalized,
                                                    MediaType.software.rawValue.capitalized,
                                                    MediaType.ebook.rawValue.capitalized])
        controller.selectedSegmentIndex = 0
        controller.tintColor = .clear
        controller.backgroundColor = .white
        controller.addTarget(self, action: #selector(segmentedControllerActionHandler(_:)), for: .valueChanged)
        return controller
    }()
    
    private let viewModel = MainViewControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configure()
        bindViewModel()
        viewModel.setMediaType(index: 0)
    }
    
    private func bindViewModel() {
        viewModel.dataHasBeenUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}


//MARK: - UI
private extension MainViewController {
    
    func configure() {
        view.backgroundColor = .white
        addSubviews()
        setupTableView()
        setupConstraints()
        setupActions()
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(backgroundSegmentView)
        backgroundSegmentView.addSubview(segmentController)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = "iTunes Finder"
        navigationItem.searchController = searchBar
        navigationItem.rightBarButtonItem = moreBarButton
        searchBar.searchBar.delegate = self
    }
    
    func setupTableView() {
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MediaItemTableViewCell.self, forCellReuseIdentifier: MediaItemTableViewCell.reuseIdentifier)
        tableView.separatorInset.left = 0
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(55)
            $0.right.left.equalToSuperview()
            $0.bottom.equalToSuperview().inset(65)
        }
        
        backgroundSegmentView.snp.makeConstraints {
            $0.height.equalTo(65)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        segmentController.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }
    
    func setupActions() {
        moreBarButton.target = self
        moreBarButton.action = #selector(moreButtonAction(_:))
    }
        
}

//MARK: - Actions
extension MainViewController {
    @objc func moreButtonAction(_ sender: UIBarButtonItem) {
        print("Show more options")
    }
    
    @objc func segmentedControllerActionHandler(_ sender: UISegmentedControl) {
        viewModel.setMediaType(index: sender.selectedSegmentIndex)
    }
}

//MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        viewModel.search(text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        viewModel.search(text)
    }
   
}

//MARK: - UITableViewDataSource & UITableViewDelegate
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaItemTableViewCell.reuseIdentifier, for: indexPath) as? MediaItemTableViewCell else {
            return UITableViewCell()
        }
        let item = viewModel.searchedItems[indexPath.row]        
        cell.set(model: item, imageCashe: viewModel.imageCache)
        
        return cell
    }
    
}


extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
