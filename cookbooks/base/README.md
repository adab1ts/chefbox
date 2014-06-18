# base Cookbook

This cookbook sets up a fresh installation of your GNU/Linux desktop with a minimum profile.  
The following recipes are applied:

- `base::begin` - manages code and resources to be executed in the first place

- `base::main` - manages the following packages:
  
  * `Ubuntu`

      `-example-content`            - Ubuntu example content  
      `+nautilus-filename-repairer` - Nautilus extension for filename encoding repair  
      `+nautilus-open-terminal`     - Nautilus plugin for opening terminals in arbitrary paths  
      `+ubuntu-restricted-extras`   - Commonly used restricted packages for Ubuntu  

  * `All`

      `virtualbox guest packages`   - Support packages for virtual boxes

- `base::end`      - executes first system upgrade and creates a support folder with post-installation instructions
- `base::run-init` - manages apt sources; must be run before any other recipe in the node run list
- `base::run-end`  - reboots the very first run when chef client succeeds; must be run after any other recipe in the node run list


## Requirements

This cookbook applies to the following platforms:  
- `CrunchBang 11+`
- `Linux Mint 17+`
- `Ubuntu 14.04+`

#### cookbooks
- `core`
- `sudo`

#### recipes
- `core::default`

#### packages
- `openssl`           - Secure Socket Layer (SSL) binary and related cryptographic tools
- `libshadow-ruby1.8` - Interface of shadow password for Ruby 1.8 (precise only)
- `ruby-shadow`       - Interface of shadow password for Ruby 1.9+ (trusty only)


## Usage

#### base::default
Just include `base` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[base]"
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

