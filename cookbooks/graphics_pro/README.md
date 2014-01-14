# graphics_pro Cookbook

This cookbook installs a selected set of graphics pro solutions.
The following recipes may apply:

- `graphics_pro::default`     - purges unselected packages and includes recipes as nedeed.
- `graphics_pro::darktable`   - installs __Darktable for photographers__ and suggested packages.
- `graphics_pro::draftsight`  - delivers support for __DraftSight CAD solution__ installation.
- `graphics_pro::freecad`     - installs __FreeCAD CAx program__ and suggested packages.
- `graphics_pro::gimp`        - installs __Gimp image manipulation program__ and suggested packages.
- `graphics_pro::inkscape`    - installs __Inkscape vector-based drawing program__ and suggested packages.
- `graphics_pro::mypaint`     - installs __Mypaint for use with graphics tablets__ and suggested packages.
- `graphics_pro::qcad`        - installs __QCAD program__ and suggested packages.
- `graphics_pro::rawtherapee` - installs __Rawtherapee RAW file processor__ and suggested packages.
- `graphics_pro::scribus`     - installs __Scribus__ and suggested packages.


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

#### graphics_pro::default
Just include `graphics_pro` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[graphics_pro]"
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

