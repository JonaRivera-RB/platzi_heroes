//
//  HeroeSerieCell.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 06/01/21.
//

import Foundation
import UIKit
import SDWebImage

class HeroeSerieCell: UICollectionViewCell {
    
    //MARK:-Properties
    var comicsItem: ComicsItem? {
        didSet {
            configure()
        }
    }
    
    private var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var comicNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 10
        label.textAlignment = .center
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(shadowView)
        shadowView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        
        addSubview(comicNameLabel)
        comicNameLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingRight: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func configure() {
       guard let comicsItem = comicsItem else { return }
        comicNameLabel.text = comicsItem.name
    }
}
