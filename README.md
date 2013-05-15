# GameOverseer
GameOverseer is a server _framework_ meant for writing multi-player games.

All you _should_ have to do is write services specific to your game.
## Install
You can install GameOverseer from RubyGems.

Stable release:
`gem install gameoverseer`.

Public Testing release: `gem install gameoverseer --pre`.

## Usage
### Project generator
GameOverseer CLI can generate a template project via `gameoverseer -n project_name` which will create:

* /lib/
* /lib/server.rb
* /services/
* /services/sentinel.rb (sample service)
* /logs/
* /logs/log.txt
* project_name.rb

Then just run `ruby project_name.rb` in the root directory and you have the template already to go.
### Setup
Write services and put them in the 	`services` directory.

### Server
The server handles receiving and sending of all messages.

### Service
GameOverseer uses "services" (a.k.a plugins) for server side "modding".

## License
MIT License

Copyright (c) 2013 cyberarm

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
