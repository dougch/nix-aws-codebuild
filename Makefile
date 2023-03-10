.PHONY: test push login
all: build test

# Private ECR login
#   `aws ecr get-login --no-include-email` || echo `aws ecr get-login-password`|docker login --password-stdin --username AWS $(AWS_ACCOUNT).dkr.ecr.$(AWS_DEFAULT_REGION).amazonaws.com

# Public ECR login - note the region over-ride.
login:
	# Handle both versions of the aws-cli
	`aws ecr-public get-login --no-include-email` || echo `aws ecr-public get-login-password --region us-east-1`|docker login --password-stdin --username AWS public.ecr.aws
build:
	docker build -t public.ecr.aws/$(AWS_ECR_REPO)/nix-aws-codebuild:next .
push: login
	docker push public.ecr.aws/$(AWS_ECR_REPO)/nix-aws-codebuild:next 

