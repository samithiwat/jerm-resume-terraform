resource "aws_sqs_queue" "queue_deadletter" {
  name = var.deadletter_queue_name
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.queue.arn]
  })
}

resource "aws_sqs_queue" "queue" {
  name                      = var.queue_name
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.queue_deadletter.arn
    maxReceiveCount     = 4
  })

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-${var.queue_name}-queue"
    Environment = var.app_environment
  }
}