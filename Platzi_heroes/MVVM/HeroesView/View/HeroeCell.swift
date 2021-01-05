//
//  HeroeCell.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import Foundation
import UIKit
import SDWebImage

class HeroeCell: UICollectionViewCell {
    //MARK:-Properties
    var heroeList: HeroeList? {
        didSet {
            configure()
        }
    }
    private lazy var heroeImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    private var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    private var heroeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroeImageView)
        heroeImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingRight: 5)
        heroeImageView.addSubview(shadowView)
        shadowView.anchor(left: heroeImageView.leftAnchor, bottom: heroeImageView.bottomAnchor, right: heroeImageView.rightAnchor, height: 80)
        shadowView.addSubview(heroeNameLabel)
        heroeNameLabel.anchor(top: shadowView.topAnchor, left: shadowView.leftAnchor, right: shadowView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func configure() {
        guard let heroeList = heroeList else { return }
        let viewModel = HeroeCellViewModel(heroeList: heroeList)
        heroeImageView.sd_setImage(with: viewModel.heroeImageURL, completed: nil)
        heroeNameLabel.text = viewModel.heroeName
    }
}
