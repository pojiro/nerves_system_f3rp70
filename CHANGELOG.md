# Changelog

This project does NOT follow semantic versioning. The version increases as
follows:

1. Major version updates are breaking updates to the build infrastructure.
   These should be very rare.
2. Minor version updates are made for every major Buildroot release. This
   may also include Erlang/OTP and Linux kernel updates. These are made four
   times a year shortly after the Buildroot releases.
3. Patch version updates are made for Buildroot minor releases, Erlang/OTP
   releases, and Linux kernel updates. They're also made to fix bugs and add
   features to the build infrastructure.

## v0.3.2

This release updates Erlang/OTP from 24.1.2 to 24.1.4.

* Updated dependencies
  * [nerves_system_br v1.17.3](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.17.3)
  * [Erlang/OTP 24.1.4](https://erlang.org/download/OTP-24.1.4.README).

## v0.3.1

This release fixes [a bug](https://github.com/pojiro/nerves_system_f3rp70/issues/4) in v0.3.0 that blocked the Erlang VM starting.

## v0.3.0

This release updates to Buildroot 2021.08.1 and OTP 24.1.2.

* Updated dependencies
  * [Buildroot 2021.08.1](http://lists.busybox.net/pipermail/buildroot/2021-October/625642.html)
  * [nerves_system_br v1.17.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.17.2)
  * [Erlang/OTP 24.1.2](https://erlang.org/download/OTP-24.1.2.README)

## v0.2.0

This release updates to Buildroot 2021.05 and OTP 24.0.3.

* Updated dependencies
  * [Buildroot 2021.05](http://lists.busybox.net/pipermail/buildroot/2021-June/311946.html)
  * [nerves_system_br v1.16.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.16.1)
  * [Erlang/OTP 24.0.3](https://erlang.org/download/OTP-24.0.3.README)

## v0.1.0

* First bootable system
