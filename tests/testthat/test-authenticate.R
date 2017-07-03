context("authenticate")

test_that("authenticate works",{
          authenticate("fa4d643a3b2b95ac59ec0ad6381e86267abbe278")
          expect_equal(!is.null(.state$token),TRUE)
}
)
