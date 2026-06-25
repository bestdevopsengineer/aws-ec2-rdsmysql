# aws-ec2-rdsmysql

aws-nodejs-rds-crud-app/
│
├── terraform/
│
│── components/
│   │
│   ├── vpc/
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   │
│   ├── security-group/
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   │
│   ├── alb/
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   │
│   ├── ec2/
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   │
│   ├── autoscaling/
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   │
│   ├── rds/
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   │
│   ├── iam/
│   ├── nat-gateway/
│   ├── internet-gateway/
│   ├── route-table/
│   ├── launch-template/
│   └── cloudwatch/
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── security-group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── alb/
│   ├── ec2/
│   ├── autoscaling/
│   ├── rds/
│   ├── iam/
│   ├── nat-gateway/
│   ├── internet-gateway/
│   ├── route-table/
│   ├── launch-template/
│   └── cloudwatch/
│
└── app/
    ├── app.js
    ├── package.json
    ├── routes/
    ├── views/
    ├── public/
    └── Dockerfile

# For this project, we'll build the following modules one by one:

      VPC
      Security Groups
      Internet Gateway
      NAT Gateway
      Route Tables
      Application Load Balancer
      Auto Scaling Group
      Launch Template
      RDS MySQL (Multi-AZ)
      IAM Roles
      CloudWatch
      Outputs
      
      Then we'll build the Node.js CRUD application with:
      
      Home page
      Add User
      Update User
      Delete User
      Search User
      View All Users
