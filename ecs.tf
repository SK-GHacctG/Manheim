# ECS Cluster definition
#
resource "aws_ecs_cluster" "web_app_cluster" {
  name = "web-app-cluster"
}

# Fargate Task Definition 
#
resource "aws_ecs_task_definition" "my_web_task" {
  family = "my-web-task-definition"
  cpu    = "1024"       # After careful analysis of usage metrics we can adjust it up or down
  memory = "2048"       # After careful analysis of usage metrics we can adjust it up or down
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  # Container definition 
  # In case there is an issue loading nginx:latest, a Dockerfile and config files are added;
  # we can create a docker image and push it to ECR, which we can use here
  #
  container_definitions = <<EOF
[
  {
    "name": "my-web-container",
    "image": "nginx:latest",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
EOF
}

# ECS Service definition
# This is not an ideal case, nor a secured case - have NAT gateway to allow incoming internet traffic
# directly to the container instance by assigning a public IP address
# Alternatively, we can have an ALB in between, to have the public IP exposed
resource "aws_ecs_service" "my_web_service" {
  name = "my-web-service"
  cluster = aws_ecs_cluster.web_app_cluster.arn
  launch_type = "FARGATE"
  task_definition = aws_ecs_task_definition.my_web_task.arn
  network_configuration {
    subnets = [var.var_subnet_id1, var.var_subnet_id2]
    security_groups = [aws_security_group.my_web_server_sg.id]
  }
  desired_count = 2
  deployment_configuration {
    minimum_healthy_percent = 100
    maximum_percent         = 200
  }
}
