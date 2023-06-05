.PHONY: publish login
all: build

tag:
	@{ \
	set -u ;\
	echo "Using $$AWS_ECR_REPO"|| @echo "Please set AWS_ECR_REPO. hint: aws ecr-public describe-registries --region=us-east-1 | jq -r '.registries[].aliases[].name'" ;\
	}

# Public ECR login - note the region over-ride.
login:
	# Handle both versions of the aws-cli
	`aws ecr-public get-login --no-include-email` || echo `aws ecr-public get-login-password --region us-east-1`|docker login --password-stdin --username AWS public.ecr.aws
build: tag
	docker build -t public.ecr.aws/$(AWS_ECR_REPO)/nix-aws-codebuild-$$(uname -m):next .
publish: login
	docker push public.ecr.aws/$(AWS_ECR_REPO)/nix-aws-codebuild-$$(uname -m):next
