//
//  MainViewController.swift
//  TestHotels
//
//  Created by Георгий Хайденко on 25.06.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    var mainView: MainView!
    var hotels: [Hotel] = []
    var networkManager = NetworkManager()

    let reuseID = "hotelCell"

    override func loadView() {
        mainView = MainView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(
            HotelCell.self,
            forCellReuseIdentifier: reuseID)

        loadData()
    }

    func loadData() {
        networkManager.getHotelListData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.hotels = response
                    self.mainView.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int
    {
        1
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        hotels.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseID) as? HotelCell else
        {
            fatalError("invalid cell type")
        }

        cell.name.text = hotels[indexPath.row].name
        cell.stars.text = "Stars: " + String(hotels[indexPath.row].stars)
        cell.suitesAvailable.text =
        "Available suites: \(hotels[indexPath.row].suitesAvailability.count)"

        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
        print("row \(indexPath.row)")
    }
}

