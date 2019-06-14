# docker-okta-utils
docker-okta-utils implements a container that handles authentication from Okta. Because it (non-destructively) updates your `~/.aws/credentials file`, it is flexible enough to allow use of other tools with their own Docker images like Terraform and kubectl. It also allows easy use of the [3 Musketeers][] pattern.

[3 Musketeers]: https://3musketeers.io/

## Important Information
It is not possible to run `oktashell` with the `eval $(docker run -it)` method of setting environemnt variables. This is due to `docker run -it` not outputting on stderr causing all output to be captured by `eval`. To work around this `oktashell -p <profile>` has been added which will write the credentials to the specified profile in `~/.aws/credentials`. You need to bind mount your `.aws` directory from the host to `/root/.aws/` for this to work.

## oktashell
### Configuration
oktashell requires a configuration file at `~/.aws/oktashell.yml` containing information about your Okta apps:

```yml
---
myorg:
  application_id: asdfasdfasdfasdfasdf
  application_type: amazon_aws
  okta_url: myorg.okta.com
myorg_test:
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

## AssumeRole
AssumeRole uses the standard `~/.aws/config` file. You dont need to specify a source_profile on each profile as whats specified with `-s` is always used.

```
[profile xyz-sandpit]
role_arn = arn:aws:iam::111111111111:role/xyz-role-api-fulladmin
external_id = abcdefghjklmnop
```

```
usage: AssumeRole [-h] [-e] [-s SOURCE] profile

positional arguments:
  profile                     Profile to assume

optional arguments:
  -h, --help                  show this help message and exit
  -e, --export                Prepend outputted variables with export
  -s SOURCE, --source SOURCE  Source profile to use to assume role
```

## How to use
This image is available at DockerHub(https://hub.docker.com/r/cmdlabs/okta-utils).

Shell functions allow you mix hardcoded and dynamic parameters. If you would like to take additional parameters specified on the command line add `$@` to the end of a function command.

### Hardcoded Parameters
```
function oktashell() {
  docker run --rm -it -v ~/.aws:/root/.aws --entrypoint=oktahshell cmdlabs/okta-utils:latest -u <username> -a <application> -m <mfa_method> -o <role_arn> -p <profile>
}

function AssumeRole() {
  docker run --rm -it -v ~/.aws:/root/.aws --entrypoint=AssumeRole cmdlabs/okta-utils:latest <profile_to_assume> -e
}
```

### Dynamic Parameters
```
function oktashell() {
  docker run --rm -it -v ~/.aws:/root/.aws --entrypoint=oktashell cmdlabs/okta-utils:latest $@
}

function AssumeRole() {
  docker run --rm -it -v ~/.aws:/root/.aws --entrypoint=AssumeRole cmdlabs/okta-utils:latest $@
}
```

### Autoexport AssumeRole
If you would like to automatically export the credentials obtained from AssumeRole to the current shell you can use the following.
```
function oktashell() {
  docker run --rm -it -v ~/.aws:/root/.aws --entrypoint=oktashell cmdlabs/okta-utils:latest -u <username> -a <application> -m <mfa_method> -o <role_arn> -p <profile>
}

function AssumeRole() {
  eval $(docker run --rm -it -v ~/.aws:/root/.aws --entrypoint=AssumeRole cmdlabs/okta-utils:latest -e $@)
}
```

