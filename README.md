CloneAI
CloneAI is an AI-powered app that brings multiple AI models together in one platform. Inspired by tools like ChatGPT and Gemini, it offers users seamless chatbot functionalities and aims to simplify interactions with AI technology.

-> Features
Chatbot Functionality: Provides accurate and efficient answers to user queries.
Multi-Model Access: Combines the power of multiple AI models in one app.
User-Friendly Interface: Intuitive design for effortless AI interactions.

-> Future Plans
Expand Model Library: Include more AI models for a diverse range of use cases.
Firebase Integration: Enable seamless data management and scalability.

Packages Used :-
go_router: Used for efficient and declarative routing within the application, enabling seamless navigation between different screens and views.
flutter_bloc: Implemented state management to handle complex UI updates and application logic, making the code more organized and maintainable.
animated_text_kit: Integrated engaging animations for text elements, enhancing the user experience with visually appealing transitions.
introduction_screen: Created an interactive onboarding experience for new users, guiding them through the app's key features and functionalities.
http: Facilitated making network requests to interact with external APIs, such as fetching AI model data, sending user input for processing, or retrieving results.
flutter_launcher_icons: Generated custom launcher icons for the application, providing a unique and visually appealing brand identity on the device's home screen.
 
File structure :- 
C:.  
│   main.dart 
│ 
├───consts 
│       color_consts.dart 
│       consts.dart
│       img_consts.dart
│
├───controller
│   └───cubits
│           chat_cubit.dart
│
├───font
│       Horizon-6YZP6.ttf
│       HorizonItalic-51mdz.ttf
│
├───model
│       chat_window.dart
│       conversation.dart
│
├───services
│       chatgpt.dart
│       gemini.dart
│
├───view
│   ├───auth
│   │       auth.dart
│   │
│   ├───home
│   │   ├───bottom_bar.dart
│   │   │       bottom_bar.dart
│   │   │
│   │   ├───drawer
│   │   │       main_drawer.dart
│   │   │
│   │   └───home_screen
│   │       │   home_screen.dart
│   │       │
│   │       └───chat_display
│   │               chat_display.dart
│   │
│   ├───intro_screen
│   │       intro_screen.dart
│   │
│   └───splash_screen
│           splash_screen.dart
│
└───widgets
        animated_text.dart
        text_field_auth.dart
