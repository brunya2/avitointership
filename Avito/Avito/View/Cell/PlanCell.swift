//
//  PlanCell.swift
//  Avito
//
//

import UIKit

class PlanCell: BaseCollectionViewCell {
    
    private lazy var planImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.notoSansKannadaBold(ofSize: 20)
        return label
    }()
    
    private lazy var discriptionLabel: SelfHiddenLabel = {
        let label = SelfHiddenLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.notoSansKannadaRegular(ofSize: 15)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.notoSansKannadaBold(ofSize: 20)
        return label
    }()
    
    lazy var checkMark: UIImageView = {
        let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = UIImage(named: "checkmark")
        return button
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 7.0
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(discriptionLabel)
        stackView.addArrangedSubview(priceLabel)
        return stackView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        discriptionLabel.isHidden = false
        planImageView.image = nil
        checkMark.isHidden = true
    }
    
    override func setupDynamicHeight(inset: CGFloat = .zero) {
        super.setupDynamicHeight(inset: 40)
    }
    
    override func setupView() {
        contentView.addSubview(planImageView)
        contentView.addSubview(checkMark)
        contentView.addSubview(stackView)
        
        contentView.backgroundColor = Colors.lightGray
        
        planImageView.translatesAutoresizingMaskIntoConstraints = false
        planImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0).isActive = true
        planImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        planImageView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        planImageView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        
        checkMark.topAnchor.constraint(equalTo: planImageView.topAnchor, constant: 10).isActive = true
        checkMark.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkMark.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: planImageView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: planImageView.trailingAnchor,constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45).isActive = true
    }
    
    func setupCell(plan: Plan) {
        titleLabel.text = plan.title
        discriptionLabel.text = plan.listDescription
        priceLabel.text = plan.price
        checkMark.isHidden = !plan.isSelected
        planImageView.downloaded(from: plan.icon.the52X52)
    }
}
