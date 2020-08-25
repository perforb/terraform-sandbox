## DO NOT write secret information in this file ##

profile = "default"
env = "dev"
alb_log_bucket_name = "infracodegang-alb-log-bucket-dev"
cloud_watch_logs_bucket_name = "infracodegang-cloud-watch-logs-bucket-dev"
bucket_force_destroy = true
enable_deletion_protection = false
load_balancer_container_name = "web"
load_balancer_container_port = 80
health_check_path = "/"
app_api_registry_name = "ecr-app-api"
