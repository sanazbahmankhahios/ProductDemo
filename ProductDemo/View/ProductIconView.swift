//
//  ProductIconView.swift
//  ProductDemo
//
//  Created by sanaz on 11/4/25.
//

import SwiftUI
import Kingfisher
import ProductKit

struct ProductIconView: View {
    var icon: URL?
    let size: CGFloat

    var body: some View {
        KFImage(icon)
            .placeholder {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .background(Color.gray.opacity(0.2))
            }
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .backgroundStyle(.gray)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ProductIconView(size: 100)
}
