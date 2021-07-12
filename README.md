# robins-dev-ec2
Dev instance creation terraform.

- To format: `terraform fmt`
- Validate: `terraform validate`
- Create infra: `terraform apply`
- To destroy the instance: `terraform destroy`

## SSH connection
- The required ssh key is hardcoded to `robins-ec2-key-pair` and stored on AWS Secrets manager
- To connect from vscode using remote connect simply add to your ssh config file:

```
Host robins-dev-ec2
  HostName ec2-18-168-76-253.eu-west-2.compute.amazonaws.com
  IdentityFile /Users/robin/.ssh/robins-ec2-key-pair.pem
  User ubuntu
```

## Github
To auth with github install the [gh cli](https://cli.github.com/manual/) and auth with an access token that has role `admin:org:read&write`. Set your git config with `git config user.name "Robin"` and `git config user.email "my@email"`

## AWS
Setup the [aws cli](https://aws.amazon.com/cli/) then `aws configure` and test with `aws s3 ls`

## Conda
Installed following [these instructions](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html) to `/home/ubuntu/anaconda3`

## Setup tools
- `sudo apt update`
- `sudo apt install docker.io` & `sudo apt install docker-compose`
- `sudo docker run hello-world` # simply validates docker is installed
- `sudo apt install unzip`

## Ubuntu commands
- `df -h` to list available storage
- If getting permissions errors: `sudo chown -R ubuntu /my/dir`