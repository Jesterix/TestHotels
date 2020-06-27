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

    init() {
        super.init(frame: .zero)
        layoutContent(in: self)
        applyStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutContent(in view: UIView) {
        nameLabel = layout(UILabel(text: "TEsT"))
        { make in
            make.top.equalTo(safeArea).offset(10)
            make.centerX.equalToSuperview()
        }
    }

    private func applyStyle() {
        backgroundColor = .white
        nameLabel.numberOfLines = 0
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
