//
//  PlacesListViewController.swift
//  Application
//
//  Created by 胡洞明 on 2021-11-15.
//

import UIKit
import Combine

import Domain
import Data
import Core

typealias PlaceID = String
typealias Place = Places.Place

class PlacesListViewController: UIViewController {

    /// Apple advised to use item identifier instead of actual item in Diffable DataSource
    typealias DataSource = UITableViewDiffableDataSource<Section, PlaceID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, PlaceID>
    
    enum Section {
        case main
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // FIXME: - Should use dependency injection
    private var searchPlacesUseCase: ASearchPlacesUseCase! = SearchPlacesUseCase(repo: PlacesRepo.shared)
    
    /// For easy retrievemcent of a place
    private var placesDict: [PlaceID: Place] = [:]
    /// For data source
    @MainActor private var places: [Place] = [] {
        didSet {
            applySnapshot(completion: nil)
        }
    }
    
    private lazy var dataSource = makeDataSource()
    
    private static let perPage = 20
    private var page: Int = 0
    private var isAllFetched: Bool = false
    private var query: Places.SearchQuery {
        .init(type: nil, keyword: searchBar.text, page: page, perPage: Self.perPage)
    }
    @MainActor private var isFetching: Bool = false {
        didSet {
            _ = isFetching ? spinner.startAnimating() : spinner.stopAnimating()
        }
    }
    
    private var tasks: [Task<Void, Never>] = []
    private var bag: Set<AnyCancellable> = []
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBarTypingAction()
        
    }

    // MARK: - Navigation
    
    @IBSegueAction func showDetails(_ coder: NSCoder) -> PlaceDetailsViewController? {
        guard let selectedRow = table.indexPathForSelectedRow?.row,
              let place = places[safe: selectedRow]
        else { return nil }
        
        return PlaceDetailsViewController(place: place, coder: coder)
    }
    
    // MARK: - Setups
    
    private func setupTableView() {
        table.prefetchDataSource = self
        table.delegate = self
        
        table.estimatedRowHeight = 250
        table.rowHeight = UITableView.automaticDimension
        
    }
    
    private func setupSearchBarTypingAction() {
        // FIXME: - when typing, publisher doesn't emit new values
        searchBar.searchTextField.publisher(for: \.text)
            .compactMap{ $0 }
            .removeDuplicates()
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [unowned self] keyword in
                print("keyword:", keyword)
                page = 0
                places.removeAll()
                placesDict.removeAll()
                fetchMore()
            }
            .store(in: &bag)
    }
    
    private func makeDataSource() -> DataSource {
        let ds = DataSource.init(tableView: table) { [self] tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueCell(type: PlaceCell.self)
            
            guard let place = placesDict[itemIdentifier] else { return nil }
            
            cell.configure(with: place)
            
            return cell
        }
        
        return ds
    }
    
    private func applySnapshot(animatingDifferences: Bool = true, completion: Completion?) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(places.map(\.id))
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
    }
    
    
    // MARK: - Core Function
    
    private func fetchMore() {

        let task = Task {
            isFetching = true
            
            do {
                let envelop = try await searchPlacesUseCase.search(query: query)
                // update flag
                isAllFetched = envelop.isAllFetched
                
                
                // update data source (trigger table update)
                for place in envelop.items {
                    placesDict.updateValue(place, forKey: place.id)
                }
                // FIXME: - is there a better way to remove duplicates?
                places.append(contentsOf: envelop.items.filter{ !places.contains($0) })
                
                // update UI
                isFetching = false
                if places.isEmpty {
                    table.setEmptyMessage("No matching places found")
                } else {
                    table.backgroundView = nil
                }
            } catch {
                print(error.localizedDescription)
                isFetching = false
                table.setEmptyMessage("No matching places found")
                let networkError = error as? NetworkError
                presentAlert(title: networkError?.errorTitle, message: networkError?.errorDescription)
            }
        }

        #warning("How to remove task from array once it's done?")
        tasks.append(task)
    }
    
    
}


// MARK: - Table Prefetch DataSource

extension PlacesListViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !isAllFetched,
              !isFetching,
              let maxIP = indexPaths.max(),
              maxIP.row >= places.count - 1
        else { return }
        
        page += 1
        fetchMore()
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        tasks.forEach{ $0.cancel() }
        tasks.removeAll()
    }
    
}

// MARK: - Table Delegate

extension PlacesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
