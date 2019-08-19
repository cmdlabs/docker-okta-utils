# docker-okta-utils
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/cmdlabs/okta-utils.svg)](https://hub.docker.com/r/cmdlabs/okta-utils) [![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/cmdlabs/okta-utils.svg)](https://hub.docker.com/r/cmdlabs/okta-utils/builds)

docker-okta-utils implements a container that handles authentication from Okta to AWS. Because it (non-destructively) updates your `~/.aws/credentials` file, it is flexible enough to allow use of other tools with their own Docker images like Terraform and kubectl. It also allows easy use of the [3 Musketeers][] pattern.

[3 Musketeers]: https://3musketeers.io/

## Important Information
It is not possible to run `oktashell` with the `eval $(docker run -it)` method of setting environment variables. This is due to `docker run -it` not outputting on stderr causing all output to be captured by `eval`. To work around this `oktashell -p <profile>` has been added which will write the credentials to the specified profile in `~/.aws/credentials`. You need to bind mount your `.aws` directory from the host to `/root/.aws/` for this to work.

## oktashell
### Configuration
oktashell requires a configuration file at `~/.aws/oktashell.yml` containing information about your Okta apps:

```yml
---
myapp:
  application_id: asdfasdfasdfasdfasdf
  application_type: amazon_aws
  okta_url: myorg.okta.com
myapp_test:
  application_id: fdsafdsafdsafdsafdsa
  application_type: amazon_aws
  okta_url: myorg.oktapreview.com
```

### Usage
```
usage: oktashell [-h] [-r] [-u USER] [-a APP] [-d DURATION] [-m MFA] [-o ROLE]
                 [-p PROFILE]

optional arguments:
  -h, --help                        show this help message and exit
  -r, --reauth                      Refresh the creds for the current user.
  -u USER, --user USER              User to log in as; will prompt if not supplied
  -a APP, --app APP                 App name to log into; will prompt if not supplied
  -d DURATION, --duration DURATION  Token expiry time in seconds; default 3600 (1 hour)
  -m MFA, --mfa MFA                 MFA token type to prefer; eg. totp or push
  -o ROLE, --role ROLE              Role ARN to assume automatically
  -p PROFILE, --profile PROFILE     Profile to write credentials to in ~/.aws/credentials
```

## How to use
This image is available at dockerhub: https://hub.docker.com/r/cmdlabs/okta-utils

Shell functions allow you mix hardcoded and dynamic parameters. If you would like to take additional parameters specified on the command line add `$@` to the end of a function command.

### Hardcoded Parameters
```
function oktashell() {
  docker run --rm -it -v ~/.aws:/root/.aws --entrypoint=oktashell cmdlabs/okta-utils:latest -u <username> -a <application> -m <mfa_method> -o <role_arn> -p <profile> -d 28800
}
```

### Dynamic Parameters
```
function oktashell() {
  docker run --rm -it -v ~/.aws:/root/.aws --entrypoint=oktashell cmdlabs/okta-utils:latest $@
}
```
