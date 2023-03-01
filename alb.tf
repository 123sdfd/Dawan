# Un équilibreur de charge constitue le point de contact unique pour les clients.

resource "aws_lb" "lampalb" {
  name               = "lamp-alb-dawan" #unique
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.websubnets.*.id

  enable_deletion_protection = false #default

  tags = {
      "Name" = "alb"
  }
}

# Groupes cibles pour vos équilibreurs de charge d'applications

resource "aws_lb_target_group" "lamptg" {
  name        = "lamp-alb-target"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.lamp_vpc.id
  target_type = "instance" #default

  health_check {
    enabled             = true #default
    healthy_threshold   = 3 #default
    interval            = 30
    matcher             = "200,202"
    path                = "/"
    port                = "80"
    protocol            = "HTTP" #default
    timeout             = 5 #default
    unhealthy_threshold = 3
  }
}


#Un écouteur est un processus qui recherche les demandes de connexion à l'aide du protocole et du port que vous avez configurés.

resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = aws_lb.lampalb.arn
  default_action {
    target_group_arn = aws_lb_target_group.lamptg.arn
    type             = "forward"
  }

  port              = "80"
  protocol          = "HTTP" #default
}


# Attacher les instances EC2 au sein du groupes cibles

resource "aws_lb_target_group_attachment" "ipattachment" {
  count            = var.az_count
  target_group_arn = aws_lb_target_group.lamptg.arn
  target_id        = aws_instance.lampsetup[count.index].id
  port             = 80
}

