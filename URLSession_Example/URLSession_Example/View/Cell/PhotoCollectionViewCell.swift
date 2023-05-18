//
//  PhotoCollectionViewCell.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/04.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {

    // MARK: - ui component

    @IBOutlet weak var photoImageView: UIImageView!

    // MARK: - func

    func configureCell(imageUrl: String) {
        self.photoImageView.loadImageUrl(imageUrl)
    }
}

private extension UIImageView {
    func loadImageUrl(_ url: String) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                let image = UIImage(data: data)!
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        }
    }
}
