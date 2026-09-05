<div align="center">

<img src="assets/images/Choice_.png" width="160" alt="ChoiceX Logo">

# ChoiceX — User Application

**The customer-facing app for the ChoiceX electronics e-commerce platform.**

[![Status](https://img.shields.io/badge/status-active-brightgreen?style=flat-square)](#project-status)
[![Platform](https://img.shields.io/badge/platform-Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)](#technology-stack)
[![Language](https://img.shields.io/badge/language-Dart-0175C2?style=flat-square&logo=dart&logoColor=white)](#technology-stack)
[![Backend](https://img.shields.io/badge/backend-Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black)](#technology-stack)
[![Payments](https://img.shields.io/badge/payments-Stripe-635BFF?style=flat-square&logo=stripe&logoColor=white)](#technology-stack)
[![License](https://img.shields.io/badge/license-private-lightgrey?style=flat-square)](#license)

</div>

---

## Table of Contents

- [Overview](#overview)
- [The Shopping Experience](#the-shopping-experience)
- [Product Capabilities](#product-capabilities)
- [Architecture](#architecture)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
- [Useful Commands](#useful-commands)
- [Project Status](#project-status)
- [License](#license)

---

## Overview

**ChoiceX** is a full-stack **Flutter** electronics e-commerce application, backed by **Firebase**, covering the complete customer journey — from secure authentication and product discovery to cart, checkout, payment, order tracking, and direct in-app chat with sellers.

This repository contains the **user-facing (customer) application** — the app end customers install to browse, buy, and track orders.

> **Note:** This app does *not* include any admin or seller-side tooling — those live in their respective apps.

Users authenticate securely — via email/password, Google, or Facebook — browse a catalog of electronic products, and evaluate each product through images, pricing, ratings, and variant options such as **color and RAM** before adding it to their cart. From there, ChoiceX carries the user through coupon application, Stripe payment, order placement, real-time order tracking, and post-purchase rating — with in-app chat, notifications, and location-aware delivery support layered on top.

ChoiceX also includes a **direct chat system connecting buyers and sellers**. Rather than routing every question through a support desk, users can message the seller of a product directly — asking about specifications, availability, or order details in real time. This makes the shopping experience feel more personal for the buyer, and gives sellers a direct channel to build trust, answer questions quickly, and grow their own customer relationships.

<div align="center">

**Discover the product. Trust the details. Complete the purchase.**

</div>

---

## The Shopping Experience

```
              Secure Authentication
             (Email / Google / Facebook)
                         │
                         ▼
                    Home Screen
                         │
                         ▼
                 Browse Products
                         │
                         ▼
                 Product Details
                         │
        ┌────────────────┼──────────────────┐
        ▼                ▼                  ▼
     Rating          Similar             Variants
                      Products          (Color / RAM)
                                              │
                                              ▼
                              Add to Wishlist / Cart
                                              │
                                              ▼
                                Apply Promo Code
                                              │
                                              ▼
                         Checkout / Payment (Stripe)
                                              │
                                              ▼
                                    Place Order
                                              │
                                              ▼
                        Order Tracking (map + status)
                                              │
                                              ▼
                                Rate the Product
```

Firebase keeps product, user, order, and buyer-seller chat data in sync **in real time**. Stripe handles payment. Google Maps and location services support delivery tracking.

---

## Product Capabilities

| Area | What ChoiceX Provides |
|---|---|
| 🔐 **Authentication** | Email/password, Google Sign-In, Facebook Sign-In, and phone verification via pin code entry |
| 🔎 **Product Discovery** | Home feed, brand browsing, search, category and variant grids |
| 🛒 **Product Details** | Images, pricing, ratings, similar products, color/RAM variant selection |
| ❤️ **Wishlist & Cart** | Save products for later, manage cart quantities and totals |
| 🏷️ **Promotions** | Promo code entry and discount application at checkout |
| 💳 **Payments** | Stripe-based checkout and refund handling |
| 📦 **Orders** | Order placement, order summary, order details, real-time order tracking with map view |
| ⭐ **Ratings** | View and submit product ratings, rating-based filtering |
| 💬 **Messaging** | Direct in-app chat between buyer and seller — text, voice notes, emoji, and file attachments |
| 🔔 **Notifications** | Push notifications via Firebase Cloud Messaging and local notifications |
| 👤 **Account** | User dashboard, saved addresses, account and app settings |

---

## Architecture

ChoiceX follows a **layered Flutter structure** that cleanly separates configuration, core utilities, data access, application state, and UI.

```
Flutter App (Dart)
├── config           App-wide configuration
├── core             Constants, routes, theme, utils
├── data
│   ├── local        Local persistence
│   ├── models       Data models
│   ├── remote       Remote data sources
│   └── repository   auth, chat, notification, order, product repositories
├── services         Payment services (Stripe, refunds)
├── state
│   ├── auth
│   ├── bloc         flutter_bloc state management
│   └── provider     Provider-based state management
└── ui
    ├── common_widgets    Shared, reusable UI components
    └── screens           Feature screens
                │
                ▼
    Firebase (Auth, Firestore, Storage,
    Realtime Database, Cloud Messaging)
                │
                ▼
           Stripe Payments
```

### Repository Layer

Data access is centralized behind dedicated repositories so screens **never** talk to Firebase directly:

```
data/repository/
├── auth_repository.dart
├── chat_repository.dart
├── notification_repository.dart
├── order_repository.dart
└── product_repository.dart
```

### Screens

Each feature is isolated under its own folder in `ui/screens/`:

| Folder | Responsibility |
|---|---|
| `account/` | User account & profile |
| `auth/` | Sign-in / sign-up flows |
| `cart/` | Cart management |
| `chat/` | Buyer-seller messaging |
| `favorite/` | Wishlist |
| `home/` | Home feed & browsing |
| `more/` | Additional/settings menu |
| `order/` | Order list |
| `order_details/` | Order detail view |
| `order_summery/` | Order summary at checkout |
| `order_tracking/` | Real-time order tracking |
| `product/` | Product detail view |
| `promo_code_pop/` | Promo code entry |
| `search/` | Product search |
| `splash/` | Splash/launch screen |
| `user_address/` | Saved delivery addresses |
| `user_dashboard/` | User dashboard |
| `welcome_screen/` | Landing/entry screen |

### Architectural Principles

- ⚙️ Configuration, core utilities, and theming are isolated from feature screens.
- 🔌 All Firebase and Stripe access is routed through the `data/repository` and `services` layers — screens consume repositories, not SDKs directly.
- 🧠 State is managed with a mix of `flutter_bloc` (feature-level state) and `Provider` (shared/app-level state), each under its own folder in `state/`.
- 🧩 Reusable UI (buttons, text fields, loaders, product grids) lives in `ui/common_widgets` and is shared across every screen.
- 📁 Each customer-journey step — cart, checkout, order, tracking — is its own screen module rather than a single monolithic flow.

---

## Technology Stack

| Technology | Purpose |
|---|---|
| **Flutter** | Cross-platform mobile application development |
| **Dart** | Application programming language |
| **Firebase Core / Auth** | App initialization and secure user authentication |
| **Cloud Firestore** | Product, user, cart, and order data |
| **Firebase Realtime Database** | Real-time chat and live data sync |
| **Firebase Storage** | Product image and media storage |
| **Firebase Cloud Messaging** | Push notifications |
| **flutter_local_notifications** | Local device notifications |
| **flutter_bloc** | Feature-level state management |
| **Provider** | Shared/app-level state management |
| **Stripe (flutter_stripe)** | Payment processing and checkout |
| **Google Maps Flutter / flutter_map / latlong2** | Delivery and order location tracking |
| **Geocoding** | Address-to-coordinate resolution |
| **google_sign_in / flutter_facebook_auth** | Social authentication |
| **pin_code_fields** | OTP/phone verification input |
| **carousel_slider / smooth_page_indicator** | Product and content carousels |
| **flutter_rating_bar** | Product rating display and input |
| **image_picker / file_picker** | Media and file selection |
| **record / audioplayers / audio_waveforms** | Voice message recording and playback in chat |
| **emoji_picker_flutter** | Emoji picker for chat |
| **timeline_tile** | Order tracking timeline UI |
| **shared_preferences** | Local key-value storage |
| **google_fonts** | Custom typography |
| **http** | REST API communication |
| **permission_handler** | Runtime permission requests |
| **uuid** | Unique identifier generation |

---

## Getting Started

### Prerequisites

- ✅ Flutter SDK
- ✅ Dart SDK
- ✅ Android Studio or VS Code
- ✅ Android Emulator or physical Android device
- ✅ A configured Firebase project (`firebase_options.dart`)
- ✅ A Stripe account for payment testing

### Installation

```bash
# 1. Clone the repository
git clone <repository-url>

# 2. Navigate to the project
cd choiceX

# 3. Install dependencies
flutter pub get

# 4. Run the application
flutter run
```

---

## Useful Commands

| Command | Purpose |
|---|---|
| `flutter pub get` | Install project dependencies |
| `flutter run` | Run the app on a connected device/emulator |
| `flutter build apk` | Build a release Android APK |
| `flutter build ios` | Build a release iOS binary |
| `flutter analyze` | Static analysis and lint checks |
| `flutter test` | Run automated tests |

---

## Project Status

🟢 **Actively developed.** ChoiceX (User Application) currently covers the full customer journey:

- ✅ Authentication
- ✅ Product discovery
- ✅ Variant selection
- ✅ Wishlist & cart
- ✅ Promo codes
- ✅ Stripe payment
- ✅ Order placement and tracking
- ✅ Direct buyer-seller chat
- ✅ Notifications
- ✅ Product ratings

---

## License

This is a **private repository**. All rights reserved.

<div align="center">

Made with 💙 for the ChoiceX Platform

**Discover the product. Trust the details. Complete the purchase.**

</div>
