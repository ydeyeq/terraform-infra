terraform {
  cloud {

    organization = "devops-lead-test-project"

    workspaces {
      name = "DOKS-cluster"
    }
  }
}