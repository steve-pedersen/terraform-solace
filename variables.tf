variable "solace_broker_username" {
  description = "Username for Solace broker"
  type        = string
}

variable "solace_broker_password" {
  description = "Password for Solace broker"
  type        = string
  sensitive   = true
}

variable "solace_broker_url" {
  description = "URL for Solace broker"
  type        = string
}

variable "solace_broker_name" {
  description = "Name of the Solace broker"
  type        = string
}

variable "acl_profiles" {
  description = "List of ACL profiles"
  type        = list(object({
    name = string
  }))
}

variable "acl_profile_publish_topic_exceptions" {
  description = "List of ACL profile publish topic exceptions"
  type        = list(object({
    profile_name    = string
    topic_exception = string
  }))
}

variable "client_usernames" {
  description = "List of client usernames"
  type        = list(object({
    name            = string
    acl_profile_name = string
    password        = string
    endpoint_override = bool
  }))
}

variable "dmqs" {
  description = "List of dead message queues"
  type        = list(object({
    name                = string
    owner               = string
    egress_enabled      = bool
    ingress_enabled     = bool
    respect_ttl_enabled = bool
  }))
}

variable "queues" {
  description = "List of queues"
  type        = list(object({
    name                 = string
    owner                = string
    permission           = string
    dmq_name             = string
    egress_enabled       = bool
    ingress_enabled      = bool
    max_redelivery_count = number
    respect_ttl_enabled  = bool
  }))
}

variable "subscriptions" {
  description = "List of subscriptions"
  type        = list(object({
    queue_name         = string
    subscription_topic = string
  }))
}
