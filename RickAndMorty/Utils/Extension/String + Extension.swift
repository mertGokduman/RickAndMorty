//
//  String + Extension.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 13.06.2022.
//

import Foundation
import UIKit

extension String {
    
    //Attributed String For Details Title
    func getAttributeString(for title: String) -> NSMutableAttributedString{
        let wholeString: String = title + self
        let attributeString = NSMutableAttributedString(string: wholeString,
                                                        attributes: [
                                                            .font: UIFont(name: "Nunito-Bold", size: 16)!,
                                                            .foregroundColor: UIColor.black
                                                        ])
        let nameAttribute = [.foregroundColor: UIColor.white ] as [NSAttributedString.Key : Any]
        let nameRange = ((wholeString) as NSString).range(of: title)
        attributeString.addAttributes(nameAttribute, range: nameRange)
        return attributeString
    }
}
