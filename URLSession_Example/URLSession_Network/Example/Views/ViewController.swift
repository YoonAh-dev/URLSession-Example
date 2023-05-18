//
//  ViewController.swift
//  URLSession_Network
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            do {
                let collection = CollectionRequestDTO(title: "새로운 카테고리!!", private: true)
                let data = try await CollectionService().uploadCollection(collection: collection)
                dump(data)
            } catch let error {
                print(error)
            }
        }
    }


}

