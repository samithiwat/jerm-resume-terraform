##
## Queue
##

resource "aws_sqs_queue" "queue" {
  name                      = var.queue_name
  delay_seconds             = 90
  message_retention_seconds   = var.queue_retention_period
  visibility_timeout_seconds  = var.queue_visibility_timeout
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.queue-deadletter.arn
    maxReceiveCount     = var.queue_receive_count
  })

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-${var.queue_name}-queue"
    Environment = var.app_environment
  }
}

##
## Deadletter Queue
##

resource "aws_sqs_queue" "queue-deadletter" {
  name = var.deadletter_queue_name
  message_retention_seconds   = var.queue_retention_period
  visibility_timeout_seconds  = var.queue_visibility_timeout
}


##
## Managed policies that allow access to the queue
##

resource "aws_iam_policy" "consumer_policy" {
  name        = "SQS-${var.queue_name}-${var.app_environment}-consumer"
  description = "Policy of ${var.queue_name}"
  policy      = data.aws_iam_policy_document.consumer_policy.json

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-${var.queue_name}-consumer-queue-policy"
    Environment = var.app_environment
  }
}

data "aws_iam_policy_document" "consumer_policy" {
  statement {
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:DeleteMessage",
      "sqs:DeleteMessageBatch",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.queue.arn,
      aws_sqs_queue.queue-deadletter.arn
    ]
  }
}

resource "aws_iam_policy" "producer_policy" {
  name        = "SQS-${var.queue_name}-${var.app_environment}-producer"
  description = "Attach this policy to producers for ${var.queue_name} SQS queue"
  policy      = data.aws_iam_policy_document.producer_policy.json

    tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-${var.queue_name}-producer-queue-policy"
    Environment = var.app_environment
  }
}

data "aws_iam_policy_document" "producer_policy" {
  statement {
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:SendMessage",
      "sqs:SendMessageBatch"
    ]
    resources = [
      aws_sqs_queue.queue.arn
    ]
  }
}