//
//  DetailView.swift
//  TestHotels
//
//  Created by Георгий Хайденко on 27.06.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import UIKit

final class DetailView: UIView {
    var nameLabel: UILabel!
    var imageView: UIImageView!
    var addressLabel: UILabel!
    var lattitudeLabel: UILabel!
    var longtitudeLabel: UILabel!
    var distanceLabel: UILabel!
    var starsLabel: UILabel!
    var suitesAvailableLabel: UILabel!

    init() {
        super.init(frame: .zero)
        layoutContent(in: self)
        applyStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutContent(in view: UIView) {
        nameLabel = layout(UILabel())
        { make in
            make.top.equalTo(safeArea).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }

        imageView = layout(UIImageView(image: UIImage()))
        { make in
            make.top.equalTo(nameLabel.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(4)
        }

        addressLabel = layout(UILabel())
        { make in
            make.top.equalTo(imageView.bottom).offset(10)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(nameLabel)
        }

        lattitudeLabel = layout(UILabel())
        { make in
            make.top.equalTo(addressLabel.bottom).offset(5)
            make.leading.equalTo(nameLabel)
        }

        longtitudeLabel = layout(UILabel())
        { make in
            make.top.equalTo(lattitudeLabel.bottom).offset(5)
            make.leading.equalTo(nameLabel)
        }

        distanceLabel = layout(UILabel())
        { make in
            make.top.equalTo(longtitudeLabel.bottom).offset(5)
            make.leading.equalTo(nameLabel)
        }

        starsLabel = layout(UILabel())
        { make in
            make.top.equalTo(longtitudeLabel.bottom).offset(5)
            make.leading.greaterThanOrEqualTo(distanceLabel.trailing).offset(5)
            make.trailing.equalTo(nameLabel)
        }

        suitesAvailableLabel = layout(UILabel())
        { make in
            make.top.equalTo(distanceLabel.bottom).offset(5)
            make.leading.trailing.equalTo(nameLabel)
        }
    }

    private func applyStyle() {
        backgroundColor = .white

        imageView.contentMode = .scaleAspectFill
        nameLabel.textAlignment = .center

        [nameLabel,
         addressLabel,
         suitesAvailableLabel].forEach { item in
            item?.numberOfLines = 0
        }

        [addressLabel,
         lattitudeLabel,
         longtitudeLabel,
         distanceLabel,
         starsLabel,
         suitesAvailableLabel].forEach { item in
            item?.font = .systemFont(ofSize: 13)
        }
    }
}

//{
//    "id": 80899,
//    "name": "Americana Inn",
//    "address": "69 West 38th Street",
//    "stars": 2.0,
//    "distance": 99.9,
//    "image": "3.jpg",
//    "suites_availability": "5:8:32:54",
//    "lat": 40.75211500000000,
//    "lon": -73.98545100000000
//}
