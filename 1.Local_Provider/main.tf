resource local_file sample_res {
  filename = "sample.txt"
  content = "I Love Terraform"
}
resource local_file py {
  filename = "py.txt"
  content = "I Love Python"
}

resource local_file java {
  filename = "java.txt"
  content = "I Love Java"
}

data local_file foo {
  filename = "sample1.txt"
}

output name1 {
  value       = data.local_file.foo.content
}
