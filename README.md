# terraform-tlp

This repository contains Terraform code organized into **modules** and **components**, and is designed to be used inside a Docker container for consistent, reproducible environments.

---
 chmod +x  run-terraform.sh
## Prerequisites

- Docker & Docker Compose installed on your machine.
- AWS credentials exported in your shell:
  
bash
  export AWS_ACCESS_KEY_ID=your_access_key
  export AWS_SECRET_ACCESS_KEY=your_secret_key
  export AWS_SESSION_TOKEN=your_session_token


---

## 1. Build the Terraform Docker Image

Build or rebuild the Terraform image whenever you update the Dockerfile:

bash
cd TERRAFORM-tlp
docker-compose build terraform


This creates an image named terraform-aws:latest (per your docker-compose.yml).

---

## 2. Running Terraform Commands via Docker Compose

You can target any **component** (e.g. storage, compute, iam, etc.) and any **environment** (dev, stg, prod).

### Direct Commands

**Initialize** the backend for the storage component in **stg**:
============================================================================
bash
docker-compose run --rm terraform \
  -chdir=terraform/components/vpc init \
    -backend-config=backend/dev.tfvars

docker-compose run --rm terraform -chdir=terraform/components/vpc init -backend-config=backend/dev.tfvars -reconfigure
**Plan** infrastructure changes for storage/dev:

bash
docker-compose run --rm terraform \
  -chdir=terraform/components/storage plan \
    -var="env=dev"


**Apply** infrastructure changes for storage/dev:

bash
docker-compose run --rm terraform \
  -chdir=terraform/components/storage apply \
    -var="env=dev" -auto-approve
===========================================================================

> **Note:** Adjust the -chdir path and tfvars filename for other components or environments.

---

## 3. Wrapper Script: run-terraform.sh

For convenience, a helper script run-terraform.sh lives in the repo root. It lets you run init, plan, and apply with a shorter syntax:

bash
# Make it executable (once):
chmod +x run-terraform.sh

# Initialize (defaults to env=dev):
./run-terraform.sh init components=storage

# Plan using dev:
./run-terraform.sh plan components=storage

# Plan using stg explicitly:
./run-terraform.sh plan components=storage env=stg

# Apply using dev:
./run-terraform.sh apply components=storage


The script uses:

- components=<component> to select terraform/components/<component>
- env=<env> (default: dev) to select the tfvars file under backend/

---

## 4. Repo Layout

TLP-TERRAFORM-AWS/
├── Dockerfile
├── docker-compose.yml
├── run-terraform.sh
└── terraform/
    ├── modules/
    │   └── s3/            # reusable S3 bucket module
    └── components/
        └── storage/       # component: storage
            ├── backend/
            │   ├── dev.tfvars
            │   ├── stg.tfvars
            │   └── prod.tfvars
            ├── backend.tf
            ├── provider.tf
            ├── main.tf
            ├── variables.tf
            ├── outputs.tf
            └── .terraform.lock.hcl


---

## 5. Tips

- If you update provider versions or modules, re-run:

  
bash
  docker-compose run --rm terraform \
    -chdir=terraform/components/storage init \
      -backend-config=backend/dev.tfvars


- To hide Terraform’s local cache and lock file in VS Code, add to .vscode/settings.json:

  
json
  {
    "files.exclude": { "**/.terraform": true, "**/.terraform.lock.hcl": true },
    "search.exclude": { "**/.terraform": true, "**/.terraform.lock.hcl": true }
  }


- **Other Terraform Commands**: Some Terraform commands (e.g. import, state rm, state mv) are not supported by the run-terraform.sh wrapper. Run them directly via Docker Compose:

  
bash
  # Import a resource into state
  docker-compose run --rm terraform \
    -chdir=terraform/components/storage import aws_s3_bucket.this tlp-terraform-dev-storage

  # Remove a resource from state
  docker-compose run --rm terraform \
    -chdir=terraform/components/storage state rm aws_s3_bucket.this

  # Move a resource within state
  docker-compose run --rm terraform \
    -chdir=terraform/components/storage state mv aws_s3_bucket.this aws_s3_bucket.new-name


---

Happy deploying!



🚀 Core Workflow Commands
# terraform init	Initializes a Terraform working directory
./run-terraform.sh init components=storage
# terraform plan	Previews changes before applying them
./run-terraform.sh plan components=storage
# terraform apply	Applies changes to reach desired infrastructure state
./run-terraform.sh apply components=storage
# terraform destroy	Destroys all managed infrastructure
# terraform refresh	Updates state file with real-world resource data

📦 State Management
# terraform show	Displays the current state or a saved plan file



===================================================================================
# terraform state list	Lists all resources in the state
docker-compose run --rm terraform -chdir="terraform/components/storage" state list

docker-compose run --rm terraform \
  -chdir="terraform/components/storage" state list \
  | grep '^module\.' \
  | cut -d'.' -f1-2 \
  | sort -u
  
module.jou_imported_bucket_dev
module.jou-bucket1-dev
module.jou-bucket2-dev
===================================================================================
# terraform state show	Shows attributes of a specific resource
docker-compose run --rm terraform -chdir="terraform/components/storage" show
# terraform state rm	Removes a resource from state (without destroying it)
terraform state rm module.jou-bucket1-dev.aws_s3_object.folders["archive"]
This removes just that one object from state, leaving the actual S3 object untouched.

docker-compose run --rm terraform \
  -chdir="terraform/components/storage" \
  state rm module.jou_imported_bucket_dev.aws_s3_bucket.this

# terraform state mv	Moves a resource to a new address in state
terraform state mv \
  module.jou-bucket1-dev.aws_s3_bucket.this \
  module.jou-bucket0-dev.aws_s3_bucket.this

docker-compose run --rm terraform \
  -chdir="terraform/components/storage" state mv \
  module.jou-bucket1-dev.aws_s3_bucket.this \
  module.jou-bucket0-dev.aws_s3_bucket.this

🔄 Resource Importing
# terraform import	Imports existing infrastructure into Terraform
1-add module in root
2-terraform init
3-import

docker-compose run --rm terraform   -chdir="terraform/components/storage" import module.jou_imported_bucket_dev.aws_s3_bucket.this jou-imported-bucket-dev

🧪 Validation & Formatting
# terraform validate	Checks if configuration is syntactically valid
# terraform fmt	Formats .tf files to canonical style
# terraform providers	Lists providers used in the configuration

🔐 Secrets & Environment

# terraform console	Opens an interactive console for evaluating expressions
# terraform output	Shows output values from state
# terraform login	Authenticates with Terraform Cloud or Enterprise
# terraform logout	Removes credentials

🧰 Misc & Advanced

# terraform graph	Generates a visual graph of dependencies
# terraform version	Displays the current Terraform version
# terraform providers lock	Manages provider dependency versions
