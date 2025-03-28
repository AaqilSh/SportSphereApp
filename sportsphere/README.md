# Sports App

## Overview

This is a cross-platform sports application that allows users to browse leagues, view match fixtures, track their favorite teams, and receive real-time updates. Built using Flutter, the app ensures a smooth and responsive user experience on both Android and iOS devices. Firebase is used for authentication and Firestore for secure, real-time data storage.

## Features

- **User Authentication**: Secure sign-up, login, and password reset with Firebase Authentication.
- **Leagues & Fixtures**: Browse leagues, view match schedules, and track team performances.
- **Favorite Teams**: Users can select their favorite teams and get personalized updates.
- **Real-time Data Updates**: Firebase Firestore ensures instant updates to match results and team stats.
- **Accessibility Features**: Supports text resizing and high contrast mode for better readability.
- **Optimized Performance**: Uses efficient API calls, caching, and state management to reduce memory usage and enhance performance.

## Tech Stack

- **Frontend**: Flutter
- **Backend**: Firebase (Authentication & Firestore)
- **API Testing**: Postman
- **Version Control**: GitHub
- **Development Tools**: Android Studio, Flutter DevTools, Figma (for UI design)

## Installation

### Prerequisites

- Flutter installed ([Get Flutter](https://flutter.dev/docs/get-started/install))
- Android Studio or Visual Studio Code
- Firebase account setup ([Firebase Console](https://console.firebase.google.com/))

### Steps

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/sports-app.git
   ```
2. Navigate to the project folder:
   ```sh
   cd sports-app
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Set up Firebase:
   - Create a Firebase project.
   - Download and add `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) in the appropriate directories.
5. Run the app:
   ```sh
   flutter run
   ```

## Work Structure

The project followed the **Scrum methodology** with three development sprints. GitHub was used for version control and collaboration.

## Design and Implementation Decisions

- Cross-platform application with platform independence.
- Followed Material Design guidelines for Android and Cupertino guidelines for iOS.
- Integrated bottom navigation for better usability.
- Firebase Firestore was used for real-time data updates.

## Key Challenges & Solutions

- **Efficient API Calls**: Implemented caching to reduce unnecessary requests and optimize performance.
- **State Management**: Used Provider to avoid excessive re-rendering and reduce memory usage.
- **Performance on Low-End Devices**: Optimized animations, lazy loading, and minimized computations.

## Testing

- Used **Flutter test package** for unit and widget tests.
- **Postman** was used for API testing to validate seamless data retrieval.
- User testing with five participants provided valuable usability feedback.
- Addressed crashes by implementing error handling for null values in API responses.

## Security, Ethics, and Accessibility

- **Security**:
  - Firebase authentication with multi-factor authentication (MFA).
  - Encrypted API calls to prevent data breaches.
  - Secure API key storage.
- **Accessibility**:
  - Text resizing and high contrast mode for better readability.
- **Ethical Considerations**:
  - Provided users with clear terms and options to manage their data.
  - Minimal data collection, fully GDPR-compliant.

## Future Improvements

- Implement **real-time notifications** for match updates.
- Enhance error handling and add **offline support** for better usability.
- Improve UI responsiveness and refine state management strategies.

## Contributors

- **Ahamed Aqil Shihab** ([@AaqilSh](https://github.com/AaqilSh))

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
