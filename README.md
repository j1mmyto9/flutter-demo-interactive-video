# Demo Interactive Video

A new Flutter project to demo video interaction.

## Technical Details
- The project was developed using Flutter version 3.x It has been tested on Android and iOS devices.
- [video_player library](https://pub.dev/packages/video_player)

## Getting Started
To get started with this project, follow these steps:

1. Clone the repository to your local machine.
2. Run `flutter pub get` to install the required packages.
3. Run the app using `flutter run`.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)


## About Interactive Video
- Example Json to build interactive video
```Json
{
    "title":"Demo Video",
    "path":"assets/videos/demo_video.mp4",
    "timelines":[
        {
            "start":5,
            "end": 8,
            "question":{
                "title":"Q1: from 5 to 8",
                "answers":[
                    "Answer 1",
                    "Answer 2",
                    "Answer 3"
                ]
            }
        },
        {
            "start":15,
            "end": 20,
            "question":{
                "title":"Q1: from 15 to 20",
                "answers":[
                    "Answer 1",
                    "Answer 2",
                    "Answer 3"
                ]
            }
        }
    ]
}
```

### Screen Recording
