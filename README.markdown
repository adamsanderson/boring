Boring
======

Shake free the shackles of color; resist the tyranny of fun!

Boring will strip ANSI escape sequences.  For instance some utilities may use ansi escapes to colorize their output, or make some particularly important thing blink.  This is great great in your terminal, but looks pretty poor in an email, and can cause some log processors to choke up.  The solution? Make the text boring!

Usage
-----

Assuming you have some test results that look like this:

~~~
test_result.log:
[1;31mFailure:[22m
test_comments_generate_change_reports(ActivityStreamTest)[0m
~~~

You can strip escape sequences with `boring`:

~~~
$ boring test_result.log
Failure:
test_comments_generate_change_reports(ActivityStreamTest)
~~~ 

You can also use `boring` as a Ruby library:

~~~ ruby
require 'boring'

boring = Boring.new
boring.scrub("[1;31mFailure![22m")
#=> "Failure!"
~~~

Installation
------------

Install `boring` with rubygems:

    gem install boring

-----

Adam Sanderson, http://www.monkeyandcrow.com