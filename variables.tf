variable "iam_role_name" {
  description = "Name of the IAM role for GitHub Actions"
  type        = string
  default     = ""
}

variable "iam_role_description" {
  description = "IAM Role to access ECR repo from GitHub Actions"
  type        = string
  default     = ""
}

variable "allowed_branches" {
  description = "Allowed github branches"
  type        = list(any)
  default     = []
}

variable "github_repo_name" {
  description = "Name of the Github Repo"
  type        = string
  default     = ""
}

variable "ecr_region" {
  description = "ECR region"
  type        = string
  default     = ""
}

variable "ecr_repo_names" {
  description = "Name of the ECR repository"
  type        = list(any)
  default     = []
}
