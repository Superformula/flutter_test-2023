# RestauranTour

Be sure to read **all** of this document carefully, and follow the guidelines within.

## Vendorized Flutter

3. We use [fvm](https://fvm.app/) for managing the flutter version within the project. Using terminal, while being on the test repository, install the tools dependencies by running the following commands:

    ```sh
    dart pub global activate fvm
    ```

    The output of the command will ask to add the folder `./pub-cache/bin` to your PATH variables, if you didn't already. If that is the case, add it to your environment variables, and restart the terminal.

    ```sh
    export PATH="$PATH":"$HOME/.pub-cache/bin" # Add this to your environment variables
    ```

4. Install the project's flutter version using `fvm`.

    ```sh
    fvm use
    ```

5. From now on, you will run all the flutter commands with the `fvm` prefix. Get all the projects dependencies.

    ```sh
    fvm flutter pub get
    ```

More information on the approach can be found here:

> hhttps://fvm.app/docs/getting_started/installation

From the root directory:


### IDE Setup

<details>
<summary>Use with VSCode</summary>
<p>

If you're a VScode user link the new Flutter SDK path in your settings
`$projectRoot/.vscode/settings.json` (create if it doesn't exist yet)

```json
{
  "dart.flutterSdkPath": ".fvm/flutter_sdk"
}
```


</p>
</details>

<details>
<summary>Use with IntelliJ / Android Studio</summary>
<p>

Go to `Preferences > Languages & Frameworks > Flutter` and set the Flutter SDK path to `$projectRoot/.fvm/flutter_sdk`

<img width="800" alt="IntelliJ Settings" src="https://user-images.githubusercontent.com/1096485/64658026-3a1fdd00-d436-11e9-9457-556059f68e2c.png">

</p>
</details>

## Requirements

### App Structure

#### Restaurant List Page

- Tab Bar
  - List of favorites (stored client side)
  - List of businesses
    - Hero image
    - Name
    - Price
    - Category
    - Rating (rounded to the nearest value)
    - Open/Closed

#### Restaurant Detail View

- Ability to favorite a business
- Name
- Hero image
- Price and category
- Address
- Rating
- Total reviews
- List of reviews
  - User name
  - Rating
  - User image
  - Review Text (These are just snippets of the full review, usually like 3-4 lines long)

#### Misc.

- Clear documentation on the structure and architecture of your application.
- Clear and logical commit messages.
  - We suggest following [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

## Test Coverage

To demonstrate your experience writing different types of tests in Flutter please do the following:

- Choose ONE portion of your state management and write a unit test.
- Choose ONE widget and write a widget test.

Feel free to add more tests as you see fit but the above is the minimum requirement.

## Design

- See this [Figma File](https://www.figma.com/file/KsEhQUp66m9yeVkvQ0hSZm/Flutter-Test?node-id=0%3A1) for design information related to the overall look and feel of the application. We do not expect pixel-perfection but would like the application to visually be close to what is specified in the Figma file.

![List View](screenshots/listview.png)
![Detail View](screenshots/detailview.png)

## API

The [Yelp GraphQL API](https://www.yelp.com/developers/graphql/guides/intro) is used as the API for this Application. We have provided the boilerplate of the API requests and backing data models to save you some time. To successfully make a request to the Yelp GraphQL API, please follow these steps:

1. Please go to https://www.yelp.com/signup and sign up for a developer account.
1. Once signed up, navigate to https://www.yelp.com/developers/v3/manage_app.
1. Create a new app by filling out the required information.
1. Once your app is created, scroll down and join the `Developer Beta`. This allows you to use the GraphQL API.
1. Copy your API Key from your app page and paste it on `line 5` [yelp_repository.dart](app/lib/yelp_repository.dart) replacing the `<PUT YOUR API KEY HERE>` with your key.
1. Run the app and tap the `Fetch Restaurants` button. If you see a log like `Fetched x restaurants` you are all set!

## Technical Requirements

### State Management

Please restrict your usage of state management or dependency injection to the following options:

1. [provider](https://pub.dev/packages/provider)
2. [Riverpod](https://pub.dev/packages/riverpod)
3. [bloc](https://pub.dev/packages/bloc)
4. [get_it](https://pub.dev/packages/get_it)/[get_it_mixins](https://pub.dev/packages/get_it_mixin)
5. [Mobx](https://pub.dev/packages/mobx)

We ask this because this challenge values consistency and efficiency over ingenuity. Using commonly used libraries ensures that we can review your code in a timely manner and allows us to provide better feedback.

## Coding Values

At **Superformula** we strive to build applications that have

- Consistent architecture
- Extensible, clean code
- Solid testing
- Good security & performance best practices

### Clear, consistent architecture

Approach your submission as if it were a real world app. This includes Use any libraries that you would normally choose.

_Please note: we're interested in your code & the way you solve the problem, not how well you can use a particular library or feature._

### Easy to understand

Writing boring code that is easy to follow is essential at **Superformula**.

We're interested in your method and how you approach the problem just as much as we're interested in the end result.

### Solid testing approach

While the purpose of this challenge is not to gauge whether you can achieve 100% test coverage, we do seek to evaluate whether you know how & what to test.

## Q&A

> Where should I send back the result when I'm done?

Please fork this repo and then send us a pull request to our repo when you think you are done. There is no deadline for this task unless otherwise noted to you directly.

> What if I have a question?

Just create a new issue in this repo and we will respond and get back to you quickly.

## Review

The coding challenge is a take-home test upon which we'll be conducting a thorough code review once complete. The review will consist of meeting some more of our mobile engineers and giving a review of the solution you have designed. Please be prepared to share your screen and run/demo the application to the group. During this process, the engineers will be asking questions.

---

## Clear documentation on the structure and architecture of your application.

I based the app structure on a mix of "package by layer" and "package by feature" called as "package by convenience" on [this book](https://www.kodeco.com/14214369-infinite-scrolling-pagination-in-flutter).

Basically follow similar rules:
### 1 Features get their own package

In this project a feature can be considered as any screen

### 2 Features don't know each other

The navigation responsability is designated to the [AppRouter](lib\app_router.dart)

### 3 Repositories get their own package

In this project, repository was understood as data sources and each one got their own package
- [YelpRepository](packages\yelp_repository\lib\src\yelp_repository.dart): Responsible to retrieve data from yelp api
- [LocalStorage](packages\local_storage\lib\src\local_storage.dart): Responsible to store data in the device

### 4 Specialized packages

Code that are meant for one specific purpose, but can be used in more than one place
- [Component Library](packages\component_library): Widgets that were made by design team and are meant to be used in more than one place
- [Domain Models](packages\domain_models): Data classes that will be used in the features (screens). Other packages that handle other data type must use the other data type only internally.

## Tests

The tests were made in the following files:
- [unit test](packages\features\restaurant_detail\test\unit\restaurant_detail_cubit_test.dart)
- [widget/flow test](test\widget_test.dart)

## Environment setup
If you are using a mac you can:
- update the [.env_prod](assets\env\/.env_prod) file with the yelp api key
  - the other file was created to showcase the ability to work on a different environment and do not impact production
- open the terminal at the project folder and execute: `make setup;`
- execute the project
  - the vs code is already setup to launch the correct files, so you can find the runner at the top left on yours and choose `app-prod` and run it
  - in android studio is necessary to setup the corrent files:
    - Open your project in Android Studio.
    - Go to Run -> Edit Configurations....
    - Click on the + button at the top left of the Run/Debug Configurations dialog to add a new configuration.
    - Select Flutter.
    - In the Name field, enter the name of the configuration (e.g., "app-dev").
    - In the Dart entrypoint field, enter the path to the Dart file you want to run (e.g., "lib/main_dev.dart").
    - Click OK to save the configuration.