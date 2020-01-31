# If it works, it makes one of the compressed files in the directory deploy. 
# This file is tested with
# 
# make TARGET_CPU=x86_64 TARGET_OS=darwin
#
# on MacBook Air. Patch it, and send me your patched file, if this does not satisfy your
# requirements!

DEPLOY: deploy/$(TARGET_CPU)-$(TARGET_OS).zip

deploy/$(TARGET_CPU)-darwin.zip: deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/fpe deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/fpe.po help/contributors.html deploy/$(TARGET_CPU)-$(TARGET_OS)/README.md deploy/$(TARGET_CPU)-$(TARGET_OS)/LICENSE
	zip -ru deploy/$(TARGET_CPU)-$(TARGET_OS).zip deploy/$(TARGET_CPU)-$(TARGET_OS)

deploy/$(TARGET_CPU)-win32.zip: deploy/$(TARGET_CPU)-win32/fpe.exe deploy/$(TARGET_CPU)-win32/fpe.po deploy/$(TARGET_CPU)-win32/help/contributors.html deploy/$(TARGET_CPU)-win32/README.md deploy/$(TARGET_CPU)-win32/LICENSE
	zip -ru deploy/$(TARGET_CPU)-win32.zip deploy/$(TARGET_CPU)-win32

deploy/$(TARGET_CPU)-linux.zip: deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe deploy/$(TARGET_CPU)-linux/fpe.pot deploy/$(TARGET_CPU)-linux/help/contributors.html deploy/$(TARGET_CPU)-linux/README.md deploy/$(TARGET_CPU)-linux/LICENSE
	zip -ru deploy/$(TARGET_CPU)-$(TARGET_OS).zip deploy/$(TARGET_CPU)-$(TARGET_OS)

deploy/$(TARGET_CPU)-linux/help/contributors.html: help/contributors.html deploy/$(TARGET_CPU)-linux/help
	cp -fpv help/contributors.html deploy/$(TARGET_CPU)-linux/help
	
deploy/$(TARGET_CPU)-linux/help: deploy/$(TARGET_CPU)-$(TARGET_OS)
	mkdir deploy/$(TARGET_CPU)-linux/help
	
deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe: lib/$(TARGET_CPU)-$(TARGET_OS)/fpe deploy/$(TARGET_CPU)-$(TARGET_OS)
	strip -o deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe lib/$(TARGET_CPU)-$(TARGET_OS)/fpe
	
deploy/$(TARGET_CPU)-$(TARGET_OS):
	mkdir -p deploy/$(TARGET_CPU)-$(TARGET_OS)

deploy/$(TARGET_CPU)-win32/fpe.exe: lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.exe deploy/$(TARGET_CPU)-$(TARGET_OS)
	strip -o deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.exe lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.exe

deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.po: lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.po
	cp -fpv lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.po deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.po
	
deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.pot: lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.pot
	cp -fpv lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.pot deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.pot

deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/fpe: lib/$(TARGET_CPU)-$(TARGET_OS)/fpe lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.app
	strip -o deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/fpe lib/$(TARGET_CPU)-$(TARGET_OS)/fpe

deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/fpe.po: lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.po lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.app
	cp -fpv lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.po deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/ 

deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/help/contributors.html: help/contributors.html lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.app
	cp -fpRv help deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/

deploy/$(TARGET_CPU)-darwin/fpe.app: lib/$(TARGET_CPU)-darwin/fpe.app
	cp -fpRv lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.app deploy/$(TARGET_CPU)-$(TARGET_OS)/

deploy/$(TARGET_CPU)-$(TARGET_OS)/README.md: README.md
	cp -fpv README.md deploy/$(TARGET_CPU)-$(TARGET_OS)/

deploy/$(TARGET_CPU)-$(TARGET_OS)/LICENSE: LICENSE
	cp -fpv LICENSE deploy/$(TARGET_CPU)-$(TARGET_OS)/

lib/$(TARGET_CPU)-darwin/fpe.app, lib/$(TARGET_CPU)-$(TARGET_OS)/fpe, lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.po: fpe.lpi help *.pas *.lfm *.lrj
	lazbuild --language=de fpe.lpi
	cp -fpRv help lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/
