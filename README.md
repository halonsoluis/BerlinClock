[//]: # "Badges"

[![pipeline status](https://github.com/2021-DEV2-012/BerlinClock/workflows/BerlinClockCI/badge.svg)](https://github.com/2021-DEV2-012/BerlinClock/actions)
[![Swift version](https://img.shields.io/badge/swift-5.3-orange.svg)](https://swift.org/blog/swift-5-3-released/)
[![Lines of Code](https://sonarcloud.io/api/project_badges/measure?project=2021-DEV2-012_BerlinClock&metric=ncloc)](https://sonarcloud.io/dashboard?id=2021-DEV2-012_BerlinClock)
[![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=2021-DEV2-012_BerlinClock&metric=code_smells)](https://sonarcloud.io/dashboard?id=2021-DEV2-012_BerlinClock)
[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=2021-DEV2-012_BerlinClock&metric=bugs)](https://sonarcloud.io/dashboard?id=2021-DEV2-012_BerlinClock)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=2021-DEV2-012_BerlinClock&metric=sqale_rating)](https://sonarcloud.io/dashboard?id=2021-DEV2-012_BerlinClock)

# Berlin Clock (**Mengenlehreclock** or **Berlin Uhr**)

The Mengenlehreuhr (German for "Set Theory Clock") or Berlin-Uhr ("Berlin Clock") is the first public clock in the world that tells the time by means of illuminated, coloured fields, for which it entered the Guinness Book of Records upon its installation on 17 June 1975. Commissioned by the Senate of Berlin and designed by Dieter Binninger, the original full-sized Mengenlehreuhr was originally located at the Kurfürstendamm on the corner with Uhlandstraße. After the Senate decommissioned it in 1995, the clock was relocated to a site in Budapester Straße in front of Europa-Center, where it stands today.

This characteristic clock tells the time using a series of illuminated coloured blocks and it's read from top to bottom.

![Berlin-Uhr-1650-1705](https://user-images.githubusercontent.com/80991609/111852161-3f58c480-8916-11eb-9de0-2d0704ce2285.gif)

- The top big lamp - (yellow) - (blinks to show seconds and it's illuminated only on even seconds).

- The first line - 4 lamps (red) - (each lamp represents five hours).

- The second line - 4 lamps (red) - (each lamp represents one hour).

- The third line - 11 lamps (yellow, every 3rd is red) - (each lamp represents five minutes).

- The fourth line - 4 lamps (yellow) - (each lamp represents one minute).

## The Kata

This kata has been used already for more than 9 years as of now (2021), and it's normally used on live coding sessions.

[On the stage](https://youtu.be/9jGH-rKKlIY), the idea is to use Test Driven Development (TDD) and implement the core clock logic by returning a string representation of the time.
This representation is based on the colors read from top to bottom. (Y or R or 0 (off))

For more dedicated exercises, as the current one, an implementation of a visual interface that would present the clock working on real time is also required.

## References

- http://www.surveyor.in-berlin.de/berlin/uhr/indexe.html
- https://github.com/stephane-genicot/katas/blob/master/BerlinClock.md
- https://de.wikipedia.org/wiki/Berlin-Uhr
- https://www.matrix-development.de/wa_files/berlinclock01_en.pdf
- https://mheinzerling.de/blog/code-kata-berlin-clock/
- http://agilekatas.co.uk/katas/BerlinClock-Kata
- https://technologyconversations.com/2014/01/13/scala-tutorial-through-katas-berlin-clock-easy/
