# devel Cookbook

This cookbook installs a selected set of development tools.
The following recipes may apply:

- `devel::default`    - purges unselected packages and includes recipes as nedeed.
- `devel::atom`       - installs __Ansible simple IT automation__ and suggested packages.
- `devel::atom`       - installs __Atom text editor from GitHub__ and suggested packages.
- `devel::bower`      - installs __Bower package manager for the web__ and suggested packages.
- `devel::brackets`   - installs __Brackets code editor for the web__ and suggested packages.
- `devel::git`        - installs __Git distributed version control system__ and suggested packages.
- `devel::grunt`      - installs __Grunt JavaScript task runner__ and suggested packages.
- `devel::gulp`       - installs __Gulp streaming build system__ and suggested packages.
- `devel::juju`       - installs __Juju service orchestration tool__ and suggested packages.
- `devel::nodejs`     - installs __Node.js event-based server-side javascript engine__ and suggested packages.
- `devel::processing` - installs __Processing open source creative programming language__ and suggested packages.
- `devel::ruby`       - installs __Ruby dynamic and open source programming language__ and suggested packages.
- `devel::shelr`      - installs __Shelr plain text screencasting tool__ and suggested packages.
- `devel::vagrant`    - installs __Vagrant tool for virtualizing development environments__ and suggested packages.
- `devel::virtualbox` - installs __VirtualBox__ and manages post-installation tasks.
- `devel::wp-devel`   - installs __Genesis WordPress to create, develop and deploy WP__ and suggested packages.
- `devel::wsk`        - installs __Google Web Starter Kit__ and suggested packages.
- `devel::yeoman`     - installs __Yeoman web scaffolding tool__ and suggested packages.
- `devel::zsh`        - installs __Zsh Shell__ and suggested packages.


## Requirements

This cookbook applies to the following platforms:  
- `CrunchBang 11+`
- `Linux Mint 17+`
- `Ubuntu 14.04+`

#### cookbooks
- `core`

#### recipes
- `core::default`

#### packages
- `dkms` - Dynamic Kernel Module Support Framework [virtualbox]


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

