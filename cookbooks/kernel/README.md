# kernel Cookbook

This cookbook installs a selected set of kernel-level solutions.
The following recipes may apply:

- `kernel::default` - installs selected drivers and the following packages:
  
  `dkms`           - __Dynamic Kernel Module Support Framework__  
  `intel_graphics` - __Intel Linux Graphics Installer__  
  `preload`        - __Adaptive Readahead Daemon__  
  `tlp`            - __TLP Linux Advanced Power Management__


## Requirements

This cookbook only applies to the following platforms:  
- `Ubuntu 12.04+`
- `Linux Mint 13+`

#### cookbooks
- `core`
- `base`

#### recipes
- `base::default`


## Usage

#### kernel::default
Just include `kernel` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[kernel]"
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

