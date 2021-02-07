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
    
    fileprivate var descriptionText: String = ""
    fileprivate var descriptionImageURL: URL?
    fileprivate var descriptionImage: UIImage?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getResultView(keyword: String) {
        self.getFlavorText(keyword: keyword)
    }
    
    fileprivate func createSubviews() {
        
        let _descriptionLabel = UILabel()
        descriptionLabel = _descriptionLabel
        descriptionLabel.font = UIFont.systemFont(ofSize: 16.0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.backgroundColor = UIColor.clear
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor.ColorPalette.labelColor
        addSubview(descriptionLabel)
        
        let _descriptionImageView = UIImageView()
        descriptionImageView = _descriptionImageView
        descriptionImageView.backgroundColor = UIColor.clear
        descriptionImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionImageView)
        self.descriptionLabel.text = self.descriptionText
        self.descriptionImageView.image = self.descriptionImage
    }
    
    fileprivate func getDescriptionHeight() -> CGFloat {
        return getLabelHeight(text: descriptionLabel.text ?? "")
    }
    
    public func addConstraints() {
        createSubviews()
        addConstraints([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            descriptionLabel.heightAnchor.constraint(equalToConstant: getDescriptionHeight())
        ])
        
        addConstraints([
            descriptionImageView.topAnchor.constraint(equalTo: topAnchor, constant: getDescriptionHeight() + 15),
            descriptionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            descriptionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            descriptionImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        layoutIfNeeded()
    }
    
    
    fileprivate func getDescriptionImage(keyword: String) {
        let urlAPI = "https://pokeapi.co/api/v2/pokemon/\(keyword)"
        SpriteViewModel.getSprite(url: urlAPI) { (data) in
            let stringURL = data.sprites?.back_default ?? ""
            let url = URL(string: stringURL)
            self.descriptionImageURL = url!
            self.downloadImage(from: url!)
        } failHandler: { (error) in
            print(error)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.descriptionImageView.image = UIImage(data: data)
                self?.descriptionImage = UIImage(data: data)
            }
        }
        self.descriptionLabel.removeFromSuperview()
        self.descriptionImageView.removeFromSuperview()
        self.addConstraints()
    }
    
    fileprivate func getFlavorText(keyword: String) {
        let url = "https://pokeapi.co/api/v2/pokemon-species/\(keyword)"
        FlavorTextEntriesViewModel.getFlavorTextEntries(url: url) { (data) in
            if data.id != nil {
                var array = (data.flavor_text_entries ?? [])
                array = array.unique()
                var text: String = ""
                if array.count > 0 {
                    for item in array {
                        if item.language?.name == "en" {
                            var appendText = item.flavor_text ?? ""
                            appendText = appendText.replacingOccurrences(of: "\n", with: " ")
                            text.append(appendText)
                        }
                    }
                    self.descriptionLabel.text = text
                    self.descriptionText = text
                }
                
                let varities = data.varieties ?? []
                for item in varities {
                    if (item.is_default ?? false) {
                        self.getDescriptionImage(keyword: item.pokemon?.name ?? "")
                    }
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
