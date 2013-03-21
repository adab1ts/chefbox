# lenses Cookbook

This cookbook installs a selected set of Unity lenses.
The following recipes may apply:

- `lenses::default` - purges unselected packages and includes recipes as nedeed.
- `lenses::academic` - installs __Academic Lens__ and suggested scopes.
- `lenses::dictionary` - installs __Wordreference Lens__ and suggested scopes.
- `lenses::movies` - installs __Movie Lense__ and suggested scopes.
- `lenses::music` - installs __Music Lense__ and suggested scopes.
- `lenses::news` - installs __News Lense__ and suggested scopes.
- `lenses::photo` - installs __Photo Lense__ and suggested scopes.
- `lenses::torrents` - installs __Torrents Lense__ and suggested scopes.
- `lenses::translator` - installs __Translator Lense__ and suggested scopes.
- `lenses::utilities` - installs __Utilities Lense__ and suggested scopes.
- `lenses::video` - installs __Video Lense__ and suggested scopes.
- `lenses::wikipedia` - installs __Wikipedia Lense__ and suggested scopes.


## Requirements

This cookbook only applies to Ubuntu 12.04+ platform.

#### cookbooks
- `core`
- `base`

#### recipes
- `base::default`


## Usage

#### lenses::default
Just include `lenses` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[lenses]"
  ]
}
```


## Contact

By lenses:   carles.ml.dev at gmail dot com  
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

