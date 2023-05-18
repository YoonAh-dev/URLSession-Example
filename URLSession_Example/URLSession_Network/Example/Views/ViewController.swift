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
                let data = try await CollectionService().fetchCollections()
                dump(data)
            } catch let error {
                print(error)
            }
        }
    }


}

