# video_pro Cookbook

This cookbook installs a selected set of video pro solutions.
The following recipes may apply:

- `video_pro::default`    - purges unselected packages and includes recipes as nedeed.
- `video_pro::avidemux`   - installs __Avidemux free video editor__ and suggested packages.
- `video_pro::cinelerra`  - installs __Cinelerra audio/video authoring tool__ and suggested packages.
- `video_pro::obs-studio` - installs __OBS Studio streaming software__ and suggested packages.
- `video_pro::shotcut`    - installs __Shotcut video editor__ and suggested packages.


## Requirements

This cookbook applies to the following platforms:  
- `Linux Mint 17+`
- `Ubuntu 14.04+`

#### cookbooks
- `core`

#### recipes
- `core::default`


## Usage

#### video_pro::default
Just include `video_pro` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[video_pro]"
  ]
}
```


## Contact

By Email:   carles.ml.dev at gmail dot com  
On Twitter: [@zuzudev](https://twitter.com/zuzudev)  
On Google+: [Carles Muiños](https://plus.google.com/109480759201585988691)


## License

Copyright (c) 2013-2015 Carles Muiños

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
