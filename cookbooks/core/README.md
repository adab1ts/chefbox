# core Cookbook

This cookbook includes core components to be used as a foundation for other cookbooks.  
It is based on [opscode-cookbooks/apt](https://github.com/opscode-cookbooks/apt) cookbook
by

    Joshua Timberman (&lt;joshua at opscode.com&gt;)
    Matt Ray (&lt;matt at opscode.com&gt;)
    Seth Chisamore (&lt;schisamo at opscode.com&gt;)


## Requirements

This cookbook only applies to Ubuntu 12.04+ platform.


## Resources/Providers

### Managing repositories

This LWRP provides an easy way to manage additional PPA repositories.
Adding a new repository will notify running the `execute[synchronize_package_index]`
resource immediately.

#### Actions

- :add: creates a repository file and builds the repository listing
- :remove: removes the repository file

#### Attribute Parameters

- repo_name: The name of the new source file
- uri: the ppa uri to add
- distribution: this is usually your release's codename

#### Examples

    # add the nitrux-umd repo
    core_ppa "kokoto-java-omgubuntu-stuff" do
      uri "ppa:kokoto-java/omgubuntu-stuff"
      distribution "precise"
    end


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

