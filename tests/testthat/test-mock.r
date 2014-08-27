context("Mock")

test_that("can make 3 = 5", {
  with_mock({
    expect_equal(3, 5)
  },
  compare = function(x, y, ...) list(equal = TRUE, message = "TRUE")
  )
})

test_that("empty mock with return value", {
  expect_true(with_mock(TRUE))
})

test_that("non-empty mock with return value", {
  expect_true(with_mock(
    TRUE,
    compare = function(x, y, ...) list(equal = TRUE, message = "TRUE")
  ))
})

test_that("multi-mock", {
  with_mock({
    expect_warning(stopifnot(compare(3, 5)$equal))
  },
  gives_warning = throws_error
  )
})

test_that("nested mock", {
  with_mock({
    with_mock({
      expect_warning(stopifnot(!compare(3, 5)$equal))
    },
    gives_warning = throws_error
    )
  },
  all.equal = function(x, y, ...) TRUE,
  .env = asNamespace("base")
  )
})

test_that("need named arguments for mock", {
  expect_error(with_mock(TRUE, FALSE), "Only named arguments are supported")
  expect_error(with_mock(TRUE, FALSE, anything = identity), "Only named arguments are supported")
})
