resource "local_file" "foo" {
    content = "foo1"
    filename = "${path.module}/foo.bar"
}

