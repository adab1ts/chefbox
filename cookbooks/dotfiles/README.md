# dotfiles Cookbook

This cookbook deploys a useful set of dotfiles, aliases and functions that eases daily command line tasks.
The following recipes are applied:

- `dotfiles::default` - puts dotfiles directory structure in place.


## Requirements

This cookbook only applies to the following platforms:  
- `Ubuntu 12.04+`
- `Linux Mint 13+`

#### cookbooks
- `core`
- `base`

#### recipes
- `base::default`

#### packages
- `tree`     - Displays directory tree, in color
- `meld`     - Graphical tool to diff and merge files
- `apt-file` - Search for files within Debian packages (command-line interface)
- `apt-show-versions` - Lists available package versions with distribution


## Usage

#### dotfiles::default
Just include `dotfiles` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[dotfiles]"
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

