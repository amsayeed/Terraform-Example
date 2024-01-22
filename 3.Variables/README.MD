## TerraForm Variables

### Variables Types
- String

```hcl
variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}
```

- Number
```hcl
    variable "instance_count" {
      description = "The number of instances to launch"
      default     = 1
    }
```
- List
```hcl
    variable "cidrs" {
      description = "The CIDR blocks to use"
      default     = ["default", "sg-12345678"]
    }
```
- Tuple
```hcl
    variable "cidrs" {
      description = "The CIDR blocks to use"
      default     = ["default", "sg-12345678"]
    }
```

- Set
```hcl
    variable "cidrs" {
      description = "The CIDR blocks to use"
      default     = ["default", "sg-12345678"]
    }
```
- Map
```hcl
    variable "cidrs" {
      description = "The CIDR blocks to use"
      default     = ["default", "sg-12345678"]
    }
```
- Bool
```hcl
    variable "cidrs" {
      description = "The CIDR blocks to use"
      default     = ["default", "sg-12345678"]
    }
```
- Object
```hcl
    variable "cidrs" {
      description = "The CIDR blocks to use"
      default     = ["default", "sg-12345678"]
    }
```


### 1. Create a variable.tf file
```
variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}
```
### 2. Use the variable in the main.tf file
```
provider "aws" {
  region = "${var.region}"
}
```
### 3. Use the variable in the command line
```
terraform plan -var 'region=us-east-2'
```
### 4. Use the variable in a file
```
terraform plan -var-file="testing.tfvars"
```