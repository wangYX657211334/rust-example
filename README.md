# rust-example
rust-example

## 相关地址
### 中文文档
https://kaisery.github.io/trpl-zh-cn/title-page.html
https://rustwiki.org/zh-CN/reference/introduction.html
### 中文示例
https://rustwiki.org/zh-CN/rust-by-example/hello.html
### rust圣经
https://course.rs/into-rust.html



## 代码生成
https://openapi-generator.tech/docs/generators/rust-server

``` shell
cnpm install @openapitools/openapi-generator-cli -g

openapi-generator-cli generate -i office-buddy-api.yaml -g rust-server -o ./office-buddy-server
```