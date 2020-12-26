//
//  Plan.swift
//  Avito
//
//

import Foundation

class PlanResponce: Codable {
    let status: String
    let result: PlanDetails
}

class PlanDetails: Codable {
    let title, actionTitle, selectedActionTitle: String
    var list: [Plan]
}

class Plan: Codable {
    let id, title: String
    let listDescription: String?
    let icon: Icon
    let price: String
    var isSelected: Bool

    enum CodingKeys: String, CodingKey {
        case id, title
        case listDescription = "description"
        case icon, price, isSelected
    }
}

class Icon: Codable {
    let the52X52: String

    enum CodingKeys: String, CodingKey {
        case the52X52 = "52x52"
    }
}
