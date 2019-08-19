.NOTPARALLEL:

VERSION = 0.0

all: inondation-d-additions.sd

inondation-d-additions.sd: inondation-d-additions.fd
	fd2sd $< $@ > /dev/null

inondation-d-additions.fd: INONDATI.BAS Makefile
	(rm -f image.fd $@ &&								\
	imgtool create thom_fd image.fd &&						\
	imgtool put thom_fd image.fd INONDATI.BAS INONDATI.BAS --filter=thombas128 &&	\
	mv -f image.fd $@)

check: inondation-d-additions.fd INONDATI.BAS Makefile
	rm -f TEST.BAS && imgtool get thom_fd inondation-d-additions.fd INONDATI.BAS TEST.BAS --filter=thombas128 && cmp INONDATI.BAS TEST.BAS

DISTFILES =				\
	inondation-d-additions.fd	\
	inondation-d-additions.sd	\
	README.md			\
	COPYING				\
	INONDATI.BAS

dist: check ${DISTFILES}
	mkdir -p inondation-d-additions-${VERSION}
	cp -a ${DISTFILES} inondation-d-additions-${VERSION}/
	zip inondation-d-additions-${VERSION}.zip inondation-d-additions-${VERSION}/
	rm -rf inondation-d-additions-${VERSION}/

clean:
	rm -f image.fd inondation-d-additions.fd inondation-d-additions.sd TEST.BAS
