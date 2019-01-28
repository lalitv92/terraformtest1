variable project {
  description = "The project to deploy to, if not set the default provider project is used."
  default     = "silent-card-210011"
}

variable http_forward {
  description = "Set to `false` to disable HTTP port 80 forward"
  default     = true
}

variable name {
  description = "Name for the forwarding rule and prefix for supporting resources"
  default = "testingLoadblancer"
}
