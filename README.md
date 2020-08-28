# Terraform external provider

A demo of how to use an external provider in Terraform 0.12.

In this project the provider binary is stored in a different git repository which is added to this one as a git [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules). The submodule directory is `bin-tf-provider-okta`. The binary in it is for Linux/amd64.

The provider binary is sym-linked to the appropriate location for terraform external providers - `terraform.d/plugins/linux_amd64/` - as in this case as we are using a Linux/amd64 binary.

The sym-link must be relative from the terraform provider's directory to the directory containing the binary - `terraform-provider-okta_v3.0.21_x4 -> ../../../bin-tf-provider-okta/terraform-provider-okta_v3.0.21_x4`.

## Using with Terraform CLI

* clone the project, including its submodules

  ```bash
  git clone --recurse https://github.com/slavrdorg/tf-external-provider.git
  ```

* initialize terraform in the current directory and perform a plan

  ```bash
  terraform init
  terraform plan
  ```

A successful plan will be executed, showing that there are no changes to be made. This indicates that the initialization phase was successful and the custom provider defined in the terraform configuration was detected and considered installed.

## Using in Terraform Cloud with VCS driven runs

* Fork the repository

* Set up Terraform Cloud VCS connection as described [here](https://www.terraform.io/docs/cloud/vcs/index.html). 

* Create a Terraform workspace, connected to your fork of the repository. Make sure to check the option `Include submodules on clone` in the `Advanced options` section. It can also be found in the workspace's settings under `Version Control`.

If the setup is correct Terraform Cloud should be able to perform a successful plan that shows that there are no changes needed. This indicates that the initialization phase was successful and the custom provider defined in the terraform configuration was detected and considered installed.

**Note:** When using a repository in which the git submodules are refrenced via the `SSH` scheme you must add SSH key to the created Terraform Cloud OAuth client. This key must authenticate a VCS user that has access to clone the repository referenced as a submodule. This is true even if the repository is public and in this case any valid VCS user will do.

How to add an SSH key for cloning git submodules to the Terraform Cloud VCS connection client is described [here](https://www.terraform.io/docs/cloud/vcs/index.html#ssh-keys).

## References

* Documentation on how to use external terraform providers can be found [here](https://www.terraform.io/docs/plugins/basics.html). The page contains basic information and links to other pages with more details. 

* Documentation on how to use custom providers on Terraform Cloud specifically can be found [here](https://www.terraform.io/docs/cloud/run/index.html#installing-terraform-providers).
