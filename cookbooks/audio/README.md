# audio Cookbook

This cookbook installs a selected set of audio solutions.
The following recipes may apply:

- `audio::default`   - purges unselected packages and includes recipes as nedeed.
- `audio::lastfm`    - installs __Last.fm Scrobbler__ and suggested packages.
- `audio::nuvola`    - installs __Nuvola Music Player__ and suggested packages.
- `audio::rdio`      - installs __Rdio Music Player__ and suggested packages.
- `audio::rhythmbox` - installs __Rhythmbox Music Player__ and suggested packages.
- `audio::spotify`   - installs __Spotify client__ and suggested packages.
- `audio::tomahawk`  - installs __Tomahawk Music Player__ and suggested packages.


## Requirements

This cookbook applies to the following platforms:  
- `Linux Mint 17+`
- `Ubuntu 12.04+`

#### cookbooks
- `core`

#### recipes
- `core::default`


## Usage

#### audio::default
Just include `audio` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[audio]"
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

