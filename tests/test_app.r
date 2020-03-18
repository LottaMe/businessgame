library(testthat)
library(shiny)
library(dplyr)
library(tibble)
library(purrr)
library(ggplot2)
library(ggiraph)

context("Test Game Functions")
source("../R/game.r")

# test create_params(players, x-cost, y-cost, imi-cost)
test_that("create_params: stop if players aren't character vector", {
  expect_error(create_params(3, 15, 45, 20))
})

test_that("create_params: player starts always on the left", {
  expect_equal(create_params(c("Computer", "You"), 15, 45, 20)$start_xcor, c(8, 3))
  expect_equal(create_params(c("You", "Computer"), 15, 45, 20)$start_xcor, c(3, 8))
})

test_that("create_params: a list is returned", {
  expect_identical(typeof(create_params(c("Computer", "You"), 15, 45, 20)), "list")
})

# test move_short_to_fullname(shortname)
test_that("move_short_to_fullname: shortname is converted or NULL", {
  expect_identical(move_short_to_fullname("c"), "Check (do nothing)")
  expect_identical(move_short_to_fullname("il"), "Imitate & adjust marketing left")
  expect_null(move_short_to_fullname("NEIN"))
})

# test create_state(params) ??mocking??

# test create_producers(params)
test_that("create_producers: returns tibble with correct columns", {
  params <- list(producer_names=c("You", "Computer"), start_money=100,
                 start_xcor=c(3, 8), start_ycor=c(8,3))

  expect_true(is_tibble(create_producers(params)))
  expect_true(all("name" %in% colnames(create_producers(params)),
                  "balance" %in% colnames(create_producers(params)),
                  "xcor" %in% colnames(create_producers(params)),
                  "ycor" %in% colnames(create_producers(params))
                  ))
})

# test create_products(params)
test_that("create_products", {
  params <- list(producer_names=c("You", "Computer"),
                 start_xcor=c(3, 8), start_ycor=c(8,3))

  expect_true(is_tibble(create_products(params)))
  expect_true(all("owner" %in% colnames(create_products(params)),
                  "xcor" %in% colnames(create_products(params)),
                  "ycor" %in% colnames(create_products(params))
  ))
})
