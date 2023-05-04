//
//  CollectionViewController.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/04.
//

import UIKit

class CollectionViewController: UIViewController {

    // MARK: - ui component

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - func

    @IBAction func didChangedSegmentValue(_ sender: Any) {
        if let segmentControl = sender as? UISegmentedControl {
            print(segmentControl.selectedSegmentIndex)
        }
    }
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func didTapCreateCollectionButton(_ sender: Any) {
        print("Create Collection")
    }
}
