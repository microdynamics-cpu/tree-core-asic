
soc:
	@./script/gen_soc.py
	@./script/format_code.py top/soc_top.v

format:
	@./script/format_code.py $(SRC)

.PHONY: soc format