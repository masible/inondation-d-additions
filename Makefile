.NOTPARALLEL:

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

clean:
	rm -f image.fd inondation-d-additions.fd inondation-d-additions.sd TEST.BAS
