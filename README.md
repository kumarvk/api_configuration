# api_configuration

Given a YAML file like below, please generate a sample scripts that dynamically generates classes (extended from MyParentApi).  Each class will have a method named run() which will request the API `url` and then map the data to our internal data.  Based on the response of the API, map the external param to our internal parameter.  We would then call Foo3.run() to parse the URL and store it in our internal table.  I should be able to add Foo4 easily by updating the YAML file.

```
- id: 1
  name: Foo
  api_class: FooApi
  parent_class: MyParentApi
  url: http://foo.com/v0/data.json
  max_retries: 5
  max_timeout: 20
  parameter_map:
    external_param_abc: internal_param1
    external_param_efg: internal_param2
 
- id: 2
  name: Foo2
  api_class: Foo2Api
  parent_class: MyParentApi
  url: http://foo2.com/v2/data.json
  max_retries: 10
  max_timeout: 20
  parameter_map:
    external_param_hik: internal_param1
    external_param_lmn: internal_param2

- id: 3
  name: Foo3
  api_class: Foo3Api
  parent_class: MyParentApi
  url: http://foo3.com/v1/data.json
  max_retries: 10
  max_timeout: 30
  parameter_map:
    external_param_opq: internal_param1
    external_param_rst: internal_param2
```

#Setup Project

$ cd api_configuration/
$ bundle install
$ rake db:migrate
$ ruby app_call.rb



