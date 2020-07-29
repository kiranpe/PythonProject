resource "tls_private_key" "my_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "python_key" {
  key_name   = "pythonkey"
  public_key = tls_private_key.my_key.public_key_openssh

  depends_on = [
    tls_private_key.my_key
  ]
}

resource "local_file" "file" {
  content         = tls_private_key.my_key.private_key_pem
  filename        = "pythonkey.pem"
  file_permission = "0600"

  depends_on = [
    tls_private_key.my_key,
    aws_key_pair.python_key
  ]
}
