//
//  ValidatedFormView.swift
//  FormModule
//
//  Created by sanaz on 11/6/25.
//

import SwiftUI

public struct ValidatedFormView: View {
    @ObservedObject private var viewModel = ValidatedFormViewModel()
    public init() {}
    public var body: some View {
        NavigationStack {
            Form {
                userInfoSection
                promoCodeSection
                deliveryDateSection
                ratingSection
                errorSection
                submitButtonSection
            }
            .navigationTitle("Validated Form")
        }
    }
    
    private var userInfoSection: some View {
        Section("User Info") {
            TextField("Name", text: $viewModel.name)
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
            TextField("Phone number", text: $viewModel.phone)
                .keyboardType(.numberPad)
        }
    }
    
    private var promoCodeSection: some View {
        Section("Promo Code") {
            TextField("Code (e.g. ABC-XYZ)", text: $viewModel.promoCode)
                .textInputAutocapitalization(.characters)
        }
    }
    
    private var deliveryDateSection: some View {
        Section("Delivery Date") {
            DatePicker("Select date", selection: $viewModel.deliveryDate, displayedComponents: .date)
        }
    }
    
    private var ratingSection: some View {
        Section("Rating") {
            Picker("Rating", selection: $viewModel.rating) {
                ForEach(viewModel.ratings, id: \.self) { rating in
                    Text(rating)
                }
            }
        }
    }
    
    private var errorSection: some View {
        Group {
            if let error = viewModel.errorMessage {
                Section {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    private var submitButtonSection: some View {
        Section {
            Button("Submit") {
                if viewModel.validateForm() {
                    viewModel.errorMessage = "Form submitted successfully!"
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
