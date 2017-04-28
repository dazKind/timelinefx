CONF = release
CFLAGS=
ifeq ($(CONF), debug)
	CFLAGS+=-debug
endif

all: js java

js:
	haxe -js bin/js/timelinefx.js -main timelinefx.TimelineFX -D js-flatten

java:
	haxe -cp timelinefx -java bin/java/TimelineFX -D no-root timelinefx.TimelineFX $(CFLAGS)

.PHONY: java
