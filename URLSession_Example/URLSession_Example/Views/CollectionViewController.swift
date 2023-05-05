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

    // MARK: - func

    private func handleError(_ message: String) {
        DispatchQueue.main.async {
            self.makeAlert(title: "문제 발생", message: message)
        }
    }

    // MARK: - network

    private func uploadCollection(_ collection: CollectionRequestDTO) {
        Task {
            do {
                let response = try await CollectionAPI().uploadCollection(collection: collection)

                if let data = response.data {
                    DispatchQueue.main.async {
                        dump(data)
                        self.dismiss(animated: true)
                    }
                } else {
                    self.handleError("데이터가 들어오지 않았습니다.")
                }
            } catch NetworkError.decodingError {
                self.handleError("데이터 디코딩에 실패했습니다.")
            } catch NetworkError.clientError(let message) {
                self.handleError(message ?? "")
            } catch NetworkError.serverError {
                self.handleError("서버에 문제가 발생하였습니다.")
            }
        }
    }

    // MARK: - IBAction

    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func didTapCreateCollectionButton(_ sender: Any) {
        var collection: CollectionRequestDTO

        guard let title = self.titleTextField.text, title != "" else {
            self.handleError(CollectionError.requiredFieldNotEntered.errorDescription ?? "")
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
