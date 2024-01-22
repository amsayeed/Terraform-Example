# Terraform

## Introduction

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. It can manage existing popular service providers as well as custom in-house solutions.

Configuration files describe the components required by Terraform to run either a single application or your entire data center. Terraform then generates an execution plan that describes the steps it would take to achieve the desired state, and then it carries out the steps to construct the described infrastructure.

## Key Features

### Infrastructure as Code

Terraform allows you to describe your infrastructure using a high-level configuration syntax. This lets you version and treat your data center blueprint just like any other code. Moreover, it allows the infrastructure to be shared and re-used.

### Execution Plans

Terraform includes a step where it generates an execution plan. This plan gives you a preview of what the apply command will do when you execute it. This means you can avoid unexpected outcomes when Terraform changes the infrastructure.

### Resource Graph

Terraform constructs a graph of all your resources and it parallelizes the creation and modification of any non-dependent resources. The resulting benefits are efficient infrastructure construction and insight into the dependencies in your infrastructure.

### Change Automation

Even complex changesets can be safely applied to your infrastructure with minimal human interaction. The execution plan and resource graph let you know precisely what Terraform will alter and in which order, helping to avoid many possible human errors.


