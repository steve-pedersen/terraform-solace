
resource "solacebroker_msg_vpn_acl_profile" "acl_profiles" {
  for_each                      = { for profile in var.acl_profiles : profile.name => profile }
  acl_profile_name              = each.key
  client_connect_default_action = "allow"
  msg_vpn_name                  = var.solace_broker_name
}

resource "solacebroker_msg_vpn_acl_profile_publish_topic_exception" "acl_profile_publish_topic_exceptions" {
  for_each                       = { for except in var.acl_profile_publish_topic_exceptions : "${except.profile_name}-${except.topic_exception}" => except }
  acl_profile_name               = each.value.profile_name
  msg_vpn_name                   = var.solace_broker_name
  publish_topic_exception        = each.value.topic_exception
  publish_topic_exception_syntax = "smf"
}

resource "solacebroker_msg_vpn_client_username" "client_usernames" {
  for_each                                     = { for user in var.client_usernames : user.name => user }
  client_username                              = each.key
  acl_profile_name                             = each.value.acl_profile_name
  password                                     = each.value.password
  msg_vpn_name                                 = var.solace_broker_name
  enabled                                      = true
  guaranteed_endpoint_permission_override_enabled = each.value.endpoint_override
}

resource "solacebroker_msg_vpn_queue" "dmqs" {
  for_each                      = { for idx, dmq in var.dmqs : idx => dmq }
  msg_vpn_name                  = var.solace_broker_name
  queue_name                    = each.value.name
  owner                         = each.value.owner
  egress_enabled                = each.value.egress_enabled
  ingress_enabled               = each.value.ingress_enabled
  respect_ttl_enabled           = each.value.respect_ttl_enabled
}

resource "solacebroker_msg_vpn_queue" "queues" {
  for_each                      = { for idx, queue in var.queues : idx => queue }
  msg_vpn_name                  = var.solace_broker_name
  queue_name                    = each.value.name
  owner                         = each.value.owner
  permission                    = each.value.permission
  dead_msg_queue                = each.value.dmq_name
  egress_enabled                = each.value.egress_enabled
  ingress_enabled               = each.value.ingress_enabled
  max_redelivery_count          = each.value.max_redelivery_count
  respect_ttl_enabled           = each.value.respect_ttl_enabled
}

resource "solacebroker_msg_vpn_queue_subscription" "subscriptions" {
  for_each                      = { for idx, sub in var.subscriptions : idx => sub }
  msg_vpn_name                  = var.solace_broker_name
  queue_name                    = each.value.queue_name
  subscription_topic            = each.value.subscription_topic
}
