# utils Cookbook

This cookbook installs a selected set of utils solutions.
The following recipes may apply:

- `utils::default`    - purges unselected packages and includes recipes as nedeed.
- `utils::backintime` - installs __Back In Time simple backup system__ and suggested packages.
- `utils::brasero`    - installs __Brasero CD/DVD Burning application__ and suggested packages.
- `utils::discs`      - installs __GNOME disk utility__ and suggested packages.
- `utils::furius`     - installs __Furius ISO Mount__ and suggested packages.
- `utils::gnome-do`   - installs __GNOME DO__ and suggested packages.
- `utils::hardinfo`   - installs __Hardinfo__ and suggested packages.
- `utils::p7zip`      - installs __7-Zip file archiver__ and suggested packages.
- `utils::shutter`    - installs __Shutter screenshot application__ and suggested packages.


## Requirements

This cookbook applies to the following platforms:  
- `Linux Mint 17+`
- `Ubuntu 14.04+`

#### cookbooks
- `core`

#### recipes
- `core::default`


## Usage

#### utils::default
Just include `utils` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[utils]"
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

