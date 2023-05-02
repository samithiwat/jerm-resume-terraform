# Common Configuration
variable "queue_retention_period" {
  type = string
  description = "Time (in seconds) that messages will remain in queue before being purged"
  default = 86400
}

variable "queue_visibility_timeout" {
  type = string
  description = "Time (in seconds) that consumers have to process a message before it becomes available again"
  default = 60
}

variable "queue_receive_count" {
  description = "The number of times that a message can be retrieved before being moved to the dead-letter queue"
  type = number
  default = 3
}

# Queue
variable "queue_name" {
  type = string
  description = "Queue name"
}

# Deadletter Queue
variable "deadletter_queue_name" {
  type = string
  description = "Deadletter queue name"
}
