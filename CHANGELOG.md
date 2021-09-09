# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

##[3.0.0] - 2019-08-19
### Deprecated
Remove `assumerole` script. Deprecated in favour of using built-in AWS SDK functionality, or other well-maintained FOSS tools such as https://github.com/trek10inc/awsume or https://github.com/99designs/aws-vault.

##[2.0.1] - 2019-07-17
### Fixed
Fixed not working for some users due to Python 2.7 syntax
Fixed interactive arguments for app_id

## [2.0.0] - 2019-07-12
### Breaking
Switched from per app MFA to using account level MFA.

## [1.0.2] - 2019-06-24
### Fixed
Profiles with and without `external_id` are now possible with `assumerole`

## [1.0.1] - 2019-06-18
### Fixed
Bug in hardcoded parameters usage

### Added
Add .dockerignore

## [1.0.0] - 2019-06-14
### Added
Initial Release
