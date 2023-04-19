<%_ appFolders.forEach((appFolder, index) =>  { _%>
resource "aws_ecr_repository" "ecr_repo_<%- appFolder.toLowerCase() %>" {
  name                 = "<%- appFolder.toLowerCase() %>"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

<%_ }) _%>