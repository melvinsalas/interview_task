# interview_task

__Ventrata__ interview task by `Melvin Salas`

## Getting Started

To run the application correctly, it is recommended to execute it by command or using VSCode in the following way:

- __Command shell__

```shell
$ flutter clean
$ flutter pub get
$ flutter run -d chrome --web-renderer html
```

- __VSCode__
    The `.vscode/launch.json` file contains the necessary commands for execution under the `launch` request. So you can use `Run & Debug` button.

## Functionalities:
1. __Authentication Flow:__
    - [x] Implement a simple authentication flow with a login page (no registration page needed).
    - [x] Authenticate via a free api - e.g. https://dummyjson.com/docs/auth (or other if you prefer) - and store the auth token for later.
    - [x] Upon successful authentication, navigate the user to a home page where you show the user data with a logout button.
    - [x] On a home page refresh the user data every 10 seconds by calling https://dummyjson.com/auth/me. (Refresh it only when the profile is visible!)
    - [x] If the auth token expires during any api request simply navigate to the login page. (no need to handle redirect after login)
    - [x] Automatically log in if the app is started while an auth token is available and not expired.
    - [x] Restrict navigation to all pages when there’s no auth token. Simply navigate to the login page.
2. __Dynamic products view:__
    - [x] Add bottom navigation to the home page - containing “Profile” and “Products” options. (This part is the “Products” option. Move the user details to the “Profile” option.)
    - [x] Request products from https://dummyjson.com/docs/auth/products every 30 seconds, but each time generate a random skip value for the request (`total=100`. `limit=10`. randomize only `skip=<0;90>`). __Refresh only when the Products are visible!__
    - [x] Add 2 additional fields to the product scheme besides the ones in the api response:
        - [x] __refreshed__ - number of times this product was downloaded. int type (default to 1).
        - [x] __amount__ - number of times this product will be bought. int type (default to 0)
    - [x] When you get new data add them to the ones you already have stored. If it’s a product you didn’t have before, simply add it. If it’s a product that you already had, increment it’s `refreshed` value by +1 and then override the old one.
    - [x] Show products (also the `refreshed` and `amount` fields) in a table and automatically update it based on the stored data. Don’t use StatefulWidget’s setState() for this!
    - [x] When you tap on any product show it’s details in a dialog with `+`, `-` buttons that modify it’s amount value, `Save` button that updates the product and `Remove` button that sets `amount=0`. (both “Save” and “Remove” buttons close the dialog)
3. __Nested Navigator (BONUS):__
    - [x] Use imperative navigation (= older pre-Router navigation) __in this new section only!__
    - [x] Add a 3th option - `Sale` - to the bottom navigation on the home page.
    - [x] First page here is a shopping cart page where you show a list of all products that have `amount>0` (just a simple `2x Product name` for each is fine) or just `Empty` if no product is selected and a `Checkout` button at the bottom.
        - [x] When you tap on any product use the same dialog as in Requirement #2, but don’t forget you use the imperative navigation in this section.
        - [x] When you press the `Checkout` button navigate to a payment page.
    - [x] On the payment page show a `Pay` button in the centre and “back” button in top left.
        - [x] When you press the `Pay` button navigate to a success page.
    - [x] On the success simply show `Sale successful` and navigate back to the shopping cart page after 5 seconds. Don’t show back button here.
        - [x] set `amount=0` on all products as well, so when you get back the cart is empty.
