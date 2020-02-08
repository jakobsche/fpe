# If it works, it makes one of the compressed files in the directory deploy. 
# This file is tested with
# 
# make TARGET_CPU=x86_64 TARGET_OS=darwin WIDGETSET=cocoa
#
# on MacBook Air. Patch it, and send me your patched file, if this does not satisfy your
# requirements!

DEPLOY: deploy/$(TARGET_CPU)-$(TARGET_OS).zip

deploy/$(TARGET_CPU)-darwin.zip: BUNDLE README.md LICENSE
	mkdir -p deploy/$(TARGET_CPU)-$(TARGET_OS)
	cp -fpv README.md deploy/$(TARGET_CPU)-$(TARGET_OS)/
	cp -fpv LICENSE deploy/$(TARGET_CPU)-$(TARGET_OS)/
	cp -fpvR fpe.app deploy/$(TARGET_CPU)-$(TARGET_OS)/
	cp -fpv lib/$(TARGET_CPU)-$(TARGET_OS)/fpe deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/
	cp -fpv lib/$(TARGET_CPU)-$(TARGET_OS)/fpe.po deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/
	cp -fpv LICENSE deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/
	cp -fpvR help deploy/$(TARGET_CPU)-$(TARGET_OS)/fpe.app/Contents/MacOS/
	zip -ru deploy/$(TARGET_CPU)-$(TARGET_OS).zip deploy/$(TARGET_CPU)-$(TARGET_OS)

# Ziel Bundle erstellen: 
# - erzeugt kein .po-file, dafür muß mit Lazarus kompiliert werden
# - lazbuild übernimmt nicht die richtige Voreinstellung für das Widmetest, muß deshalb explizit angegeben werden
BUNDLE: fpe.lpi fpe.lpr *.pas *.lfm *.lrj
	lazbuild --os=$(TARGET_OS) --cpu=$(TARGET_CPU) --ws=$(WIDGETSET) --language=de fpe.lpi
