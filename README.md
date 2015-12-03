# cpu-affinity

[![Scribble](https://img.shields.io/badge/Docs-Scribble-blue.svg)](http://pkg-build.racket-lang.org/doc/cpu-affinity/index.html)

A library for getting/setting CPU affinity.

Does not work on Mac OS X because OS X does not expose an API for pinning
processes to CPUs. See:
  https://developer.apple.com/library/mac/releasenotes/Performance/RN-AffinityAPI/

---

Copyright (c) 2015 Asumu Takikawa

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along
with this program. If not, see http://www.gnu.org/licenses.
