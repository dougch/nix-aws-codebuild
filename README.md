# nix-aws-codebuild

> A custom Docker image for building with [Nix][1] on [AWS CodeBuild][2]

This repository contains a simple Docker image for building Nix projects with
AWS CodeBuild. It does three things:

1. Shims `/bin/bash`
2. Configures flake support

[1]: https://nixos.org
[2]: https://aws.amazon.com/codebuild/



### Steps to build

With docker, jq and the aws-cli setup:

```
export AWS_ECR_REPO=YOUR_REPO_URI
make build
```

Do some testing....

```
make login
make publish
```

