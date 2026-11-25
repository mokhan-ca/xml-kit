# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.7.0](https://github.com/mokhan-ca/xml-kit/compare/v0.6.0...v0.7.0) (2026-11-25)


### ⚠ BREAKING CHANGES

* raise for unknown decryption algorithms
* require nokogiri 1.19.1
* require strict xml and the xmlenc and xmldsig namespaces to decrypt
* require ruby 3.2

### Features

* require ruby 3.2 ([de4163b](https://github.com/mokhan-ca/xml-kit/commit/de4163b998854521f45fd30c5d7b442591ec4cad))


### Bug Fixes

* decrypt with each private key when openssl hides a wrong one ([b0597f0](https://github.com/mokhan-ca/xml-kit/commit/b0597f0547af3c5f76598a2555fbae866d948da7))
* link the gem to its repository and changelog ([c5549ee](https://github.com/mokhan-ca/xml-kit/commit/c5549eec7edb7d335834eddbadc8758a8b4ef8ef))
* raise for unknown decryption algorithms ([b65beac](https://github.com/mokhan-ca/xml-kit/commit/b65beac86d7a26db81ef21227c90a43ab9a127f6))
* require nokogiri 1.19.1 ([9f16831](https://github.com/mokhan-ca/xml-kit/commit/9f168319880243c62cc7f48fcd2903ac0b1e2e2e))
* require strict xml and the xmlenc and xmldsig namespaces to decrypt ([762c835](https://github.com/mokhan-ca/xml-kit/commit/762c83532d5bfd99f3f8521d86a4b0276d73f80b))

## [0.6.0] - 2022-05-23
### Added
- Add support for Ruby 3.1

### Removed
- Drop support for Ruby 2.5
- Drop support for Ruby 2.6

## [0.5.0] - 2021-01-30
### Changed
- Minimum Ruby 2.5+

## [0.4.0] - 2019-04-30
### Added
- provide stable API for specifying the digest method and signature method.

### Changed
- drop support for ruby 2.2
- drop support for ruby 2.3
- use bundler 2.0

## [0.3.1] - 2019-04-01
### Changed
- provide default symmetric cipher for `EncryptedData` element.
- use `ENVELOPED_SIG` constant

### Added
- allow specifying id for `EncryptedData` element.

## [0.3.0] - 2019-01-XX
### Added
- Default logger

### Changed
- \_assign does not coerce values by default.
- errors are merged together instead of overwritten during attribute validation.

[Unreleased]: https://github.com/xlgmokha/xml-kit/compare/v0.6.0...HEAD
[0.6.0]: https://github.com/xlgmokha/xml-kit/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/xlgmokha/xml-kit/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/xlgmokha/xml-kit/compare/v0.3.1...v0.4.0
[0.3.1]: https://github.com/xlgmokha/xml-kit/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/xlgmokha/xml-kit/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/xlgmokha/xml-kit/compare/v0.1.14...v0.2.0
[0.1.14]: https://github.com/xlgmokha/xml-kit/compare/v0.1.13...v0.1.14
[0.1.13]: https://github.com/xlgmokha/xml-kit/compare/v0.1.12...v0.1.13
[0.1.12]: https://github.com/xlgmokha/xml-kit/compare/v0.1.11...v0.1.12
[0.1.11]: https://github.com/xlgmokha/xml-kit/compare/v0.1.10...v0.1.11
[0.1.10]: https://github.com/xlgmokha/xml-kit/compare/v0.1.9...v0.1.10
[0.1.9]: https://github.com/xlgmokha/xml-kit/compare/v0.1.8...v0.1.9
[0.1.8]: https://github.com/xlgmokha/xml-kit/compare/v0.1.7...v0.1.8
[0.1.7]: https://github.com/xlgmokha/xml-kit/compare/v0.1.6...v0.1.7
[0.1.6]: https://github.com/xlgmokha/xml-kit/compare/v0.1.5...v0.1.6
[0.1.5]: https://github.com/xlgmokha/xml-kit/compare/v0.1.4...v0.1.5
[0.1.4]: https://github.com/xlgmokha/xml-kit/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/xlgmokha/xml-kit/compare/v0.1.1...v0.1.3
[0.1.1]: https://github.com/xlgmokha/xml-kit/compare/v0.1.1...v0.1.1
[0.1.1]: https://github.com/xlgmokha/xml-kit/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/xlgmokha/xml-kit/compare/v0.1.0...v0.1.0
