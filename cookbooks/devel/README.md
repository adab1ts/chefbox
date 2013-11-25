# devel Cookbook

This cookbook installs a selected set of development tools.
The following recipes may apply:

- `devel::default` - purges unselected packages and includes recipes as nedeed.
- `devel::git`     - installs __Git distributed version control system__ and suggested packages.
- `devel::juju`    - installs __Juju service orchestration tool__ and suggested packages.
- `devel::zsh`     - installs __Zsh Shell__ and suggested packages.


## Requirements

This cookbook only applies to Ubuntu 12.04+ platform.

#### cookbooks
- `core`
- `base`

#### recipes
- `base::default`

#### packages
- `htop` - Interactive processes viewer


## Usage

#### devel::default
Just include `devel` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[devel]"
  ]
}
```


## Contact

By Email:   carles.ml.dev at gmail dot com  
On Twitter: [@zuzudev](https://twitter.com/zuzudev)  
On Google+: [Carles Muiños](https://plus.google.com/109480759201585988691)


## License

Copyright (C) 2013 Carles Muiños

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
