# Dart Server Stack ✨🎯 🔨

Sample code showcasing usuag of Dart server stack using `shelf`, `shelf_router` and `webdev`.

**Table of Contents**

- [Flutter Conferences](#flutter-conferences)
- [My Pubdev](#my-pubdev)
- [Pub API](#pub-api)
- [Checklist](#checklist)
- [Run Locally](#run-locally)

### Flutter Conferences

All Flutter COnferences in one place! This code showcases building a webapp which serves html using `mustache` templating engine and `scss`. It uses the shelf package to serve files using Pipeline() and Cascade() classes using Middlewares.

![conf](/screenshots/conf.png)
![conf](/screenshots/engage.png)

### My Pubdev

A personalized clone of pubdev which displays a list of packages fetched from backend. This was built using the `webdev` package and uses dart to manipulate the DOM once packages are fetched from the server.

![conf](/screenshots/pub.png)

### Pub API

this project mimics the pub api for fetching packages, it implements appropriate routes using `shelf_router` package and responds with JSON data from a file using the hosted pub repository specification.

**API Endpoints**

| Route                | Description       | Method |
| -------------------- | ----------------- | ------ |
| /api/                | Test endpoint     | GET    |
| /api/packages/       | Get all packages  | GET    |
| /api/package/        | Add a new package | POST   |
| /api/package/< name> | Get a package     | GET    |
| /api/package/< name> | Delete a package  | DELETE |

### Checklist

- [x] Server using shelf
- [x] Server using shelf_router with API endpoints
- [x] Serve static files
- [x] Use mustache templating engine
- [x] Compile dart to js using webdev for Client side
- [x] CSS styling using SCSS
- [x] API headers using pub hosted specification
- [x] Add Tests to `shelf_router_example`

### Run Locally

- Clone the repository
- Ensure Dart SDK is installed
- `dart pub get` inside each folder

- Run by either running

  ```bash
  dart bin/server.dart
  ```

  or

  ```bash
  nodemon exec
  ```

- for running webdev_example,

  ```bash
  dart pub global install webdev
  ```

  and then

  ```bash
  webdev serve
  ```
