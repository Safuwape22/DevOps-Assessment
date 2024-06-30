Given the existing infrastructure in the diagram, create a Terraform
configuration that will deploy a t3.large instance to us-east-1 in subnet-1234567
with the latest Ubuntu 22.04 LTS AMI. There should be an additional 40 GiB gp3
volume attached to the instance. A security group should also be created that
allows SSH from 10.72.100.0/24. The instance should have the latest version of the
AWS CLI installed.


----Solution----

1.	To execute the following Terraform configuration I created, start by running "terraform init" to initialize the backend and download provider plugins. Next, validate the configuration with "terraform validate" and preview the resources to be provisioned or changed with "terraform plan." Finally, apply the configuration by running "terraform apply". Kindly refer to the configuration. In file "tf-config" is the hard-coded version of the terraform configuration. I prepared a version of the code that is not hard-coded which you can view and execute	( i.e. main.tf,variables.tf,and output.tf). Hard-coding is never recommended because it renders the coded not re-usable and for security purposes. I do not hard code; However, I prepared both for you to view and execute.
