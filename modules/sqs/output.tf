output "queue_url" {
  value = aws_sqs_queue.queue.id
}


output "deadletter_queue_url" {
  value = aws_sqs_queue.queue-deadletter.id
}


output "consumer_policy_arn" {
  value = aws_iam_policy.consumer_policy.arn
}


output "producer_policy_arn" {
  value = aws_iam_policy.producer_policy.arn
}
