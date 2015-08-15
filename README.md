# Selva

[![Code Climate](https://codeclimate.com/github/rolfvandekrol/selva/badges/gpa.svg)](https://codeclimate.com/github/rolfvandekrol/selva)

Selva is a RethinkDB based Tree Wiki.

What's in a name? Selva means tree in Spanish. No, I'm not Spanish at all, but I
like the name.

## Tech

*   **RethinkDB**
    
    Why? Because it's cool, and new, and supports having a listener for updates.
*   **Ruby**
    
    Why? Because I love the language
*   **No Rails**

    Why not? Because I have some ideas about routing that would be a hell to 
    implement in Rails. And I like to see what be a achieved without Rails. I'll
    probably use some parts of Rails, like ActiveSupport
*   Something fancy on the frontend. Might be React.
*   Optimized for Rubinius.

## Technical notes

### Bundler

I use bundler for the handling of the `Gemfile` and `Gemfile.lock`. I do not
use `Bundler.require`, because of the performance hit that comes with it. I do
use `Bundler.setup`, because the expansion of `$:` doesn't come with a serious
performance penalty.

### CLI

Written with Thor. Usage:

```
./selva
```

### Server

Puma. Threading!

```bash
ab -n1000 -c10 http://0.0.0.0:4567/
```

Websockets. Example app https://github.com/heroku-examples/ruby-websockets-chat-demo



