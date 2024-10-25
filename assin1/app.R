library(shiny)
library(DT)
library(shiny)

# These two new packages will be needed for stitching the app altogether 
library(packrat)
library(rsconnect)

# You should already have these packages
library(tidyverse)
library(ggplot2)
library(gridExtra)
library(cowplot)
ui <- fluidPage(
	titlePanel("Density Plots of 5 Variables of High Cholesterol Patients"),
	plotOutput("plot1", click = "plot_click"),
	verbatimTextOutput("info")
)
server <- function(input, output) {
	output$plot1 <- renderPlot({
		heart.dat %>% 
			select(age, restbp, chol, maxach, oldpeak, disease) %>% 
			pivot_longer(age:oldpeak, names_to = "variables", values_to = "values") %>% 
			ggplot(aes(x = values, colour = disease)) +
			geom_density() +
			facet_wrap(~variables, scales = "free")
	})
	
	output$info <- renderText({
		paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
	})
}

shinyApp(ui, server)