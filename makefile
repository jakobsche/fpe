# If it works, it makes one of the compressed files in the directory deploy. 
# This file is tested with
# 
# make TARGET_CPU=x86_64 TARGET_OS=darwin
#
# on MacBook Air. Patch it, and send me your patched file, if this does not satisfy your
# requirements!

DEPLOY: deploy/$(TARGET_CPU)-$(TARGET_OS).zip
	zip -ru deploy/$(TARGET_CPU)-$(TARGET_OS).zip deploy/$(TARGET_CPU)-$(TARGET_OS)

deploy/$(TARGET_CPU)-$(TARGET_OS): deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app deploy/$(TARGET_CPU)-$(TARGET_OS)/README.md deploy/$(TARGET_CPU)-$(TARGET_OS)/LICENSE

deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app: lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.app lib/$(TARGET_CPU)-$(TARGET_OS)/fpe lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.po
	cp -u lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.app deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app
	cp -u lib/$(TARGET_CPU)-$(TARGET_OS)/fpe deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/fpe
	cp -u lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.po deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/fpe.po

deploy/$(TARGET_CPU)-$(TARGET_OS)/README.md: README.app
	cp -u README.md deploy/$(TARGET_CPU)-$(TARGET_OS)/README.md

deploy/$(TARGET_CPU)-$(TARGET_OS)/LICENSE: LICENSE
	cp -u LICENSE deploy/$(TARGET_CPU)-$(TARGET_OS)/LICENSE

lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.app, lib/$(TARGET_CPU)-$(TARGET_OS)/fpe, lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.po: fpe.lpi help *.pas *.lfm *.lrj
	lazbuild fpe.lpi
	cp -u help lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/help
