# Blueprint: Stock Point App

## Overview

Stock Point is a Flutter application for sales distributors to manage clients, products, and orders. The app will feature user authentication, client and product management, and order creation and tracking.

## Current State and Features

### Implemented Features:
* **Initial Project Structure:** Basic Flutter project structure.
* **Data Models:**
    * `Usuario`: User model.
    * `Cliente`: Client model.
    * `Producto`: Product model.
    * `Pedido`: Order model.
    * `DetallePedido`: Order Detail model.
* **Mock Data:** Local data for users, clients, products, and orders.

### Style and Design:
* **Theme:** Standard Material Design theme.
* **UI:** To be defined.

## Plan for Current Request

### Goal: Implement Basic Authentication Flow

The goal is to create a complete authentication flow (Register -> Login -> Home) using mock data for persistence.

### Steps:

1.  **Create Screens:**
    *   `SplashScreen`: Initial screen to check user session.
    *   `LoginScreen`: User login screen.
    *   `RegisterScreen`: User registration screen.
    *   `HomeScreen`: Main screen after login.

2.  **Implement Authentication Logic:**
    *   Create an `AuthService` to handle user authentication (login, registration, logout) using mock data.
    *   Manage user session in memory.

3.  **Configure Routes:**
    *   Use `go_router` for declarative navigation.
    *   Define routes for all screens.
    *   Implement redirection logic based on authentication status.

4.  **Update UI:**
    *   Design and implement the UI for each screen.
    *   Create a consistent and intuitive user experience.

5.  **Integrate with `main.dart`:**
    *   Initialize the `AuthService` and `go_router`.
    *   Set up the initial route of the application.
