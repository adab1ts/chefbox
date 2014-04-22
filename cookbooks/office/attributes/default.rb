#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: office
# Attribute File:: default
#
# Copyright 2013,2014 Carles Muiños
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# MS Office True Type Fonts
default[:office][:msttfonts][:file]   = "fonts.tar.gz"
default[:office][:msttfonts][:url]    = "https://ocserver/public.php?service=files&t=13669ab4b47fdf31f729b6f6fc5f016b&download"
default[:office][:msttfonts][:sha256] = "34afc268300fe5b863ddd6cde973aba3a87d7512ae92e37e4de891a49faa3465"
default[:office][:msttfonts][:path]   = "/usr/share/fonts/truetype/msttfonts"

