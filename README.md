<Task 1>

Given the existing infrastructure in the diagram, create a Terraform
configuration that will deploy a t3.large instance to us-east-1 in subnet-1234567
with the latest Ubuntu 22.04 LTS AMI. There should be an additional 40 GiB gp3
volume attached to the instance. A security group should also be created that
allows SSH from 10.72.100.0/24. The instance should have the latest version of the
AWS CLI installed.


----Solution----

1.	To execute the following Terraform configuration, start by running "terraform init" to initialize the backend and download provider plugins. Next, validate the configuration with "terraform validate" and preview the resources to be provisioned or changed with "terraform plan." Finally, apply the configuration by running "terraform apply". Kindly refer to the configurations ending with ".tf" in this repository. In file "tf-config" is the hard-coded version of the terraform configuration. I prepared a version of the code that is not hard-coded which you can view and execute	( i.e. main.tf,variables.tf,and output.tf). Hard-coding is never recommended because it renders the code not re-usable and for security purposes. I do not hard code; however, I prepared both for you to view and execute.


<Task 3>

The requested CronJob yaml file has been included in this repository. It is under the name, " Task 3 CronJob ."


<Task 5>

I included an IAM policy in JSON format that permits an entity to ONLY create an
object in S3 in a bucket named “s3UploadBucket” in a prefix named
“s3UploadPrefix”. I included the policy in this repository.
