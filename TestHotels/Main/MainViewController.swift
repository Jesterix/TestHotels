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

        mainView.switchControl.addTarget(
            self,
            action: #selector(sortHotels),
            for: .valueChanged)
    }

    func loadData() {
        mainView.activityIndicator.startAnimating()
        networkManager.getHotelListData { result in
            DispatchQueue.main.async {
                self.mainView.activityIndicator.stopAnimating()
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

    @objc func sortHotels() {
        if mainView.switchControl.isOn {
            hotels.sort
                { $0.suitesAvailability.count < $1.suitesAvailability.count }
        } else {
            hotels.sort
                { $0.distance < $1.distance }
        }
        mainView.tableView.reloadData()
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
        cell.distance.text = "Distance from center: " + String(hotels[indexPath.row].distance)
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

