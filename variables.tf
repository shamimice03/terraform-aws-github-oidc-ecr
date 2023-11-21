variable "iam_role_name" {
  description = "Name of the IAM role for GitHub Actions"
  type        = string
  default     = "github-actions-to-ecr"
}

variable "iam_role_description" {
  description = "IAM Role to access ECR repo from GitHub Actions"
  type        = string
  default     = "IAM Role to access ECR repo from GitHub Actions"
}

variable "allowed_branches" {
  description = "Allowed github branches"
  type        = list(any)
  default     = ["dev", "main"]
}

variable "github_repo_name" {
  description = "Name of the Github Repo"
  type        = string
  default     = "shamimice03/thumbnail-api-app"
}

variable "ecr_region" {
  description = "ECR region"
  type        = string
  default     = "ap-northeast-1"
}

variable "ecr_repo_names" {
  description = "Name of the ECR repository"
  type        = list(any)
  default     = ["thumbnail-api", "thumbnail-task"]
}
