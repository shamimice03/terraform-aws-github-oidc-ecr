# Register GitHub OIDC and Grant Access to Amazon ECR

## Usage:
```hcl
module "github_to_ecr" {

    source = "github.com/shamimice03/terraform-aws-github-oidc-ecr"

    iam_role_name        = "github-actions-to-ecr"
    iam_role_description = "IAM role to access ecr from github actions using OIDC"
    github_repo_name     = "shamimice03/thumbnail-api-app"
    allowed_branches     = ["main", "dev"]
    ecr_region           = "ap-northeast-1"
    ecr_repo_names       = ["thumbnail-api", "thumbnail-task"]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.25.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.github_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.github_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.github_actions](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_branches"></a> [allowed\_branches](#input\_allowed\_branches) | Allowed github branches | `list(any)` | `[]` | no |
| <a name="input_ecr_region"></a> [ecr\_region](#input\_ecr\_region) | ECR region | `string` | `""` | no |
| <a name="input_ecr_repo_names"></a> [ecr\_repo\_names](#input\_ecr\_repo\_names) | Name of the ECR repository | `list(any)` | `[]` | no |
| <a name="input_github_repo_name"></a> [github\_repo\_name](#input\_github\_repo\_name) | Name of the Github Repo | `string` | `""` | no |
| <a name="input_iam_role_description"></a> [iam\_role\_description](#input\_iam\_role\_description) | IAM Role to access ECR repo from GitHub Actions | `string` | `""` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name of the IAM role for GitHub Actions | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | arn of the role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
