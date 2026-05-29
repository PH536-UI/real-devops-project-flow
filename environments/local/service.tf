resource "aws_ecs_task_definition" "app" {
  family                   = "meu-projeto-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = jsonencode([{
    name                   = "meu-app"
    image                  = "localhost:5000/meu-projeto-app:latest"
    essential              = true
    portMappings           = [{ containerPort = 3000, hostPort = 3000 }]
  }])
}

resource "aws_ecs_service" "main" {
  name            = "meu-projeto-service"
  cluster         = "cluster-local"
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
  network_configuration {
    subnets          = ["subnet-d40c13a8"]
    assign_public_ip = true
  }
}
