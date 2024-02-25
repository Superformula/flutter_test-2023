# RestauranTour

## Architectural proposal

### Presentation

The presentation layer oversees all UI/UX aspects, interacting with the domain layer, which contains all the business logic. This layer is completely abstracted from the implementation details of data computation; its sole responsibility is to request data and display it.

This is the typical folder structure:

- state-management
- view
- widgets

State management is where the implementation of Cubits/Blocs resides. These components request data from the domain layer and notify the UI when the data is ready to be displayed.

### Domain
The domain layer manages all business logic responsibilities.Its primary tasks include defining key contracts like entities and service functions. Additionally, it interfaces with external packages that supply specific functionalities.

This is the typical folder structure:

- entities
- extensions
- exceptions
- services_contracts
- services_logics

Service contracts store interfaces for the services, which will be implemented in the service_logics folder. These contracts serve as the foundation for the presentation layer, offering an abstraction of the implementation details.

Service logics interact with external functionality providers such as repositories and packages.

Extensions are employed to map models from external providers to the entities defined for the service. This is the only location that needs to be modified if there are changes in the provider, such as property types or data transmission methods.

### Packages


The primary concept behind using packages is to develop repositories (code components that interface with external systems) outside of the project's lib folder. This isolation ensures that they remain separate from project dependencies and conventions.

This approach facilitates easier maintenance of the more volatile data-provider layer, particularly for individuals outside the team who do not need to work with domain or presentation files.

Each service declared in the domain is expected to utilize at least one package. Packages should expose contracts for communication with the domain, ensuring that the domain remains unaware of package implementation details.


## Challenge details

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
