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

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.startLoad()
    }

    // MARK: - func

    private func configureCollectionView() {
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.collectionViewLayout = self.flowLayout
    }

    // MARK: - network

    private func startLoad() {
        var url = URL(string: "https://api.unsplash.com/photos")!
        url.append(queryItems: [
            URLQueryItem(name: "per_page", value: "20"),
            URLQueryItem(name: "order_by", value: "popular")
        ])
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = ["Authorization": "Client-ID KVtPVt64UrQx60c_6Ne2odkNi1hYv7UPnVh5DbhtjG4"]
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                self.handleClientError(error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                return
            }

            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                self.handleImages(data)
            }
        }
        task.resume()
    }
    
    private func handleImages(_ data: Data) {
        do {
            let decoder = JSONDecoder()
            let images: [Image] = try decoder.decode([Image].self, from: data)
            DispatchQueue.main.async {
                self.imageURLs = images.compactMap { $0.urls?.regular }
            }
        } catch let error {
            self.handleClientError(error)
        }
    }

    private func handleClientError(_ error: Error) {
        DispatchQueue.main.async {
            self.makeAlert(title: "문제 발생", message: error.localizedDescription)
        }
    }

    private func handleServerError(_ response: URLResponse?) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        let statusCode = httpResponse.statusCode

        DispatchQueue.main.async {
            self.makeAlert(title: "문제 발생", message: "[\(statusCode)] 서버에서 문제가 발생했습니다.")
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
