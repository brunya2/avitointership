//
//  DataServices.swift
//  Avito
//
//

import Foundation

class DataServices {
    static func getPlanDetails() -> PlanDetails? {
        do {
            if let file = Bundle.main.url(forResource: "result", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let decoder = JSONDecoder()
                if let planResponce = try? decoder.decode(PlanResponce.self, from: data) {
                    return planResponce.result
                }
                return nil
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
