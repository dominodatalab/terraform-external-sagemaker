run "setup_tests" {
  module {
    source = "./tests/setup"
  }
  variables {
    region = "us-east-1"
  }
}

run "create_resources" {
  command = apply
  variables {
    resource_identifier                  = run.setup_tests.resource_identifier
    domino_external_deployments_role_arn = run.setup_tests.domino_external_deployments_role_arn
    domino_environments_repository_arn   = "arn:aws:ecr:us-east-1:763104351884:pytorch-inference"
    region                               = "us-east-1"
  }
}
