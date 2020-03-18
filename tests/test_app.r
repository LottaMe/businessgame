library(testthat)
context("test this shit")
source("../R/ai.r")

test_that("blub", {
  expect_identical(plus.one(1), 2)
})
