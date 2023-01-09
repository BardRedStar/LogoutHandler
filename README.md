# Logout Handler

A logout handling solution for synchronous and asynchronous operations

## 💿 Installation 

Add `LogoutHandlers` and `Extensions` directories from this repository to your project somewhere and that's it!

## 📦 What is included

### Single Handlers

To perform single logout action (API call, navigation redirect, cookie deletion, etc.) you can use 
`LogoutHandler` implementation. There are some included basic handlers, but you have to define your own handlers
for your purposes. 

Included handlers:
* `LogoutHandler` - a generic protocol for single handlers (see *How to add a custom single handler*).
* `APILogoutHandler` - a simple example of asynchronous logout handler, for example API call for logging out.
* `NavigationLogoutHandler` - a handler that should perform some navigation action after logout logic.

### Composite Handlers

To perform several logout actions in specific order you can define `CompositeLogoutHandler` implementation.
There are two generic implementations for synchronous and asynchronous handlers 
and convenient result builder for declare logout actions in closure without an array or varargs.

Included handlers
* `CompositeLogoutHandler` - a generic protocol for composite handlers (see *How to add a custom composite handler*)
* `SyncCompositeLogoutHandler` - a handler that performs several handlers one-by-one in sequence
* `AsyncCompositeLogoutHandler` - a handler that performs several handlers asynchronous to each other
* `LogoutHandlerComposed` - a result builder to declare handlers in declarative way (like views in SwiftUI)

## 🔨 Adding custom handlers

### How to add a custom single handler

To add a custom single handler, simply implement the `LogoutHandler` protocol into your class/struct. 

### How to add a custom composite handler

If you need to perform handlers in a specific order, you can implement `CompositeLogoutHandler`. protocol in your class/struct.
Simply save handlers array from initializer and perform handlers in desired order in `logout()` method.

## 🪄 How to use 

Imagine we need to perform logout with API call and clear web cookies, and then navigate to "Sign in" page.

First, since we don't have exact logout handler to clear web cookies, we have to create custom logout handler:

```swift
import Foundation

class CookieLogoutHandler: LogoutHandler {

    func logout() async throws {
        // Clear cookies
    }
}
```

Then create initial logout handler, that will be called on logout. It should perform API logout and cookie cleaning
asynchronously, and then navigate to "Sign in" screen.

```swift
let logoutHandler = SyncCompositeLogoutHandler {
    AsyncCompositeLogoutHandler {
        APILogoutHandler()
        CookieLogoutHandler()
    }
    NavigationLogoutHandler {
        // Navigate to "Sign in" screen
    }
}
```

And call it in logout:

```swift
Task {
    try? await logoutHandler.logout()
}
```