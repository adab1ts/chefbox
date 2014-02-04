# office Cookbook

This cookbook installs a selected set of office solutions.
The following recipes may apply:

- `office::default`     - purges unselected packages and includes recipes as nedeed.
- `office::msttfonts`   - installs __MS Office True Type Fonts__.
- `office::fontmanager` - installs __Font Manager__ and suggested packages.
- `office::libreoffice` - installs __LibreOffice productivity suite__ and suggested packages.
- `office::masterpdf`   - installs __Master PDF Editor__ and suggested packages.
- `office::nitro`       - installs __Nitro tasks manager__ and suggested packages.
- `office::pdfshuffler` - installs __PDF-Shuffler__ and suggested packages.
- `office::taskcoach`   - installs __Task Coach todo manager__ and suggested packages.


## Requirements

This cookbook only applies to the following platforms:  
- `Ubuntu 12.04+`
- `Linux Mint 13+`

#### cookbooks
- `core`

#### recipes
- `core::default`


## Attributes

#### office::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:office][:msttfonts][:file]</tt></td>
    <td>String</td>
    <td>name of the fonts package file</td>
    <td><tt>fonts.tar.gz</tt></td>
  </tr>
  <tr>
    <td><tt>[:office][:msttfonts][:url]</tt></td>
    <td>String</td>
    <td>download url</td>
    <td><tt>http://ubuntuone.com/3yvtCqArMf6VBgyAcqC01W</tt></td>
  </tr>
  <tr>
    <td><tt>[:office][:msttfonts][:sha256]</tt></td>
    <td>String</td>
    <td>sha256 sum of the fonts package file</td>
    <td><tt>34afc268300fe5b863ddd6cde973aba3a87d7512ae92e37e4de891a49faa3465</tt></td>
  </tr>
  <tr>
    <td><tt>[:office][:msttfonts][:path]</tt></td>
    <td>String</td>
    <td>installation path</td>
    <td><tt>/usr/share/fonts/truetype/msttfonts</tt></td>
  </tr>
</table>


## Usage

#### office::default
Just include `office` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[office]"
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

