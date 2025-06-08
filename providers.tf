terraform {
  required_providers {
    tls = {
        source = "hashicorp/tls"
        version = "4.1.0"
    }
    
    local = {
        source = "hashicorp/local"
        version = "2.5.3"
    }
  }
  backend "s3" {
    bucket = "terraform-state-ondemandmc"
    key = "state/terraform.tfstate"
    region = "us-east-1"
    encrypt = true

    # to keep track of lock IDs
    # dynamodb_table = "terraform-state-ondemandmc" 
  }
}

provider "aws" {
    region = "us-east-1"
}

