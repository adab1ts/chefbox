# base Cookbook

This cookbook sets up a fresh installation of Ubuntu desktop with a basic profile.  
The following recipes are applied:

- `base::sources` - adds the following apt sources and ppas:
  
  `udev-notify apt source`          - USU Team &lt;lfu.project at gmail.com&gt;  
  `ppa:rye/ubuntuone-extras`        - Roman Yepishev &lt;roman.yepishev at ubuntu.com&gt;  
  `ppa:caffeine-developers/ppa`     - Isaiah Heyer &lt;freshapplepy at gmail.com&gt;  
  `ppa:diesch/testing`              - Florian Diesch &lt;devel at florian-diesch.de&gt;  
  `ppa:kokoto-java/omgubuntu-stuff` - Georgi Karavasilev &lt;motorslav at gmail.com&gt;  
  `ppa:tiheum/equinox`              - Matthieu James &lt;matthieu.james at gmail.com&gt;

- `base::main` - manages the following packages:
  
  `-example-content`            - Ubuntu example content  
  `+dkms`                       - Dynamic Kernel Module Support Framework  
  `+preload`                    - Adaptive readahead daemon  
  `+qtnx`                       - NX client for QT  
  `+p7zip-full`                 - 7z and 7za file archivers with high compression ratio  
  `+nautilus-filename-repairer` - Nautilus extension for filename encoding repair  
  `+nautilus-gtkhash`           - Nautilus extension for computing checksums and more using gtkhash  
  `+nautilus-open-terminal`     - Nautilus plugin for opening terminals in arbitrary paths

- `base::security` - manages the following packages and services:

  `+clamtk`        - Graphical front-end for ClamAV  
  `+cabextract`    - Microsoft Cabinet file unpacker  
  `+libclamunrar6` - Anti-virus utility for Unix - unrar support  
  `+gufw`          - Graphical user interface for ufw  
  `ufw` - Program for managing a Netfilter firewall

- `base::indicators` - manages the following packages:

  `+udev-notify`         - Display notifications about newly plugged hardware  
  `+indicator-ubuntuone` - Indicator for Ubuntu One synchronization service (Ubuntu 12.04 only)  
  `+caffeine`            - Prevents the activation of both the screensaver and the "sleep" powersaving mode

- `base::eyecandy` - manages the following packages:

  `+unsettings`         - Graphical configuration program for the Unity desktop environment  
  `+nitrux-umd`         - NITRUX-like icon theme  
  `+faience-icon-theme` - Faience Icon Theme  
  `+faenza-icon-theme`  - Faenza Icon Theme

- `base::office` - manages the following packages:

  `+lo-menubar`               - A LibreOffice extension for the global menubar (Ubuntu 12.04 only)  
  `+libreoffice-style-galaxy` - Office productivity suite -- Galaxy (Default) symbol style

- `base::restricted-extras` - manages the following packages and fonts:

  `+ubuntu-restricted-extras` - Commonly used restricted packages for Ubuntu  
  `MS Office True Type Fonts`


## Requirements

This cookbook only applies to Ubuntu 12.04+ platform.


## Attributes

#### base::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['base']['fonts_url']</tt></td>
    <td>String</td>
    <td>fonts url</td>
    <td><tt>http://ubuntuone.com/6QmipqSO7F5OXSwhDPOs4J</tt></td>
  </tr>
  <tr>
    <td><tt>['base']['fonts_sha256']</tt></td>
    <td>String</td>
    <td>fonts package checksum</td>
    <td><tt>34afc268300fe5b863ddd6cde973aba3a87d7512ae92e37e4de891a49faa3465</tt></td>
  </tr>
</table>


## Usage

#### base::default
Just include `base` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[base]"
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

