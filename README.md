# RestauranTour


## Welcom to RestauranTour!

The idea of this project is to help you to choose the best restaurants!

### Some features:
- Navigate through the available restaurants and see basic information like `opened status`, `price` and `classification` from other users directly from the list.
- See details of the restaurant, when you open a restaurant the details page will show you more information like `review` from users.
- Save the best! On the details screen you can add to favorites those restaurant make you heartbeat!
- Favorite list shows all the restaurant that you love.  

## Setup:


To make things easier, we are using Makefile to manage the commands and setup you project.

Before start with Make commands, make sure that you have installed the fvm in your system, see [Vendorized Flutter](#vendorized-flutter) before.

#### 1 - make setup-fvm-version 

Now that you have installed the fvm, by running the command `fvm --version` this should return the fvm version installed in your system like this:
 ```
$ fvm --version
2.4.1
```
Now we can proceed, well as mentioned before, we will use make for make things for us. To setup the fvm version run the following command:

``` bash
make setup-fvm-version
```
The curremt version of Flutter is `3.16.8` but don't worry about setup this, `make setup-fvm-version` will do it automatically.

> Make setup-fvm-version will run the following commands: `fvm install 3.16.8` and `fvm global 3.16.8`

This will download the version that we are using on the project, and setup as global.

### 2 - make setup

This will setup all things that we need work on the project.
To make sure that everything is working well, `make setup` will run some commands:

Pre-setup:

- `flutter clean` # clean the flutter project
-	`dart run build_runner clean` # clean the build runner
- `dart pub global activate arb_utils` # activate the arb_utils package to generate locales
-	`dart pub global activate flutter_gen` # activate the flutter_gen package for management assets

Setup:
- `get` # flutter pub get
- `l10n` # generate the locales and sort
- `gen` # generate the models
- `asset-gen` # generate the assets
- `setup-env-file` # generate the `.env` file
- `unit-tests` # run unit tests to ensure everything is working

<details>
<summary>All make commands available</summary>

<ul>
<details>
<summary>Setup</summary>

<ul><b>get</b> <i># run flutter pub get</i></ul>
<ul><b>setup-fvm-version</b> <i># download and setup the fvm flutter version for the project</i></ul>
<ul><b>pre-setup</b> <i># clean the project and install some dependencies</i></ul>
<ul><b>setup-env-file</b> <i># generate the .env file</i></ul>
<ul><b>setup</b> <i># run pre-setup, setup-env-file, run code generation and run unit tests</i></ul>
<ul><b>try-fix-gen</b> <i># try run code generation if fail try fix and run code generation again</i></ul>
<ul><b>fix-gen</b> <i># perform some steps to fix code generation</i></ul>

</details>
</ul>

<ul>
<details>
<summary>Tests</summary>
<ul><b>tests</b> <i># run unit and golden tests</i></ul>
<ul><b>all-tests</b> <i># run all type of tests on project, unit, golden and integration</i></ul>
<ul><b>unit-tests</b> <i># run only unit tests</i></ul>
<ul><b>tests-ci-cd</b> <i>#run tests with a flag that enable threshold for golden tests on pipeline</i></ul>
<ul><b>integration-tests</b> <i># run integration test</i></ul>
<ul><b>update-goldens</b> <i># update the golden images</i></ul>
<ul><b>remove-goldens-failures</b> <i># this remove the failure folder of golden tests</i></ul>
</details>
</ul>

<ul>
<details>
<summary>Coverage</summary>
See <a href="#coverage-reports---lcov">Coverage reports</a>

<ul><b>lcov</b> <i># run the tests and show the coverage report filtered</i></ul>
<ul><b>show-coverage</b> <i># run tests and show the coverage report</i></ul>
<ul><b>lcov-ignore</b> <i># remove some files from coverage report</i></ul>
</details>
</ul>

<ul>
<details>
<summary>Code gen</summary>
<ul><b>l10n</b> <i># generate the localization files</i></ul>
<ul><b>asset-gen</b> <i># generate the assets file</i></ul>
<ul><b>gen</b> <i># generate models using build_runner</i></ul>
</details>
</ul>

</details>


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


## Vendorized Flutter

We use [fvm](https://fvm.app/) for managing the flutter version within the project. Using terminal, while being on the test repository, install the tools dependencies by running the following commands:

```sh
    dart pub global activate fvm
```

The output of the command will ask to add the folder `./pub-cache/bin` to your PATH variables, if you didn't already. If that is the case, add it to your environment variables, and restart the terminal.

```sh
export PATH="$PATH":"$HOME/.pub-cache/bin" # Add this to your environment variables
```



More information on the approach can be found here:

> hhttps://fvm.app/docs/getting_started/installation

[Back to setup](#setup)

## Coverage reports - lcov
LCOV is an extension of GCOV, a GNU tool which provides information about
what parts of a program are actually executed (i.e. "covered") while running
a particular test case. The extension consists of a set of Perl scripts
which build on the textual GCOV output to implement the following enhanced
functionality:

- HTML based output: coverage rates are additionally indicated using bar
graphs and specific colors.

- Support for large projects: overview pages allow quick browsing of
coverage data by providing three levels of detail: directory view,
file view and source code view.

LCOV was initially designed to support Linux kernel coverage measurements,
but works as well for coverage measurements on standard user space
applications.

<a href="https://formulae.brew.sh/formula/lcov">Install on Linux/MacOs using brew</a>

<a href="https://community.chocolatey.org/packages/lcov?source=post_page-----7c58dda07080--------------------------------">Install on Windows</a>


[Back to make](#2---make-setup)