resource "aws_ecs_cluster" "main" {
  name = "cluster-local"
}

resource "aws_security_group" "ecs_sg" {
  name   = "ecs-sg"
  vpc_id = var.vpc_id # Aqui ele usa a variável que você enviou
}
