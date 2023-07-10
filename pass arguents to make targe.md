## Pass arguments to make run 


```makefile
# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

prog: # ...
    # ...

.PHONY: run
run : prog
    @echo prog $(RUN_ARGS)

```


```bash
$ make run foo bar baz
prog foo bar baz
```
