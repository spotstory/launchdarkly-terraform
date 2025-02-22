resource "launchdarkly_project" "project" {
  for_each = {
    for project in var.project :
    project.name => project
  }
  key  = each.value.name
  name = lookup(each.value, "display_name", each.value.name)

  tags = var.tags

  dynamic "environments" {
    for_each = toset(var.environment)
    content {
      name  = environments.value
      key   = lower(environments.value)
      color = "0a8b2f"
      tags  = var.tags
    }
  }
}
