# Superformula Mobile Test

## Overview

This project adopts Clean Architecture principles with a Feature First approach, designed for efficient and organized development. It integrates Yelp's GraphQL API to fetch restaurant data, complemented with a JSON containing preloaded information due to Yelp's daily request limits. Subsequent detail and review data for each restaurant are fetched in real-time.

## Project Structure

The codebase is structured into several directories, reflecting the logical separation of concerns as per Clean Architecture guidelines:

- `core`: Contains core functionality and helpers like `dio_helper.dart` for HTTP requests and `hive_helper.dart` for local persistence.
- `models`: Includes entity models such as `restaurant.dart`.
- `navigation`: Manages app routing with files like `route_navigator.dart`.
- `services`: Provides initialization and service setup through `app_init.dart`.
- `features`: Organized by individual screens/pages, e.g., `home_page` and `restaurant_page`, with each feature containing its own domain, data, and presentation logic.
- `repositories`: Contains `yelp_repository.dart` for fetching data from the Yelp API.
- `shared`: Houses reusable widgets such as `single_restaurant_card` and utility widgets like `status_indicator.dart`.

Additionally, the project makes use of `dotenv` to manage environment variables, enhancing security and configurability.

## Configuration

Prior to running the project, create or update the `.env` file at the root of the project with the following key:   YELP_API_KEY=thisISanApiKEYYouMUSTAdd


## Programming Paradigm

The application utilizes `oxidized` for functional programming, promoting a more robust, error-resistant development experience.




