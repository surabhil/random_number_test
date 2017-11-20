provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

#  make sure this is the same as in the vars.tf file!
terraform {
  backend "s3" {
    region  = "us-west-2"
    profile = "apimarket"
    bucket  = "apim-configs"
    key     = "terraform/states/random.tfstate"
  }
}

module "random_api_lambda" {
  source = "git::git@github.com:API-market/terraform-modules.git//api"

  aws_region = "${var.aws_region}"

  config_bucket = "${var.config_bucket}"

  api_name = "${var.api_name}"

  authorizers = ["auth_1"]

  names = ["random"]

  paths = ["random"]

  methods = [""]

  validations = ["NONE"]
}

resource "aws_api_gateway_base_path_mapping" "test-mapping" {
  api_id      = "${module.random_api_lambda.api_id}"
  stage_name  = "${module.random_api_lambda.api_stage}"
  domain_name = "test.api.market"
  base_path   = "${var.api_name}"
}
