#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
library(ROSE)
library(e1071)
library(tidyverse)
library(dplyr)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    theme = shinytheme("journal"),
    
    # Application title
    titlePanel("Patient Readmission Risk Predictive Model - SVM"),

    sidebarLayout(
        sidebarPanel(
            selectInput("usex", "Gender", choices = c("Male", "Female"), selected = "Female"),
            selectInput("uage", "Age Group", choices = c(levels(dt$age))),
            selectInput("uadm_type", "Admission Type", choices = c(levels(dt$admission_type_id)), selected = "Emergency"),
            selectInput("udischarged", "Discharged Disposition", choices = c(levels(dt$discharge_disposition_id)), selected = "Discharged to home"),
            selectInput("uadm_source", "Source of Admission", choices = c(levels(dt$admission_source_id)), selected = "Clinic Referral"),
            sliderInput("utime", "Time in hospital", 1, 14, 5),
            selectInput("umed_spec", "Physician Medical Specialty", choices = c(levels(dt$medical_specialty)), selected = "Surgery"),
            sliderInput("ulab", "Number of Lab Procedures", 0, 10, 5),
            sliderInput("uprod", "Number of Procedures (Exclude Lab)", 0, 10, 5),
            sliderInput("umed", "Number of Medications Prescribed", 0, 10, 5),
            sliderInput("uout", "Number of Out-patient Visits", 0, 10, 5),
            sliderInput("uemer", "Number of Emergency Visits", 0, 10, 5),
            sliderInput("uint", "Number of In-patient Visits", 0, 10, 5),
            sliderInput("udiag", "Number of diagnonsis", 0, 10, 5),
            selectInput("uglucose", "Glucose Serum Test Result", choices = c(levels(dt$max_glu_serum)), selected = "Norm"),
            selectInput("uA1c", "A1c Test Result", choices = c(levels(dt$A1Cresult)), selected = "Norm"),
            selectInput("uchange", "Is there any change in diabetic medications prescribed?", choices = c("No", "Yes"), selected = "No"),
            selectInput("udiabetic", "Is there any diabetic medication prescribed?", choices = c("No", "Yes"), selected = "No"),
            br(),
            
            p("Click the button to predict the patient readmission risk"),
            submitButton("Predict with SVM"),
        
            br(),br(),
            h5("SVM Prediction Result: "),
            verbatimTextOutput("svm_pred")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h1("What is Unplanned Readmission?"),
            p("Unplanned readmission is defined as the act of patient been 
              readmitted due to poor discharge planning, resulting in reoccurrence of the 
              treated diseases or worsen health condition. It is also defined as readmission 
              to the hospital within a short period of time, typically within 30 days 
              after the patient was discharged."),

            
            br(),
            h1("Why is it important to predict unplanned readmission risk?"),
            p("In adjacent to a policy introduced by the Centre for Medicare and Medicaid Services in 2010, financial penalty is given to hospital with reported unplanned readmissions. 
              This policy is effective in both United State of America and abroad, starting from October 1, 2012. 
              It is known as the Hospital Readmission Reduction Program policy (HRRP) (C. for Medicare, M. Services, 2014).
              According to this policy, hospital is required to reduce the treatment fee for patient readmitted within 30-days of discharge. 
              Thus, led to loss of profits for the hospital as it needed to cover the patient treatment expenditure. 
              In addition, the hospital’s financial allocation will also be reduced as extensive punishment for poor quality care services."),
            
            br(),
            p("Futhermore, high unplanned readmission risk also reflected poorly on the healthcare services quality.
              Increasing unplanned readmission shows that most patients are not receiving good care. 
              For many years, traditional methods such as educating patients prior to discharge, personal follow-ups via phone or visits and etc. were implemented to avoid unplanned readmission. 
              This methods however, are impractical. Now, with the current pandemic outbreak, personal follow-ups are not advisable as social distancing become a priority. 
              Hospitals resources are also limited. Hence, a prediction model that predicts unplanned readmission risk is important to help hospitals distribute their resources effectively."),
            
            br(),
            h1("Hospital Readmission Reduction Program (HRRP)"),
            p("The Hospital Readmissions Reduction Program (HRRP) is a Medicare value-based purchasing program that reduces payments to hospitals with excess readmissions. 
              The program supports the national goal of improving healthcare for Americans by linking payment to the quality of hospital care."),
            p("Section 3025 of the Affordable Care Act requires the Secretary of the Department of Health and Human Services (HHS) to establish HRRP and 
              reduce payments to Inpatient Prospective Payment System (IPPS) hospitals for excess readmissions beginning October 1, 2012 (i.e., Fiscal Year [FY] 2013). 
              Additionally, the 21st Century Cures Act requires CMS to assess a hospital’s performance relative to other hospitals with a similar proportion of patients 
              who are dually eligible for Medicare and full-benefit Medicaid beginning in FY 2019. The legislation requires estimated payments under the non-stratified 
              methodology (i.e., FY 2013 to FY 2018) equal payments under the stratified methodology (i.e., FY 2019 and subsequent years) to maintain budget neutrality."),
            br(),
            p("Source of Information: Centers for Medicare and Medicaid Services"),
            
            br(),
            h1("About this Application"),
            p("This application was developed to evaluate patient readmission risk. Machine learning 
              approaches was used to develop this model. This is Support Vector Machine Model (SVM) 
              with Linear Function. The imbalanced data was re-sampled using Random under-sampling (RUS)
              techniques."),
            
            br(),
            tags$h3(tags$b("About Me")),
            tags$p("This Shiny application is developed to fulfill the requirement of 
                        Data Science Research Project (WQD7002) course.
                        The purpose of this application is to evaluate the patient readmission risk."),
            tags$p("Title: Patient Readmission Risk Predictive Model - SVM"),
            tags$p("Developer: Mazlini Halini Binti Mazlan Halili"),
            tags$p("Tools: R Programming Language and RStudio"),
            tags$p("Source Code: ", tags$a(href="https://github.com/mazlinihalini/SVMpredictivemodel", "Click to get source code")),
            tags$p("Data Source: ", br(), a("1. Data Mining and Biomedical Informatics Lab at VCU ", 
                                            href = "http://www.cioslab.vcu.edu/",
                                            target ="_blank"))
            
            
            
        ),
    ))
)
