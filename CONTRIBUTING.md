# Contributing

## Pull Requests
Contributions to this project should follow these guidelines:

  * [Trunk-Based Development](https://trunkbaseddevelopment.com/) (short-lived feature branches and tags to release)
  * [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
  * [Semantic Versioning](https://semver.org/spec/v2.0.0.html)
  * [Google Code Review Developer Guide](https://google.github.io/eng-practices/review/)

### Process
  1. Create a feature branch (ideally with descriptive naming, all lowercase and separated by dashes). You can fork the repository if you do not have write access to it.
  1. Develop your feature/fix
  1. Ensure that all existing tests are passing by running them locally
  1. Update the `[Unreleased]` section in [CHANGELOG.md](CHANGELOG.md) if applicable
  1. Ensure all relevant documentation is updated in [README.md](README.md)
  1. Ensure your branch is up-to-date with trunk (master)
  1. When all the above criteria have been satisfied, submit your PR
  1. The maintainers in [CODEOWNERS](CODEOWNERS) will be automatically added to review it
  1. Once the PR review has passed, the PR will be merged and the feature branch deleted. At this point, the feature will be available to those pulling from the latest version.
  1. When required, a maintainer will create a _GitHub Release_ (following _Semantic Versioning_). The changelog (and any applicable versions referenced in documentation if needed) will be updated directly via push to master.
