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
        Task {
            let result = await CollectionAPI().fetchCollections()
            switch result {
            case .success(let data):
                dump(data)
            case .failure(let error):
                print(error.localizedDescription)
                dump(error)
            }
        }
    }


}

