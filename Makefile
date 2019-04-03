.PHONY: start
start:
	@echo "Run project"
	docker-compose up -d --build

.PHONY: clean
clean:
	@echo "Remove all containers and networks from this project"
	docker-compose down

.PHONY: help
help:
	@echo -n "Common make targets"
	@echo ":"
	@cat Makefile | sed -n '/^\.PHONY: / h; /\(^\t@*echo\|^\t:\)/ {H; x; /PHONY/ s/.PHONY: \(.*\)\n.*"\(.*\)"/    make \1\t\2/p; d; x}'| sort -k2,2 |expand -t 20