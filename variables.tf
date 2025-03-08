# variable "server_config" {
#   type = object({
#     name = string,
#     type = string,
#   })
#   description = "The configuration of the server to create"

#   validation {
#     condition     = length(var.server_config.name) > 7 && length(var.server_config.name) < 20
#     error_message = "Must be between 7 and 20 characters"
#   }

#   validation {
#     condition     = contains(["t2.micro", "t3.micro"], var.server_config.type)
#     error_message = "Must be either t2.micro or t3.micro"
#   }
# }
 
variable "server_name" {
  description = "Name of the web server"
  type        = string
  validation {
    condition     = length(var.server_name) > 7 && length(var.server_name) < 20
    error_message = "Must be between 7 and 20 characters"
  }
}

variable "server_type" {
  description = "Instance type for the web server"
  type        = string
   validation {
    condition     = contains(["t2.micro", "t3.micro"], var.server_type)
    error_message = "Must be either t2.micro or t3.micro"
  }
}
