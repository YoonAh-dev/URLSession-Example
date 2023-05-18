//
//  ViewController.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/03.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - ui component

    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var collectionTableView: UITableView!

    private let flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 460)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = .zero
        return flowLayout
    }()
    
    // MARK: - property

    private var imageURLs: [String] = [] {
        didSet { self.photoCollectionView.reloadData() }
    }
    private var collections: [String] = [] {
        didSet { self.collectionTableView.reloadData() }
    }

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.configureTableView()
        self.startLoad()
    }

    // MARK: - func

    private func configureCollectionView() {
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.collectionViewLayout = self.flowLayout
    }

    private func configureTableView() {
        self.collectionTableView.dataSource = self
    }

    private func handleError(_ message: String) {
        DispatchQueue.main.async {
            self.makeAlert(title: "문제 발생", message: message)
        }
    }

    // MARK: - network

    private func startLoad() {
        self.fetchImages()
        self.fetchCollections()
    }

    private func fetchImages() {
        Task {
            let result = await PhotoAPI().fetchImages(perPage: 3, orderBy: "popular")
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageURLs = data.compactMap { $0.urls?.regular }
                }
            case .failure(let error):
                self.handleError(error.localizedDescription)
            }
        }
    }

    private func fetchCollections() {
        Task {
            let result = await CollectionAPI().fetchCollections()
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.collections = data.map { $0.title ?? "" }
                }
            case .failure(let error):
                self.handleError(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageURLs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        let imageUrl = self.imageURLs[indexPath.item]
        cell.configureCell(imageUrl: imageUrl)
        return cell
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        var cellConfigure = cell.defaultContentConfiguration()
        cellConfigure.text =  self.collections[indexPath.row]
        cell.contentConfiguration = cellConfigure
        return cell
    }
}
