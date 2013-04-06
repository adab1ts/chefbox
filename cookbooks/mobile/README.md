# mobile Cookbook

This cookbook installs a selected set of mobile solutions.
The following recipes may apply:

- `mobile::default` - purges unselected packages and includes recipes as nedeed.
- `mobile::mobile3g` - installs __Sakis3G script__ and suggested packages.
- `mobile::mobile3g-full` - installs __Sakis3G script with embedded usb_modeswitch__ and suggested packages.


## Requirements

This cookbook only applies to Ubuntu 12.04+ platform.

#### cookbooks
- `core`
- `base`

#### recipes
- `base::default`


## Usage

#### mobile::default
Just include `mobile` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mobile]"
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

