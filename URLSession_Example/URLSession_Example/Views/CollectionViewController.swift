//
//  CollectionViewController.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/04.
//

import UIKit

private enum CollectionError: LocalizedError {
    case requiredFieldNotEntered

    var errorDescription: String? {
        switch self {
        case .requiredFieldNotEntered:
            return "필수 영역을 다 채우지 않았습니다."
        }
    }
}

final class CollectionViewController: UIViewController {

    // MARK: - ui component

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var privateSegmentControl: UISegmentedControl!
    @IBOutlet weak var descriptionTextField: UITextField!

    // MARK: - property

    private var urlRequest: URLRequest {
        let url = URL(string: "https://api.unsplash.com/collections")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
            "Authorization": "Bearer \(AccessToken)",
            "Content-Type": "application/json"
        ]
        return urlRequest
    }

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - func

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

    private func handleCollection(_ data: Data) {
        do {
            let decoder = JSONDecoder()
            let collection: CollectionResponseDTO = try decoder.decode(CollectionResponseDTO.self, from: data)
            DispatchQueue.main.async {
                dump(collection)
                self.dismiss(animated: true)
            }
        } catch let error {
            self.handleClientError(error)
        }
    }

    // MARK: - network

    private func uploadCollection(_ collection: CollectionRequestDTO) {
        guard let data = self.encodeCollection(collection) else { return }
        let task = URLSession.shared.uploadTask(with: self.urlRequest, from: data) { data, response, error in
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
                self.handleCollection(data)
            }
        }
        task.resume()
    }

    private func encodeCollection(_ collection: CollectionRequestDTO) -> Data? {
        guard let uploadData = try? JSONEncoder().encode(collection) else {
            return nil
        }
        return uploadData
    }

    // MARK: - IBAction

    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func didTapCreateCollectionButton(_ sender: Any) {
        var collection: CollectionRequestDTO

        guard let title = self.titleTextField.text, title != "" else {
            self.handleClientError(CollectionError.requiredFieldNotEntered)
            return
        }

        let isPublic = self.privateSegmentControl.selectedSegmentIndex == 0 ? true : false

        if let description = self.descriptionTextField.text, description != "" {
            collection = CollectionRequestDTO(title: title, description: description, private: isPublic)
        } else {
            collection = CollectionRequestDTO(title: title, private: isPublic)
        }

        self.uploadCollection(collection)
    }
}
