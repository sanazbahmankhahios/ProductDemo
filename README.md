ProductDemo

ProductDemo is an iOS app built with SwiftUI, Combine, and Swift Package Manager (SPM).
It demonstrates a modular Clean Architecture with Firebase Remote Config integration, dependency injection, local caching, and reactive data flow.

The app consumes product data from the DummyJSON Products API
, featuring product listing, advanced search, product details, and a validated form.

 Features

https://github.com/user-attachments/assets/0fd9470c-c7c2-4491-a10e-afb5670406e6



https://github.com/user-attachments/assets/7edb0907-eef2-487b-8528-861ff58b17e4



-  Firebase Remote Config — dynamically switches app mode (Default value: product / form)
https://console.firebase.google.com/project/productdemo-8f574/config/env/firebase

-  Modular Architecture

ProductKit → Domain, Networking, Caching + Unit tests

ProductListModule → SwiftUI product list + detail views

FormModule → Validated form UI

🧠 MVVM + Clean Architecture

- Dependency Injection via DIContainer

- Local Cache for offline persistence

🧭 Product Listing — pagination, rating icons

- Advanced Search — case & diacritic insensitive, multi-term matching

🖼️ Product Detail View — price, stock, discount, rating, and responsive image header

🧾 Validated Form — input validation (email, promo code, delivery date, etc.)

🧱 Tech Stack

SwiftUI — declarative UI

Combine — reactive programming

Firebase Remote Config

Swift Package Manager (SPM) 

DummyJSON API — mock product for UnitTests
