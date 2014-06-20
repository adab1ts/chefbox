# video Cookbook

This cookbook installs a selected set of video solutions.
The following recipes may apply:

- `video::default`    - purges unselected packages and includes recipes as nedeed.
- `video::bombonodvd` - installs __Bombono DVD authoring program__ and suggested packages.
- `video::dvdstyler`  - installs __DVDStyler DVD Authoring System for Video DVD Production__ and suggested packages.
- `video::handbrake`  - installs __HandBrake DVD ripper and video transcoder__ and suggested packages.
- `video::miro`       - installs __Miro Media Player__ and suggested packages.
- `video::mmc`        - installs __Mobile Media Converter__ and suggested packages.
- `video::mvc`        - installs __Miro Video Converter__ and suggested packages.
- `video::ogmrip`     - installs __OGMRip DVD ripper and encoder__ and suggested packages.
- `video::openshot`   - installs __Openshot Video Editor__ and suggested packages.
- `video::recmydesk`  - installs __recordMyDesktop audio/video capture software__ and suggested packages.
- `video::ssr`        - installs __Simple Screen Recorder__ and suggested packages.
- `video::vlc`        - installs __VLC Multimedia Player__ and suggested packages.


## Requirements

This cookbook applies to the following platforms:  
- `Linux Mint 17+`
- `Ubuntu 14.04+`

#### cookbooks
- `core`

#### recipes
- `core::default`


## Usage

#### video::default
Just include `video` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[video]"
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

