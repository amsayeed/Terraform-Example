/*
This Terraform code defines two local_file resources: sample_res1 and sample_res2.
The sample_res1 resource creates a local file named "sql.txt" with the content "I Love SQL".
The sample_res2 resource creates a local file named "python.txt" with the content "I Love Python".
*/
resource local_file sample_res1 {
    filename = "sql.txt"
    content = "I Love SQL"
}

resource local_file sample_res2 {
    filename = "python.txt"
    content = "I Love Python"
}
