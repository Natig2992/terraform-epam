1. Install last version Terraform:

```curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
terraform --version
Terraform v1.1.7
on linux_amd64
```
2. terraform init # After create and specify provider and verisons for AWS and terraform:

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

3. After complete configure main.tf and outputs.tf:

`terraform plan` # just output plan for apply
`terraform apply` # directly deploy infrastructure


