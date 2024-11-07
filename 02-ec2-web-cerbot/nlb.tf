resource "aws_lb" "web_nlb" {
  internal           = false
  load_balancer_type = "network"
  subnets = [
    data.terraform_remote_state.vpc.outputs.public_subnet_id,
    data.terraform_remote_state.vpc.outputs.public_subnet_b
  ]
  tags = merge(
    { Name = "${local.app_name_dashed}-web-nlb" },
  local.tags)
}
resource "aws_lb_target_group" "web_tg" {
  port        = 80
  protocol    = "TCP"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = merge(
    { Name = "${local.app_name_dashed}-web-tg" },
  local.tags)
}


resource "aws_lb_target_group" "web_tg_443" {
  port        = 443
  protocol    = "TCP"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  target_type = "instance"
  tags = merge(
    { Name = "${local.app_name_dashed}-web-tg" },
  local.tags)
}


resource "aws_lb_target_group_attachment" "web_server_attachment" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web_server.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "web_server_attachment_2" {
  target_group_arn = aws_lb_target_group.web_tg_443.arn
  target_id        = aws_instance.web_server.id
  port             = 443
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.web_nlb.arn
  port              = 80
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}


resource "aws_lb_listener" "http2_listener" {
  load_balancer_arn = aws_lb.web_nlb.arn
  port              = 443
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg_443.arn
  }
}