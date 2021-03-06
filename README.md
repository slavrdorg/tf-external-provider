# Terraform external provider

A demo of how to use an external provider in Terraform 0.13.

Demo for version 0.12 is available by checking out the 0.12 [branch](https://github.com/slavrdorg/tf-external-provider/tree/0.12) or [tag](https://github.com/slavrdorg/tf-external-provider/releases/tag/0.12) of this repo.

In this project the provider binaries are stored in a different git repository which is added to this one as a git [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules). The submodule directory is `bin-tf-provider-okta`.

The provider binaries are sym-linked to the appropriate location for terraform external providers. This location depends on how the provider is declared in the Terraform configuration. For example the linux/amd64 binary for the custom `okta` provider declared in `main.tf` should be in `terraform.d/plugins/providers.local/local/okta/3.0.38`.

The sym-link must be relative from the terraform provider's directory to the directory containing the binary. For example in the case of the linux/amd64 binary:

```bash
terraform.d/plugins/providers.local/local/okta/3.0.38/linux_amd64/terraform-provider-okta_v3.0.38_x4 -> ../../../../../../../bin-tf-provider-okta/linux_amd64/terraform-provider-okta_v3.0.38_x4
```

## Using with Terraform CLI

* Have Terraform CLI version `>= 0.13` installed

* clone the project, including its submodules

  ```bash
  git clone --recurse https://github.com/slavrdorg/tf-external-provider.git
  ```
* set terraform to debug output so that the provider initialization process can be observed

  ```bash
  export TF_LOG=DEBUG
  ```

* initialize terraform in the current directory and perform a plan

  ```bash
  terraform init
  terraform plan
  ```

A successful plan will be executed, showing that there are no changes to be made. This indicates that the initialization phase was successful and the custom provider defined in the terraform configuration was detected and considered installed. Additionally the messages in the terraform output indicate that the `okta` provider was loaded from the custom location in `terraform.d/plugins`.

## Using in Terraform Cloud with VCS driven runs

* Fork the repository

* Set up Terraform Cloud VCS connection as described [here](https://www.terraform.io/docs/cloud/vcs/index.html). 

* Create a Terraform workspace, connected to your fork of the repository. Make sure to check the option `Include submodules on clone` in the `Advanced options` section. It can also be found in the workspace's settings under `Version Control`.

* In the workspace set environment variable `TF_LOG` to `DEBUG` and queue another terraform run.

If the setup is correct Terraform Cloud should be able to perform a successful plan that shows that there are no changes needed. This indicates that the initialization phase was successful and the custom provider defined in the terraform configuration was detected and considered installed. Additionally the messages in the terraform output indicate that the `okta` provider was loaded from the custom location in `terraform.d/plugins`.

**Note:** When using a repository in which the git submodules are refrenced via the `SSH` scheme you must add SSH key to the created Terraform Cloud OAuth client. This key must authenticate a VCS user that has access to clone the repository referenced as a submodule. This is true even if the repository is public and in this case any valid VCS user will do.

How to add an SSH key for cloning git submodules to the Terraform Cloud VCS connection client is described [here](https://www.terraform.io/docs/cloud/vcs/index.html#ssh-keys).

## References

* Documentation on how to use external terraform providers can be found [here](https://www.terraform.io/docs/plugins/basics.html). The page contains basic information and links to other pages with more details.

* Documentation on the naming schema for locally installed providers can be found [here](https://www.terraform.io/docs/configuration/provider-requirements.html#in-house-providers)

* Documentation on how to use custom providers on Terraform Cloud specifically can be found [here](https://www.terraform.io/docs/cloud/run/install-software.html#installing-terraform-providers).
