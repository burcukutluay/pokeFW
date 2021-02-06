//
//  InfoView.swift
//  pokeFW
//
//  Created by burcu kirik on 6.02.2021.
//

import Foundation
import AlamofireImage
import UIKit

public class InfoView: UIView {
    fileprivate weak var descriptionLabel: UILabel!
    fileprivate weak var descriptionImageView: UIImageView!
    
    public func setupUI(keyword: String) {
        if keyword != "" {
            self.getFlavorText(keyword: keyword)
        }
    }
    
    fileprivate func createSubviews() {
        
        let _descriptionLabel = UILabel()
        descriptionLabel = _descriptionLabel
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 16.0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLabel.sizeToFit()
        descriptionLabel.backgroundColor = UIColor.clear
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor.ColorPalette.labelColor
        addSubview(descriptionLabel)
        
        let _descriptionImageView = UIImageView()
        descriptionImageView = _descriptionImageView
        descriptionImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionImageView.backgroundColor = UIColor.clear
        addSubview(descriptionImageView)
    }
    
    fileprivate func getDescriptionHeight() -> CGFloat {
        return getLabelHeight(text: descriptionLabel.text ?? "")
    }
    
    fileprivate func addConstraints() {
        addConstraints([
            descriptionImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            descriptionImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width / 2),
            descriptionImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            descriptionImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width / 2)
        ])
        addConstraints([
            descriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            descriptionLabel.heightAnchor.constraint(equalToConstant: getDescriptionHeight())
        ])
        
        layoutIfNeeded()
    }
    
    
    public func getDescriptionResult(keyword: String) {
        let url = "https://pokeapi.co/api/v2/pokemon/\(keyword)"
        SpriteViewModel.getSprite(url: url, successHandler: {(data) in
            print(data)
            let stringURL = data.back_default ?? ""
            let url = URL(string: stringURL)
            self.descriptionImageView.af.setImage(withURL: url!)
            
        })
        { (error) in
            print(error)
        }
    }
    
    public func getFlavorText(keyword: String) {
        let url = "https://pokeapi.co/api/v2/pokemon-species/\(keyword)"
        FlavorTextEntriesViewModel.getFlavorTextEntries(url: url) { (data) in
            print(data)
            if data.id != nil {
                self.createSubviews()
                self.getDescriptionResult(keyword: keyword)
                let array = data.flavor_text_entries ?? []
                var text: String = ""
                if array.count > 0 {
                    for item in array {
                        text.append(item.flavor_text ?? "")
                        text.append("\n")
                    }
                    self.descriptionLabel.text = text
                }
            }
        } failHandler: { (error) in
            print(error)
        }
    }
    
    fileprivate final func calculateLabelSize(text: String) -> CGSize {
        return (text as NSString).size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .regular)])
    }
    
    fileprivate func getLabelHeight(text: String) -> CGFloat {
        
        let size = self.calculateLabelSize(text: text)
        let const = size.width / (UIScreen.main.bounds.size.width - 40)
        let constInt = Int(ceil(const))
        if const > 1 {
            return CGFloat((constInt * 27) + 15)
        }
        else {
            return 60
        }
    }
}
