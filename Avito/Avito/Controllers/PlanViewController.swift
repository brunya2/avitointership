//
//  ViewController.swift
//  Avito
//
//

import Foundation
import UIKit

class PlanViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.notoSansKannadaBold(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.lightBlue
        button.layer.cornerRadius = 10
        button.setTitle("Выбрать", for: .normal)
        button.addTarget(self, action: #selector(didTapSelectButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 10.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset.bottom = 10
        return collectionView
    }()
    
    var planDetails: PlanDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupTitleLabel()
    }
    
    private func setupView() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(selectButton)
        view.addSubview(closeButton)
        
        closeButton.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor,constant: 40).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: selectButton.topAnchor).isActive = true
        
        selectButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        selectButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        selectButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20.0).isActive = true
        selectButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20.0).isActive = true
    }
    
    private func setupCollectionView() {
        collectionView.register(PlanCell.self, forCellWithReuseIdentifier: "PlanCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupTitleLabel() {
        titleLabel.text = planDetails?.title
    }
    
    @objc
    private func didTapSelectButton() {
        var alertText: String!
        var alertMessage: String!
        if let plan = planDetails?.list.first(where: {$0.isSelected}) {
            alertText = "Выбраный план"
            alertMessage = plan.title
        } else {
            alertText = "План не выбран"
            alertMessage = "Выберете пожалуйста план"
        }
        showAlert(alertText: alertText, alertMessage: alertMessage)
    }
}

extension PlanViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planDetails?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanCell", for: indexPath) as? PlanCell,
              let plan = planDetails?.list[indexPath.row]
        else { return PlanCell() }
        cell.setupCell(plan: plan)
        return cell
    }
}

extension PlanViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentPlanIndex = planDetails?.list.firstIndex(where: {$0.isSelected})
        let selectedPlanIndex = indexPath.row
        guard let planDetails = planDetails else { return }
        if currentPlanIndex == selectedPlanIndex || currentPlanIndex == nil {
            planDetails.list[selectedPlanIndex].isSelected = !planDetails.list[selectedPlanIndex].isSelected
            if let cell = collectionView.cellForItem(at: indexPath) as? PlanCell {
                cell.checkMark.isHidden = !cell.checkMark.isHidden
            }
        } else {
            guard let currentPlanIndex = currentPlanIndex  else { return }
            planDetails.list[selectedPlanIndex].isSelected = !planDetails.list[selectedPlanIndex].isSelected
            planDetails.list[currentPlanIndex].isSelected = !planDetails.list[currentPlanIndex].isSelected
            
            let selectedPlanIndexPath =  IndexPath(item: selectedPlanIndex, section: 0)
            let currentPlanIndexPath = IndexPath(item: currentPlanIndex, section: 0)
            
            if let selectedCell = collectionView.cellForItem(at: selectedPlanIndexPath) as? PlanCell {
                selectedCell.checkMark.isHidden = !selectedCell.checkMark.isHidden
            }
            if let currentCell = collectionView.cellForItem(at: currentPlanIndexPath) as? PlanCell {
                currentCell.checkMark.isHidden = !currentCell.checkMark.isHidden
            }
        }
    }
}

