# jobs Cookbook

This cookbook deploys a simple, yet flexible backup utility.
The following recipes are applied:

- `jobs::default` - puts jobs directory structure and configuration in place.
- `jobs::backup` - puts backup scripts and configuration in place.


## Requirements

This cookbook only applies to the following platforms:  
- `Ubuntu 12.04+`
- `Linux Mint 13+`

#### cookbooks
- `core`

#### recipes
- `core::default`

#### packages
- `tree` - Displays directory tree, in color
- `meld` - Graphical tool to diff and merge files


## Attributes

#### jobs::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:box][:jobs][:log_path]</tt></td>
    <td>String</td>
    <td>path to jobs execution log folder</td>
    <td><tt>/var/jobs/log</tt></td>
  </tr>
  <tr>
    <td><tt>[:box][:jobs][:logrotate_conf]</tt></td>
    <td>String</td>
    <td>logrotate configuration file for jobs execution logs</td>
    <td><tt>/etc/logrotate.d/jobs</tt></td>
  </tr>
</table>


## Usage

#### jobs::default
Just include `jobs` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[jobs]"
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

