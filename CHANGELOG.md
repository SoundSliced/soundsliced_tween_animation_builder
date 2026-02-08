
## 2.0.0
- package no longer holds the source code for it, but exports/exposes the `s_packages` package instead, which will hold this package's latest source code.
- The only future changes to this package will be made via `s_packages` package dependency upgrades, in order to bring the new fixes or changes to this package
- dependent on `s_packages`: ^1.1.2



## [1.2.0] - 2025-11-24

* Breaking: renamed the widget to `STweenAnimationBuilder`.
* Migration: replace usages of the previous widget name with `STweenAnimationBuilder`. The constructor API and behavior remain the same.
* Updated README and examples accordingly.

## [1.1.1] - 2025-11-20

* Fixed BSD sed compatibility issues in release script for macOS
* Improved package release automation
* Updated documentation and examples
* Enhanced test coverage

## [1.1.0] - 2025-11-19

* Improved documentation and examples in README.md
* Updated package description for better clarity
* Minor code optimizations

## [1.0.0] - 2025-11-19

* Initial release of soundsliced_tween_animation_builder package.

* Provides a custom TweenAnimationBuilder for sliced animations.
