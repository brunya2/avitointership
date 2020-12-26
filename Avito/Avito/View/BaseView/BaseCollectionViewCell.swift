//
//  BaseCollectionViewCell.swift
//  Avito
//
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupDynamicHeight()
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupDynamicHeight(inset: CGFloat = .zero) {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - inset).isActive = true
    }
    
    func setupView() {
        
    }
}
