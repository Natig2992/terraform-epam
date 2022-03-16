1. Task-1:

1.1 Install last version Terraform:

```curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
terraform --version
Terraform v1.1.7
on linux_amd64
```
1.2 terraform init # After create and specify provider and verisons for AWS and terraform:

in .bashrc file

```
export AWS_ACCESS_KEY_ID=my-key-id
export AWS_SECRET_ACCESS_KEY=my-secret-access-key
export AWS_DEFAULT_REGION=eu-central-1
```

```terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 4.5.0"...
- Installing hashicorp/aws v4.5.0...
- Installed hashicorp/aws v4.5.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

1.3 After complete configure main.tf and outputs.tf:

`terraform plan` # just output plan for apply
`terraform apply` # directly deploy infrastructure

2. Task-2:

2.1 Terraform remote state file initialize on AWS s3 bucket, but without DynamoDB for locking.

2.2 Configure EC2 instance and RDS, two security-groups for EC2 Nginx and RDS instance

2.3 Configure userdata.tpl in root module for EC2 instance

2.4 Result attached screenshot on the learn portal homwork task2 terraform module

2.5 For second task my **terraform.tfvars** file with sensitive data is being ignored by **.gitinore file**  
