help:
	@IFS=$$'\n' ; \
            help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
            for help_line in $${help_lines[@]}; do \
                IFS=$$'#' ; \
                help_split=($$help_line) ; \
                help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
                help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
                printf "%-15s %s\n" $$help_command $$help_info ; \
            done

git-pull:
	@git pull &>/dev/null

cart: ## setup cart component
	@bash components/cart.sh

catalogue: ## setup catalogue component
	@bash components/catalogue.sh

user: ## setup user component
	@bash components/user.sh

shipping: ## setup shipping component
	@bash components/shipping.sh

payment: ## setup payment component
	@bash components/payment.sh

frontend: ## setup frontend component
	@bash components/frontend.sh

mysql: ## setup mysql component
	@bash components/mysql.sh

redis: ## setup redis component
	@bash components/redis.sh

rabitmq: ## setup rabitmq component
	@bash components/rabitmq.sh

mongodb: ## setup mongodb component
	@bash components/mongodb.sh



