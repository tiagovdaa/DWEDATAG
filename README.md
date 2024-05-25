# DWEDATAG

What is DWEDATAG?

Here’s the breakdown:

**D**ockerized
**W**ordpress
**E**C2
**D**atabase
**A**WS
**T**erraform
**A**nsible
**G**itHub Actions

*because we like acronyms*

## Project Goal

The objective of this project is to create an EC2 instance on AWS to host a Dockerized WordPress and MariaDB setup, with persistence on a EBS volume.

Additionally, it automates the registration of this host with a DNS entry in Route53 and handles package installation and deployment using Ansible.

It serves as a small showcase of my knowledge and capabilities and automation of building my own blog (<https://www.oldtechgeek.org>) where I discuss about old technolgies, mostly computers and games :-D

Since I'm pretty new to wordpress and messed it up so many times I had this idea, now I can recreate the whole infrastructure under 5 minutes!

It's a really simple and I did not considered a couple of things like organizations, roles, acls and security at this point.

I hope you have some fun with it. ;-)

Tiago Almeida. [^1]

## Technologies and Knowledge Used

### 1. **Amazon Web Services (AWS)**

- **EC2 (Elastic Compute Cloud)**: Used to create and manage virtual machines.
- **Route53**: AWS's scalable DNS and domain name registration service.
- **VPC**: Networking
- **EBS**: Elastic Block Serivce, for persistent volume

### 2. **Docker**

- **Docker Engine**: For containerizing WordPress and MariaDB applications.
- **Docker Compose**: To define and run multi-container Docker applications.

### 3. **Ansible**

- **Playbooks**: For automating server setup, configuration, and deployment tasks.
- **Roles**: To modularize the Ansible configurations.

### 4. **Certbot**

- **Let's Encrypt**: For obtaining SSL certificates to secure the website.

### 5. **GitHub Actions**

- **CI/CD**: Automate the deployment process using GitHub's built-in CI/CD capabilities.

### 6. **Technologies for Configuration and Automation**

- **Terraform**: For defining and provisioning infrastructure as code.
- **Jinja2**: For templating configuration files.

## Project Setup and Deployment

### 1. **Infrastructure Setup with Terraform**

Terraform scripts are used to provision an EC2 instance and configure Route53 for DNS management.

- **main.tf**: Defines the root module that sets up the infrastructure.
- **variables.tf**: Contains all the variables required for the setup.
- **outputs.tf**: Outputs important information like EC2 public IP.
- **providers.tf**: Configures the necessary providers (AWS).
- **terraform.tfvars**: Handles all the configuration (variables values)

*additionately there are some files for specific objects like DNS entries and ebs volumes, allowing us to destroy a specific object like module.ec2.aws_ebs_volume.XXX or module.ec2.aws_route53_record.XXX (with -target)*

### 2. **Automated Configuration and Deployment with Ansible**

Ansible is used for automating the configuration of the EC2 instance, installing necessary packages, deploying Docker containers, and setting up SSL certificates.

#### **Roles**

- **packages** : Install some needed packages.
- **docker**: Installs Docker and Docker Compose.
- **user_mgmt**: Adds the EC2 user to the Docker group.
- **certbot**: Obtains SSL certificates from Let's Encrypt.
- **deployment**: Handles the deployment of Dockerized WordPress and MariaDB.

#### **Playbook Structure**

- **main.yml**: The main playbook that calls the various roles.
- **inventory**: Dynamically generated inventory file containing the EC2 instance's public IP.

### 3. **GitHub Actions Workflow**

The workflow automates the entire deployment process from infrastructure setup to application deployment.

#### **Workflow Steps**

1. **Checkout the Repository**: Clone the repo.
2. **Set Up SSH**: Configures SSH for accessing the EC2 instance.
3. **Set Up Terraform**: Initializes and applies the Terraform configuration.
4. **Obtain EC2 Public IP**: Retrieves the public IP of the created EC2 instance.
5. **Install Docker**: Installs Docker on the GitHub runner.
6. **Run Ansible Playbook**: Executes the Ansible playbook to configure the EC2 instance and deploy the application.

Actions Used:

- actions/checkout - v4.1.6
- hashicorp/setup-terraform - v3.1.1
- aws-actions/configure-aws-credentials - v4.0.2

## Detailed Instructions

### Prerequisites

- **AWS Account**: Set up with IAM permissions to manage EC2 and Route53. (I didn't created an organization, groups and roles, it's pretty basic, and "unsafe", for now.)
- **GitHub Account**: For managing the repository and actions.
- **Domain Name**: Registered and managed via AWS Route53.
- **SSH Key Pair**: For accessing the EC2 instance.

1. **Create bucket to store terraform states**

```
aws s3api create-bucket --bucket tfstates --region eu-west-1 --create-bucket-configuration LocationConstraint=<aws region>
```

2. **Create table to store terraform locks**

```
aws dynamodb create-table --table-name terraform-lock --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --region <aws region>
```

*Pay attention to the costs! Although EC2 have a free tier for instance, Route53 does not.*

### Step-by-Step Guide

1. **Fork the Repository**: Clone the project repository to your GitHub account.
*don't forget to adjust all the backend.tf files accordingly*

2. **Configure GitHub Secrets**: Add the following secrets in your GitHub repository settings:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `SSH_PRIVATE_KEY`
   - `SSH_PUBLIC_KEY`
   - `WORDPRESS_DB_USER`
   - `WORDPRESS_DB_PASSWORD`
   - `WORDPRESS_DB_NAME`
   - `MYSQL_ROOT_PASSWORD`
   - `MYSQL_DATABASE`
   - `MYSQL_USER`
   - `MYSQL_PASSWORD`

3. **Configure the following Variables**:

   - `EC2-USER`
   - `DOMAIN_NAME`
   - `DOMAIN_EMAIL`

4. **Update Variables**: Modify the `terraform.tfvars` file with your specific configurations such as AWS region, instance type, key name, etc.

5. **Run GitHub Actions Workflow**: Push changes to the `main` branch to trigger the workflow. The workflow will:
   - Set up the infrastructure using Terraform.
   - Configure the EC2 instance using Ansible.
   - Deploy the Dockerized WordPress and MariaDB applications.
   - Obtain and configure SSL certificates.

### Additional Information

#### **Handling SSL Certificates**

Certbot requires the Nginx server to be running to validate the domain ownership. This setup includes:

- A temporary Nginx configuration for Certbot validation.
- Stopping the temporary Nginx and starting the main Docker Compose setup after obtaining the certificates.

### Troubleshooting

- **Connection Refused Errors**: Ensure that your security groups allow HTTP and HTTPS traffic.
- **SSL Certificate Issues**: Check that the DNS records are correctly set and propagate before running Certbot.
- **Permissions Issues**: Ensure the IAM user has sufficient permissions to manage EC2 and Route53 resources.

## Conclusion

This project demonstrates a robust way to automate the deployment of a Dockerized WordPress and MariaDB setup on AWS EC2, utilizing Terraform for infrastructure management, Ansible for configuration management, and GitHub Actions for CI/CD. This approach ensures a scalable, secure, and efficient deployment process.

By following the detailed instructions and leveraging the provided automation scripts, you can streamline the deployment and management of web applications on AWS.

---

[^1]: You can know more about me at [tiagovdaa.github.io/resume](https://tiagovdaa.github.io/resume/)
      feel free to add me to your social networks: [linktr.ee/tiagovdaa](https://linktr.ee/tiagovdaa)
      Tiago Almeida - 2024
