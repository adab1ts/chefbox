# eyecandy Cookbook

This cookbook installs a selected set of eyecandy packages.
The following recipes may apply:

- `eyecandy::default`       - purges unselected packages and includes recipes as nedeed.
- `eyecandy::faenza-icons`  - installs __Faenza icon theme__ and suggested packages.
- `eyecandy::faience-icons` - installs __Faience icon theme__ and suggested packages.
- `eyecandy::moka-icons`    - installs __Moka icon theme__ and suggested packages.
- `eyecandy::nitrux-icons`  - installs __NITRUX-like icon theme__ and suggested packages.
- `eyecandy::unsettings`    - installs __Unsettings__ and suggested packages.


## Requirements

This cookbook only applies to the following platforms:  
- `Ubuntu 12.04+`
- `Linux Mint 13+`

#### cookbooks
- `core`

#### recipes
- `core::default`


## Usage

#### eyecandy::default
Just include `eyecandy` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[eyecandy]"
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

