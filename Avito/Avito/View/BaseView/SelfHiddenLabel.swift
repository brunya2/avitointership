//
//  SelfHiddenLabel.swift
//  Avito
//
//

import UIKit

class SelfHiddenLabel: UILabel {
    override var text: String? {
        didSet {
            if text == "" || text == nil {
                self.isHidden = true
            }
        }
    }
}
