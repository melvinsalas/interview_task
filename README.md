# interview_task

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Flutter Senior Developer Interview Task

**Overview:** As a senior Flutter developer, you will often be tasked with architecting and implementing complex navigation flows within the application. This assessment focuses on evaluating your proficiency in app navigation.

## Instructions:

1. Set up a new Flutter project with FVM.
2. Create the necessary screens and components based on the provided requirements.
3. Write clean, efficient, and well-documented code.
4. Use flutter declarative routing - either via go_router package or directly using flutter Router sdk.
5. Use libraries as you deem fit. Keep it as simple as possible though.
6. Ensure the application works on web (local run only, no need to deploy it anywhere).
7. The logic is more important than UI, so you can make it however you want as long as it adheres to the requirements.
8. Upon completion, clean the project build folder, compress the project folder and submit it.

## Requirements:
1. __Authentication Flow:__
    - Implement a simple authentication flow with a login page (no registration page needed).
    - Authenticate via a free api - e.g. https://dummyjson.com/docs/auth (or other if you prefer) - and store the auth token for later.
    - Upon successful authentication, navigate the user to a home page where you show the user data with a logout button.
    - On a home page refresh the user data every 10 seconds by calling https://dummyjson.com/auth/me. (Refresh it only when the profile is visible!)
    - If the auth token expires during any api request simply navigate to the login page. (no need to handle redirect after login)
    - Automatically log in if the app is started while an auth token is available and not expired.
    - Restrict navigation to all pages when there’s no auth token. Simply navigate to the login page.
2. __Dynamic products view:__
    - Add bottom navigation to the home page - containing “Profile” and “Products” options. (This part is the “Products” option. Move the user details to the “Profile” option.)
    - Request products from https://dummyjson.com/docs/products every 30 seconds, but each time generate a random skip value for the request (`total=100`. `limit=10`. randomize only `skip=<0;90>`). Refresh only when the Products are visible!
    - Add 2 additional fields to the product scheme besides the ones in the api response:
        - __refreshed__ - number of times this product was downloaded. int type (default to 1).
        - __amount__ - number of times this product will be bought. int type (default to 0)
    - When you get new data add them to the ones you already have stored. If it’s a product you didn’t have before, simply add it. If it’s a product that you already had, increment it’s `refreshed` value by +1 and then override the old one.
    - Show products (also the `refreshed` and `amount` fields) in a table and automatically update it based on the stored data. Don’t use StatefulWidget’s setState() for this!
    - When you tap on any product show it’s details in a dialog with “+”, ”-” buttons that modify it’s amount value, “Save” button that updates the product and “Remove” button that sets `amount=0`. (both “Save” and “Remove” buttons close the dialog)
3. __Nested Navigator (BONUS):__
    - Use imperative navigation (= older pre-Router navigation) in this new section only!
    - Add a 3th option - “Sale” - to the bottom navigation on the home page.
    - First page here is a shopping cart page where you show a list of all products that have `amount>0` (just a simple “2x Product name” for each is fine) or just “Empty” if no product is selected and a “Checkout” button at the bottom.
        - When you tap on any product use the same dialog as in Requirement #2, but don’t forget you use the imperative navigation in this section.
        - When you press the “Checkout” button navigate to a payment page.
    - On the payment page show a “Pay” button in the centre and “back” button in top left.
        - When you press the “Pay” button navigate to a success page.
    - On the success simply show “Sale successful” and navigate back to the
shopping cart page after 5 seconds. Don’t show back button here.
        - set `amount=0` on all products as well, so when you get back the cart is empty.

__Note:__ Feel free to ask any clarifying questions if needed. Good luck!
            