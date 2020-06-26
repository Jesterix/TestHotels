//
//  HotelCell.swift
//  TestHotels
//
//  Created by Георгий Хайденко on 26.06.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import UIKit

class HotelCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutContent(in: self)
        applyStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var name: UILabel!
    var distance: UILabel!
    var suitesAvailable: UILabel!

    private func layoutContent(in view: UIView) {
        name = view.layout(UILabel())
        { make in
            make.leading.equalTo(safeArea).offset(10)
            make.top.equalTo(safeArea).offset(5)
            make.trailing.equalTo(safeArea).offset(-10)
        }

        distance = view.layout(UILabel())
        { make in
            make.top.equalTo(name.bottom).offset(5)
            make.leading.equalTo(name)
        }

        suitesAvailable = view.layout(UILabel())
        { make in
            make.top.equalTo(name.bottom).offset(5)
            make.trailing.equalTo(name)
            make.leading.greaterThanOrEqualTo(distance.trailing).offset(5)
            make.bottom.equalTo(safeArea).offset(-5)
        }
    }

    private func applyStyle() {
        name.numberOfLines = 0
        distance.font = .systemFont(ofSize: 13)
        suitesAvailable.font = .systemFont(ofSize: 13)
    }
}

