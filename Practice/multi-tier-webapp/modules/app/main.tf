# Load Balancer
resource "aws_lb" "app" {
  name               = "multitier"
  load_balancer_type = "application"
  security_groups =  [var.security_group_id]
  subnets = var.subnets
}   
resource "aws_lb_target_group" "app-target" {
  name        = "multi-target"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
}
resource "aws_lb_listener" "app-listener" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-target.arn
  }
}

# Launch Template
resource "aws_launch_template" "multi-template" {
  name = "EC2_launch_Template"
  image_id = var.ami_id
  instance_type = "t2.micro"
  key_name = "practice"
  vpc_security_group_ids = [var.security_group_id]
  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl start nginx
  EOF
  )
   tags = {
    Name = "webapp-terra"
  }
}

# Auto Scaling Groups

resource "aws_autoscaling_group" "asg" {
  name                      = "multi-asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  vpc_zone_identifier       = var.subnets
   launch_template {
    id      = aws_launch_template.multi-template.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.app-target.arn]
    timeouts {
    delete = "15m"
  }
}