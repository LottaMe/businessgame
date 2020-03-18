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
