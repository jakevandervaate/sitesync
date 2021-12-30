SCRIPT = ./sitesync
BIN = ~/.local/bin/
MAN = ./sitesync.1
MAN_DIR = ~/.local/share/man/man1/

.PHONY : install
install :
	@chmod +x $(SCRIPT)
	@cp $(SCRIPT) $(BIN)
	@cp $(MAN) $(MAN_DIR)
