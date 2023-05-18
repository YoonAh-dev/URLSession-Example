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

    private func uploadCollection(_ collection: Collection) {
        Task {
            let result = await CollectionAPI().uploadCollection(collection: collection)
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    dump(data)
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                self.handleError(error.localizedDescription)
            }
        }
    }

    // MARK: - IBAction

    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func didTapCreateCollectionButton(_ sender: Any) {
        var collection: Collection

        guard let title = self.titleTextField.text, title != "" else {
            self.handleError(CollectionError.requiredFieldNotEntered.errorDescription ?? "")
            return
        }

        let isPublic = self.privateSegmentControl.selectedSegmentIndex == 0 ? true : false

        if let description = self.descriptionTextField.text, description != "" {
            collection = Collection(title: title, description: description, private: isPublic)
        } else {
            collection = Collection(title: title, private: isPublic)
        }

        self.uploadCollection(collection)
    }
}
