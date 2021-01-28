# [Dizzy](https://www.mayoclinic.org/diseases-conditions/dizziness/symptoms-causes/syc-20371787)

An app to check if you are dizzy or not, and further telling if you should drive or not.

## Techstack
* framework: [`flutter`](https://flutter.dev/)
* backend: [`firebase`](https://firebase.google.com/)

## Procedure
Simple, to check for dizzyness, just give the user a bunch of random directions to move their head into, check the latency, if it exceeds a certain limit, **boom** you have **mr/mrs dizzy** right there.

We can also check for mobile wobbling to give the user a warning without even giving the test.

## Inspiration
| Thing | Source|
|-------|-------|
| concept (kindof) | [netguru](https://dribbble.com/shots/11582376-Lime-Drunk-Test) |

## Little bit more
Alright, so there is no proof of concept, but I am kinda confident that this will work.
Also, one more thing, tracking the `eyes` (more specifically, `iris`), would be better, much better than moving your head around. **BUT**, since the user is dizzy and/or drunk, it kinda doesn't matter. **But** (yes, a **but** over a **but**), if the user is not an individual rather a third party using this for checking the soberiety of second party, this might be an issue, for the second party of course.
Also more research is needed for selecting the *optimatal latency range* (1-60 ms imo).
