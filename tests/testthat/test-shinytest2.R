library(shinytest2)

test_that("{shinytest2} recording: Biodiversity_Shiny_App", {
  app <- AppDriver$new(variant = platform_variant(), name = "Biodiversity_Shiny_App", 
      seed = 0, height = 714, width = 1235)
  app$set_inputs(speciesName = c("Grus grus", "Melampyrum nemorosum"))
  app$set_inputs(speciesName = "Grus grus")
  app$set_inputs(speciesName = character(0))
  app$set_inputs(speciesName = "Sympetrum sanguineum")
  app$set_inputs(speciesName = c("Sympetrum sanguineum", "Fabriciana adippe"))
  app$expect_values()
  app$expect_screenshot()
})


test_that("{shinytest2} recording: Test_Shiny_App_v1", {
  app <- AppDriver$new(variant = platform_variant(), name = "Test_Shiny_App_v1", 
      height = 714, width = 1235)
  app$expect_screenshot()
  app$expect_screenshot()
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(speciesName = c("Melampyrum nemorosum", "Amanita muscaria"))
  app$set_inputs(speciesName = c("Pieris napi", "Melampyrum nemorosum", "Amanita muscaria"))
  app$expect_screenshot()
  app$set_window_size(width = 1235, height = 656)
  app$expect_screenshot()
  app$set_window_size(width = 1235, height = 714)
})
