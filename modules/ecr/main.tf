resource "aws_ecr_repository" "repository" {
  name                 = var.name
  image_tag_mutability = var.tag_immutability
  force_delete         = true // will delete the repository even if it contains images
  tags = {
    name = var.name
  }
}

# resource "aws_ecr_lifecycle_policy" "policy" {
#   repository = aws_ecr_repository.repository.name

#   policy = jsonencode({
#     rules = [{
#       rulePriority = 1
#       description  = "keep last 5 images"
#       action = {
#         type = "expire"
#       }
#       selection = {
#         tagStatus   = "any"
#         countType   = "imageCountMoreThan"
#         countNumber = 5
#       }
#     }]
#   })
# }
