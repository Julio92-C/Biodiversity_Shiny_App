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
