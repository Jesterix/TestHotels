//
//  DetailViewController.swift
//  TestHotels
//
//  Created by Георгий Хайденко on 27.06.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    var detailView: DetailView!

    override func loadView() {
        detailView = DetailView()
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
}
