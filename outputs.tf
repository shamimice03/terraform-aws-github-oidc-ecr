output "role_arn" {
  description = "arn of the role"
  value       = aws_iam_role.github_actions.arn
}
