.DEFAULT_GOAL := help
.PHONY: help

setup:
	bundle install

start:
	ruby app.rb

test:
	bundle exec rspec spec/*
