**WORK IN PROGRESS**

On branch steve-03-fragments
We need `zef install https://github.com/croservices/cro-webapp.git` until Cro Fragments are relased.

Candidates for Fragments are:
- [x] click_to_load - 1
- [x] edit_row - 1
- [x] inline_validation
- [x] infinite_scroll
- [x] value_select
- [x] tabs_hateoas
- [ ] tabs_hyperscript
- [ ] updating_other_content

---

Contributions welcome - by PR please if possible.

See [Issues](https://github.com/librasteve/raku-HTMX-Examples/issues) for feature discussions.

HTMX EXAMPLES
=============

This repository provides a raku [Cro](https://cro.raku.org) implementation of the HTMX examples from [https://htmx.org/examples](https://htmx.org/examples).


GETTING STARTED
===============

Install raku - eg. from [rakubrew](https://rakubrew.org), then:

#### Install Cro
- `zef install --/test cro`
- `zef install Cro::WebApp`

#### Install this repo
- `git clone https://github.com/librasteve/raku-HTMX-Examples.git`
- `cd raku-HTMX-Examples` && `zef install .`

#### Make a Cro server
- `cro stub http examples examples`  (OK all the defaults)
- `cp -R lib static templates ./examples`

#### Run and view it
- `cd examples` && `cro run`
- Open a browser and go to `http://localhost:20000`

You will note that cro has many other options as documented at [Cro](https://cro.raku.org) if you want to deploy to a production server.


TIPS & EXTRAS
=============

- In development set CRO_DEV=1 in the [environment](https://cro.services/docs/reference/cro-webapp-template#Template_auto-reload)
- You can use `warn $data.raku; $*ERR.flush;` to say to the cro log window
- The Keyboards Shortcut on htmx.org is flaky on my mac - this example replicates the htmx.org behaviour but probably needs tweaking
- The Dialogs - Pico example is new, using JS from the htmx.org [sandbox](https://codesandbox.io/embed/4mrnhq?view=Editor) 

AUTHOR
======

librasteve <librasteve@furnival.net>

COPYRIGHT AND LICENSE
=====================

Copyright 2024 Contributors

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
