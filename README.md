# [Dizzy](https://www.mayoclinic.org/diseases-conditions/dizziness/symptoms-causes/syc-20371787)

An app to check if you are dizzy or not, and further telling if you should drive or not.

![Flutter CI](https://github.com/Illusion47586/dizzy/workflows/Flutter%20CI/badge.svg)
![Supports](https://img.shields.io/badge/Supports-Android-green)

## Techstack
* framework: [`flutter`](https://flutter.dev/)
* backend: [`firebase`](https://firebase.google.com/)

## Procedure
Simple, to check for dizzyness, just give the user a bunch of random directions to move their head into, __basically tracking the nose__, check the latency, if it exceeds a certain limit, **boom** you have **mr/mrs dizzy** right there.

We can also check for mobile wobbling to give the user a warning without even giving the test.

## Inspiration / reasons / purpose etc idk
| Thing | Source|
|-------|-------|
| concept (kindof) | [netguru](https://dribbble.com/shots/11582376-Lime-Drunk-Test) |
| Deaths due to **drunken driving** | [article](https://www.sundayguardianlive.com/news/drunk-driving-led-38000-road-mishaps-three-years#:~:text=As%20per%20the%20ministry%27s%20data,are%20due%20to%20drunk%20driving.)|

## Little bit more
Alright, so there is no proof of concept, but I am kinda confident that this will work.
Also, one more thing, tracking the `eyes` (more specifically, `iris`), would be better, much better than moving your head around. **BUT**, since the user is dizzy and/or drunk, it kinda doesn't matter. **But** (yes, a **but** over a **but**), if the user is not an individual rather a third party using this for checking the soberiety of second party, this might be an issue, for the second party of course. But the major reason I am not implementing this is because... I am unable to. Firebase ML Vision does not offer such service, web technologies like [`webgazer.js`](https://webgazer.cs.brown.edu/) need to be calibrated almost every time, hence are not so much practical for the end user.

*Also more research is needed for selecting the `optimal latency range` (1-60 ms imo).*

This can help a lot in preventing accidents due to drunken driving. Moreover since `EVs` are going to takeover the market, vehicles can connect to the `mobile device` and help the user check if he/she is in a stable condition to drive or not. This is in no way or sense a **soberiety or drunk test**, maybe in the future depending on the accuracy of the model used (instead of firebase).

*Interested in implementing this somewhere? Let's chat! [`here`](https://dhruv-tiwari.netlify.app/)*

## Formatting
Used VS code with following extensions:
1. [Awesome Flutter Snippets](https://marketplace.visualstudio.com/items?itemName=Nash.awesome-flutter-snippets)
2. [Better Comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments)
3. [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
4. [dart-import](https://marketplace.visualstudio.com/items?itemName=luanpotter.dart-import) : for managing imports
5. [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
6. [Pubspec Assist](https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist)

All formatting done using normal [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code) formatter and imports were formatted using [dart-import](https://marketplace.visualstudio.com/items?itemName=luanpotter.dart-import).
