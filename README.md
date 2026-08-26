# ChoiceX — User Application

<p align="center">
  <img src="assets/logo.png" width="180" alt="ChoiceX Logo">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/status-active-brightgreen" alt="Project Status">
  <img src="https://img.shields.io/badge/platform-Flutter-02569B?logo=flutter&logoColor=white" alt="Platform">
  <img src="https://img.shields.io/badge/language-Dart-0175C2?logo=dart&logoColor=white" alt="Language">
  <img src="https://img.shields.io/badge/backend-Firebase-FFCA28?logo=firebase&logoColor=black" alt="Backend">
  <img src="https://img.shields.io/badge/payments-Stripe-635BFF?logo=stripe&logoColor=white" alt="Payments">
  <img src="https://img.shields.io/badge/license-private-lightgrey" alt="License">
</p>

<p align="center">
A full-stack Flutter electronics e-commerce application covering the complete customer journey — from secure authentication and product discovery to cart, checkout, payment, order tracking, and in-app chat.
</p>

---

## Overview

**ChoiceX** is an electronics e-commerce application built with Flutter and backed by Firebase.

This repository contains the **user-facing (customer) application** — the app end customers install to browse, buy, and track orders. It does not include any admin or seller-side tooling.

Users authenticate securely, browse a catalog of electronic products, and evaluate each product through images, pricing, ratings, and variant options such as **color and RAM** before adding it to their cart. From there, ChoiceX carries the user through coupon application, Stripe payment, order placement, real-time order tracking, and post-purchase rating — with in-app chat, notifications, and location-aware delivery support layered on top.

> **Discover the product. Trust the details. Complete the purchase.**

---

## The Shopping Experience

```
Secure Authentication
        ↓
    Home Screen
        ↓
 Browse Products
        ↓
 Product Details
        ↓
 ┌──────┼───────────┐
 ↓      ↓           ↓
Rating  Similar    Variants
        Products   (Color / RAM)
        ↓
   Add to Wishlist / Cart
        ↓
    Apply Promo Code
        ↓
   Checkout / Payment (Stripe)
        ↓
    Place Order
        ↓
 Order Tracking (map + status)
        ↓
   Rate the Product
```

Firebase keeps product, user, order, and chat data in sync in real time. Stripe handles payment. Google Maps and location services support delivery tracking.

---

## Product Capabilities

| Area | What ChoiceX provides |
|---|---|
| **Authentication** | Email/password and Google Sign-In, phone verification via pin code entry |
| **Product discovery** | Home feed, brand browsing, search, category and variant grids |
| **Product details** | Images, pricing, ratings, similar products, color/RAM variant selection |
| **Wishlist & cart** | Save products for later, manage cart quantities and totals |
| **Promotions** | Promo code entry and discount application at checkout |
| **Payments** | Stripe-based checkout and refund handling |
| **Orders** | Order placement, order summary, order details, real-time order tracking with map view |
| **Ratings** | View and submit product ratings, rating-based filtering |
| **Messaging** | In-app chat with text, voice notes, emoji, and file attachments |
| **Notifications** | Push notifications via Firebase Cloud Messaging and local notifications |
| **Account** | User dashboard, saved addresses, account and app settings |

---

## Architecture

ChoiceX follows a layered Flutter structure that separates configuration, core utilities, data access, application state, and UI.

```
Flutter App (Dart)
  ├── config           App-wide configuration
  ├── core             Constants, routes, theme, utils
  ├── data
  │   ├── local         Local persistence
  │   ├── models        Data models
  │   ├── remote         Remote data sources
  │   └── repository    auth, chat, notification, order, product repositories
  ├── services          Payment services (Stripe, refunds)
  ├── state
  │   ├── auth
  │   ├── bloc          flutter_bloc state management
  │   └── provider      Provider-based state management
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

Data access is centralized behind dedicated repositories so screens never talk to Firebase directly:

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

```
ui/screens/
├── account/
├── auth/
├── cart/
├── chat/
├── favorite/
├── home/
├── more/
├── order/
├── order_details/
├── order_summery/
├── order_tracking/
├── product/
├── promo_code_pop/
├── search/
├── splash/
├── user_address/
├── user_dashboard/
└── welcome_screen/
```

### Architectural Principles

- Configuration, core utilities, and theming are isolated from feature screens.
- All Firebase and Stripe access is routed through the `data/repository` and `services` layers — screens consume repositories, not SDKs directly.
- State is managed with a mix of `flutter_bloc` (feature-level state) and `Provider` (shared/app-level state), each under its own folder in `state/`.
- Reusable UI (buttons, text fields, loaders, product grids) lives in `ui/common_widgets` and is shared across every screen.
- Each customer-journey step — cart, checkout, order, tracking — is its own screen module rather than a single monolithic flow.

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

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Android Emulator or physical Android device
- A configured Firebase project (`firebase_options.dart`)
- A Stripe account for payment testing

### Installation

```bash
# Clone the repository
git clone <repository-url>

# Navigate to the project
cd choiceX

# Install dependencies
flutter pub get

# Run the application
flutter run
```

### Useful Commands

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

ChoiceX (User Application) is an actively developed Flutter e-commerce application covering the full customer journey: authentication, product discovery, variant selection, wishlist, cart, promo codes, Stripe payment, order placement and tracking, in-app chat, notifications, and product ratings.

This is a private repository. All rights are reserved.

> **Discover the product. Trust the details. Complete the purchase.**