.DEFAULT_GOAL := help
.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup: ## Install dependencies from Gemfile.
	bundle install

start: ## Start web server locally.
	bundle exec rackup --host 0.0.0.0 -p 4567

test: ## Run test suite (Rspec).
	bundle exec rspec spec/*

rubocop: ## Run linter (Rubocop).
	bundle exec rubocop

docs: ## Generate documentation (Rdoc).
	bundle exec rdoc

dkr-setup: ## Build vetsi app on Docker.
	docker build -t vetsi-app:v1 .

dkr-start: ## Start and lunch the vetsi on Docker.
	docker run -d -p 4567:4567 --name vetsi-app vetsi-app:v1 && sleep 3 && open http://localhost:4567

dkr-test: ## Run test suite (Rspec).
	docker exec -it vetsi-app bundle exec rspec
