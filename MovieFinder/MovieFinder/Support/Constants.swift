//
//  Constants.swift
//  MovieFinder
//
//  Created by Тамара Иволга on 13.03.2022.
//

import UIKit

enum Constants {
    enum Fonts {
        static var regular14: UIFont? {
            UIFont(name: "Inter-Regular", size: 14)
        }
        static var regular16: UIFont? {
            UIFont(name: "Inter-Regular", size: 16)
        }
        
        static var semiBold16: UIFont? {
            UIFont(name: "Inter-SemiBold", size: 16)
        }
        static var semiBold18: UIFont? {
            UIFont(name: "Inter-SemiBold", size: 18)
        }
    }
    
    enum Colors {
        static var textColor: UIColor? {
            UIColor(named: "TextColor")
        }
        static var borderColor: UIColor? {
            UIColor(named: "BorderColor")
        }
    }
    
    enum Text {
        static var title = "MovieFinder"
    }
}
