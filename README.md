# aws-ec2-rdsmysql

aws-nodejs-rds-crud-app/
│
├── terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   ├── security-groups/
│   │   ├── alb/
│   │   ├── ec2/
│   │   ├── autoscaling/
│   │   ├── rds/
│   │   ├── iam/
│   │   └── nat-gateway/
│   │
│   └── components/
│       └── production/
│           ├── main.tf
│           ├── provider.tf
│           ├── variables.tf
│           ├── outputs.tf
│           ├── backend.tf
│           └── terraform.tfvars
│
└── app/
    ├── app.js
    ├── package.json
    ├── package-lock.json
    ├── views/
    │   ├── index.ejs
    │   ├── add.ejs
    │   ├── edit.ejs
    │   └── search.ejs
    ├── public/
    │   └── style.css
    └── routes/


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
