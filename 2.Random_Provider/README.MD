# Terraform Random Provider

This README provides an overview of the random provider in Terraform and how to use it in your infrastructure-as-code projects.

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)


## Introduction

The random provider is a built-in provider in Terraform that allows you to generate random values during the execution of your Terraform code. It can be useful in scenarios where you need to generate random strings, numbers, or other types of values.

## Installation

The random provider is included by default in Terraform, so there is no need to install any additional plugins or extensions.


```hcl
provider "random" {
  version = "~> 3.0"
}
```

## Usage

To use the random provider, you need to declare it in your Terraform configuration file. Here's an example:

### Random String
To generate a random string, which is often used for unique identifiers like passwords or machine names:
```hcl
resource "random_string" "example" {
  length  = 16
  special = true
}
```
### Random Integer
To generate a random integer, useful for scenarios where you need a numeric value:
```hcl
resource "random_integer" "example" {
  min = 1
  max = 100
}
```
### Random Shuffle
To shuffle a list of strings and return a single value:
```hcl
resource "random_shuffle" "example" {
  input = ["one", "two", "three"]
  result_count = 1
}
```

### Random Password 

```hcl
resource "random_password" "example" {
    length           = 12
    special          = true
    override_special = "_%@"
}
```