# vms Cookbook

This cookbook installs a selected set of virtualization solutions.
The following recipes may apply:

- `vms::default`    - purges unselected packages and includes recipes as nedeed.
- `vms::virtualbox` - installs __VirtualBox__ and manages post-installation tasks.


## Requirements

This cookbook only applies to the following platforms:  
- `CrunchBang 11+`
- `Linux Mint 13+`
- `Ubuntu 12.04+`

#### cookbooks
- `core`

#### recipes
- `core::default`

#### packages
- `dkms` - Dynamic Kernel Module Support Framework [virtualbox]


## Attributes

#### vms::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['vms']['virtualbox']['download_uri']</tt></td>
    <td>String</td>
    <td>VirtualBox downloads base url</td>
    <td><tt>http://download.virtualbox.org/virtualbox</tt></td>
  </tr>
  <tr>
    <td><tt>['vms']['virtualbox']['checksums_uri']</tt></td>
    <td>String</td>
    <td>VirtualBox checksums base url</td>
    <td><tt>http://www.virtualbox.org/downloads/hashes</tt></td>
  </tr>
</table>



## Usage

#### vms::default
Just include `vms` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[vms]"
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

