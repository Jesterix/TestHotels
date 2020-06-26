//
//  Extensions.swift
//  TestHotels
//
//  Created by Георгий Хайденко on 25.06.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String = "")
    {
        self.init(frame: .zero)
        self.attributedText = .init(string: text)
    }
}
