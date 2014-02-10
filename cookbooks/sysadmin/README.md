# sysadmin Cookbook

This cookbook installs a selected set of systems administration solutions.
The following recipes may apply:

- `sysadmin::default`       - purges unselected packages and includes recipes as nedeed.
- `sysadmin::aptik`         - installs __Aptik app__ and suggested packages.
- `sysadmin::epoptes`       - installs __Epoptes (server) computer lab management tool__ and suggested packages.
- `sysadmin::epoptesclient` - installs __Epoptes (client) computer lab management tool__ and suggested packages.
- `sysadmin::freefilesync`  - installs __FreeFileSync visual folder comparison and synchronization app__ and suggested packages.
- `sysadmin::htop`          - installs __htop interactive processes viewer__ and suggested packages.
- `sysadmin::yppamgr`       - installs __Y PPA Manager__ and suggested packages.


## Requirements

This cookbook only applies to the following platforms:  
- `Ubuntu 12.04+`
- `Linux Mint 13+`

#### cookbooks
- `core`

#### recipes
- `core::default`


## Usage

#### sysadmin::default
Just include `sysadmin` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sysadmin]"
  ]
}
```


## Contact

By Email:   carles.ml.dev at gmail dot com  
On Twitter: [@zuzudev](https://twitter.com/zuzudev)  
On Google+: [Carles Muiños](https://plus.google.com/109480759201585988691)


## License

Copyright (c) 2013,2014 Carles Muiños

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

