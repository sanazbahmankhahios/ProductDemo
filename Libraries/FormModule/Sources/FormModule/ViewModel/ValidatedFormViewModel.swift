//
//  ValidatedFormViewModel.swift
//  FormModule
//
//  Created by sanaz on 11/6/25.
//

import SwiftUI
import Combine

@MainActor
public class ValidatedFormViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var promoCode = ""
    @Published var deliveryDate = Date()
    @Published var rating = "Satisfatório"
    @Published var errorMessage: String?

    let ratings = ["Mau", "Satisfatório", "Bom", "Muito Bom", "Excelente"]

    func validateForm() -> Bool {
        errorMessage = nil
        
        guard !name.isEmpty,
              !email.isEmpty,
              !phone.isEmpty,
              !promoCode.isEmpty else {
            errorMessage = "All fields are required."
            return false
        }
        
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        guard NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) else {
            errorMessage = "Invalid email address."
            return false
        }
        
        guard CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: phone)) else {
            errorMessage = "Phone number can only contain digits."
            return false
        }
        
        let promoRegex = #"^[A-Z\-]{3,7}$"#
        guard NSPredicate(format: "SELF MATCHES %@", promoRegex).evaluate(with: promoCode) else {
            errorMessage = "Promo code must be 3–7 uppercase letters or hyphens, no accents."
            return false
        }
        
        let calendar = Calendar.current
        if calendar.component(.weekday, from: deliveryDate) == 2 {
            errorMessage = "Delivery date cannot be on a Monday."
            return false
        }
        
        if deliveryDate > Date() {
            errorMessage = "Delivery date cannot be in the future."
            return false
        }

        return true
    }
}
