<p align="center">
  <img src=".github/assets/banner.svg" width="100%" alt="Speedometer Gauge — a spring-animated, non-linear speedometer gauge built entirely in SwiftUI">
</p>

<p align="center">
  <img alt="platform" src="https://img.shields.io/badge/platform-iOS%20·%20iPadOS%2018.5%2B-0B788E?style=flat-square&labelColor=131615">
  <img alt="swift" src="https://img.shields.io/badge/swift-5-0B788E?style=flat-square&labelColor=131615">
  <img alt="ui" src="https://img.shields.io/badge/ui-SwiftUI-0B788E?style=flat-square&labelColor=131615">
  <img alt="state" src="https://img.shields.io/badge/state-Observation-0B788E?style=flat-square&labelColor=131615">
</p>

<p align="center">
  <a href="#overview">Overview</a> &nbsp;·&nbsp;
  <a href="#features">Features</a> &nbsp;·&nbsp;
  <a href="#getting-started">Getting started</a> &nbsp;·&nbsp;
  <a href="#how-it-works">How it works</a> &nbsp;·&nbsp;
  <a href="#architecture">Architecture</a>
</p>

<br>

## Overview

Speedometer Gauge is a polished, fully native gauge built with SwiftUI shapes, gradients and spring physics, with no images and no third-party dependencies. It maps values from 0 to 100k+ onto a non-linear dial, so small and very large numbers are both easy to read at a glance. It's a good fit for dashboards, analytics views and anywhere a single number deserves some drama.

## Features

| Capability | What it does |
| --- | --- |
| **Non-linear scale** | Ticks at 0, 1k, 5k, 10k, 25k, 50k and 100k+, evenly spaced across a 230° sweep, with values interpolated between them. |
| **Spring-animated needle** | The needle and progress arc move together with a tuned spring (`response 0.6`, `damping 0.8`). |
| **Animatable progress arc** | A custom `Shape` with `animatableData`, so the arc grows smoothly instead of jumping. |
| **Onboarding sweep** | On launch the needle sweeps to maximum, then settles on the starting value. |
| **Compact formatting** | Readouts are shortened automatically: `15200` → `15.2k`, `2500000` → `2.5M`. |
| **Live input** | Type any number and submit to drive the gauge; values above 100k are capped on the dial. |
| **Self-positioning labels** | Tick labels measure their own width and sit precisely along the dial edge. |

## Getting started

**Requirements:** Xcode 16.4 or later (iOS 18.5 SDK), and an iPhone or iPad simulator or device running iOS 18.5+.

```bash
git clone https://github.com/SyedAliMasoodBukhari/SpeedometerGuage-SwiftUI.git
cd SpeedometerGuage-SwiftUI
open Speedometer.xcodeproj
```

Select the **Speedometer** scheme and a simulator, then press **⌘R**.

## How it works

`SpeedometerViewModel` owns the geometry. Each value is placed between its two surrounding ticks, and the angle is linearly interpolated inside that segment:

```swift
let valueFraction = (value - lower.value) / (upper.value - lower.value)
let angle = lower.angle + valueFraction * (upper.angle - lower.angle)
```

The same angle drives both the needle's `rotationEffect` and the arc's end angle, so they always stay in sync.

## Architecture

```text
Speedometer/
├── SpeedometerApp.swift          App entry point
├── ViewModels/
│   └── SpeedometerViewModel.swift  Ticks, value → angle mapping, formatting
├── Views/
│   ├── AppContainerView.swift    Gradient backdrop and card
│   ├── SpeedometerView.swift     Gauge composition, input and animation
│   └── Components/               Needle, progress arc, ticks, background, readout
├── Utils/AppStyle.swift          Colour tokens
└── Extensions/                   Color(hex:), dynamic offset modifier
```

<br>

<p align="center">
  <a href="https://www.kolonx.com"><img src="https://raw.githubusercontent.com/SyedAliMasoodBukhari/SyedAliMasoodBukhari/main/assets/repo-footer.svg" width="100%" alt="Crafted by Syed Ali Masood, founder of KolonX"></a>
</p>
