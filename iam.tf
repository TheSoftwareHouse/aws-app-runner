resource "aws_iam_role" "app_runner_instance_role" {
  name               = "${var.service_name}-AppRunnerInstanceRole"
  assume_role_policy = data.aws_iam_policy_document.app_runner_instance_role_assume_policy.json
}

resource "aws_iam_role_policy_attachment" "app_runner_instance_policy" {
  role       = aws_iam_role.app_runner_instance_role.name
  policy_arn = aws_iam_policy.app_runner_instance_policy.arn
}

resource "aws_iam_role" "app_runner_access_role" {
  name               = "${var.service_name}-AppRunnerAccessRole"
  assume_role_policy = data.aws_iam_policy_document.app_runner_access_role_assume_policy.json
}

resource "aws_iam_role_policy_attachment" "app_runner_access_policy" {
  role       = aws_iam_role.app_runner_access_role.name
  policy_arn = aws_iam_policy.app_runner_access_policy.arn
}

resource "aws_iam_policy" "app_runner_instance_policy" {
  name   = "${var.service_name}-AppRunnerInstancePolicy"
  policy = data.aws_iam_policy_document.app_runner_instance_policy.json

  tags = var.tags
}

resource "aws_iam_policy" "app_runner_access_policy" {
  name   = "${var.service_name}-AppRunnerAccessPolicy"
  policy = data.aws_iam_policy_document.app_runner_access_policy.json

  tags = var.tags
}
