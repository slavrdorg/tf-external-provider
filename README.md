# Terraform external provider

A demo of how to use an external provider in Terraform 0.12.

Documentation of how to use external terraform providers can be found [here](https://www.terraform.io/docs/plugins/basics.html). The page contains basic information and links to other pages with more details. 

Documentation on how to use custom providers on Terraform Cloud specifically can be found [here](https://www.terraform.io/docs/cloud/run/index.html#installing-terraform-providers).

In this project the provider binary is stored in a different git repository which is added to this one as a git [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules). The submodule directory is `bin-tf-provider-okta`. The binary in it is for Linux/amd64.

The provider binary is sym-linked to the appropriate location for terraform external providers - `terraform.d/plugins/linux_amd64/` - as in this case as we are using a Linux/amd64 binary.

The sym-link must be relative from the terraform provider's directory to the directory containing the binary - `terraform-provider-okta_v3.0.21_x4 -> ../../../bin-tf-provider-okta/terraform-provider-okta_v3.0.21_x4`.

To clone a project, including its submodules - `git clone --recurse-submodules <repository>` 

## Using with Terraform CLI

Run `terraform init` and `terraform plan`. If all is successful terraform will not return any errors and will show that no changes are needed as no actual resources are defined in the code. The purpose is just for terraform to initialize the custom provider. Behavior is the same with a local run or a remote run on TF Cloud.

## Using in Terraform Cloud with VCS driven runs

Set up Terraform Cloud VCS connection as described [here](https://www.terraform.io/docs/cloud/vcs/index.html). 

After the OAuth connection is set up you'll need to add to it a SSH key that provides access to the submodule with the external provider binary. This can be done in the organization settings under `VCS Providers`. To add the SSH key click on the link in the `Connection` section of the relative VCS provider. This is not needed if the git submodule is added via the `https` scheme as it is then publicly accessible.

Create a Terraform workspace, connected to the repository. Make sure to check the option `Include submodules on clone` in the `Advanced options` section. It can also be found in the workspace's settings under `Version Control`.

If everything is working Terraform Cloud should be able to perform a successful plan that shows that there are no changes needed.
