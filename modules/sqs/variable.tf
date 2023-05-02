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
