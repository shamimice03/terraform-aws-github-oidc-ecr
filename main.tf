#Register GitHub OIDC under AWS IAM Identity Provider
data "tls_certificate" "github_actions" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github_actions.certificates[0].sha1_fingerprint]
}

#Creating IAM Role with policies to grant access to desired ECR repo
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "github_actions" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
  description        = var.iam_role_description
}

#Trust Policy
locals {
  allowed_branches = var.allowed_branches
  repo_name        = var.github_repo_name
  full_paths = [
    for repo in local.allowed_branches : "repo:${local.repo_name}:ref:refs/heads/${repo}"
  ]
}

data "aws_iam_policy_document" "trust_policy" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github_actions.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = local.full_paths
    }
  }
}

#Policy to access ECR
locals {
  ecr_repo_names = var.ecr_repo_names
  ecr_repo_arns = [
    for ecr_repo in local.ecr_repo_names : "arn:aws:ecr:${var.ecr_region}:${data.aws_caller_identity.current.account_id}:repository/${ecr_repo}"
  ]
}

data "aws_iam_policy_document" "ecr" {
  version = "2012-10-17"

  statement {
    sid       = "GetAuthorizationToken"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowPushPull"
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]
    resources = local.ecr_repo_arns
  }
}

resource "aws_iam_policy" "ecr" {
  name   = "ecr-policy"
  policy = data.aws_iam_policy_document.ecr.json
}

resource "aws_iam_role_policy_attachment" "admin" {
  policy_arn = aws_iam_policy.ecr.arn
  role       = aws_iam_role.github_actions.name
}
