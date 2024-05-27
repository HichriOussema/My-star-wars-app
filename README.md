# My-star-wars-app
# # Thortful iOS Challenge

## Overview

This project is a small iOS application written in Swift that interacts with the Star Wars API (https://swapi.dev). The app follows Apple Design Guidelines to create a clean and unobstructive UI. It includes pagination and navigation to detail pages.

## Requirements

- **Xcode 15.0.1 or later**
- **iOS 17.0 or later**

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/HichriOussema/My-star-wars-app.git
   cd My-star-wars-app/MyStarWarsApp
   ```
2.**Open the project in Xcode:**
 ```bash
open MyStarWarsApp.xcodeproj
```
3. Running the App:

Build and run the app in Xcode:
- Select the desired simulator or device.
- Press Cmd + R or click the Run button.

## Architecture
The app is structured following the MVVM (Model-View-ViewModel) pattern, which promotes a clean separation of concerns and enhances testability.

## Project Structure
- Models : Contains the data models for the app (e.g., Person, Species).
- ViewModels: Contains the logic and state for each view.
- Views: Contains the UI components.
- Repositories: Manages data operations, including network requests.

## Testing
Unit tests are included to validate the functionality of the app. The tests cover:

Network requests: Ensures the app correctly interacts with the Star Wars API.
ViewModels: Validates the business logic and state management.
## Running Tests

- Open the test navigator in Xcode:
- Press Cmd + 6 or click on the Test Navigator tab.
- Run all tests:
- Press Cmd + U or click the Run button in the test navigator

## Contributing
If you want to contribute, please follow these steps:
1. Fork the repository.
2. Create a new branch:
    ```sh
    git checkout -b feature-branch
    ```
3. Make your changes and commit them:
    ```sh
    git commit -m "Add new feature"
    ```
4. Push to the branch:
    ```sh
    git push origin feature-branch
    ```
5. Submit a pull request.

## License
This project is licensed under the MIT License.
