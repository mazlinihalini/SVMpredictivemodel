#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
load("SVM.RData")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Encoding the user input categorical value to numeric
    sex = reactive({
        if(input$usex == "Male"){
            1
        } else{
            2
        }  
    })
    
    agegroup = reactive({
        if(input$uage == "[0-10)"){
            0
        } else if(input$uage == "[10-20)"){
            1
        } else if(input$uage == "[20-30)"){
            2
        } else if(input$uage == "[30-40)"){
            3
        } else if(input$uage == "[40-50)"){
            4
        } else if(input$uage == "[50-60)"){
            5
        } else if(input$uage == "[60-70)"){
            6
        } else if(input$uage == "[70-80)"){
            7
        } else if(mydata()$uage == "[80-90)"){
            8
        } else{
            9
        }
    })
    
    
    # Store user Admission Type
    admission_type = reactive({
        if(input$uadm_type == "Not Stated"){
            0
        } else if(input$uadm_type == "Elective"){
            1
        } else if(input$uadm_type == "Emergency"){
            2
        } else if(input$uadm_type == "Newborn"){
            3
        } else if(input$uadm_type == "Trauma Center"){
            4
        } else{
            5
        }
    })
    
    
    # Store user Discharged Disposition
    discharge_disposition = reactive({
        if(input$udischarged == "Not Stated"){
            0
        } else if(input$udischarged == "Discharged to home"){
            1
        } else if(input$udischarged == "Discharged/transferred to a long term care hospital."){
            2
        } else if(input$udischarged == "Discharged/transferred to another rehab fac including rehab units of a hospital ."){
            3
        } else if(input$udischarged == "Discharged/transferred to another short term hospital"){
            4
        } else if(input$udischarged == "Discharged/transferred to another type of inpatient care institution"){
            5
        } else if(input$udischarged == "Discharged/transferred to home under care of Home IV provider"){
            6
        } else if(input$udischarged == "Discharged/transferred to home with home health service"){
            7
        } else if(input$udischarged == "Discharged/transferred to ICF"){
            8
        } else if(input$udischarged == "Discharged/transferred to SNF"){
            9
        } else if(input$udischarged == "Discharged/transferred/referred another institution for outpatient services"){
            10
        } else if(input$udischarged == "Discharged/transferred/referred to a psychiatric hospital of psychiatric distinct part unit of a hospital"){
            11
        } else if(input$udischarged == "Discharged/transferred/referred to this institution for outpatient services"){
            12
        } else if(input$udischarged == "Expired"){
            13
        } else if(input$udischarged == "Hospice / home"){
            14
        } else if(input$udischarged == "Hospice / medical facility"){
            15
        } else{
            16
        }
    })
    
    # Store user Admission Source
    admission_source = reactive({
        if(input$uadm_source == "Not Stated"){
            0
        } else if(input$uadm_source == "Clinic Referral"){
            1
        } else if(input$uadm_source == "Court/Law Enforcement"){
            2
        } else if(input$uadm_source == "Emergency Room"){
            3
        } else if(input$uadm_source == "HMO Referral"){
            4
        } else if(input$uadm_source == "Physician Referral"){
            5
        } else if(input$uadm_source == "Transfer from a hospital"){
            6
        } else if(input$uadm_source == "Transfer from a Skilled Nursing Facility (SNF)"){
            7
        } else{                
            8
        }    
    })
    
    time_in_hos = reactive({
        input$utime
    })
    
    
    # Store Medical Specialty
    medical_spec = reactive({
        if(input$umed_spec == "Not Stated"){
            0
        } else if(input$umed_spec == "Anesthesiology"){
            1
        } else if(input$umed_spec == "Anesthesiology-Pediatric"){
            2
        } else if(input$umed_spec == "Cardiology"){
            3
        } else if(input$umed_spec == "Cardiology-Pediatric"){
            4
        } else if(input$umed_spec == "Emergency/Trauma"){
            5
        } else if(input$umed_spec == "Endocrinology"){
            6
        } else if(input$umed_spec == "Endocrinology-Metabolism"){
            7
        } else if(input$umed_spec == "Family/GeneralPractice"){
            8
        } else if(input$umed_spec == "Gastroenterology"){
            9
        } else if(input$umed_spec == "Hematology"){
            10
        } else if(input$umed_spec == "Hematology/Oncology"){
            11
        } else if(input$umed_spec == "Hospitalist"){
            12
        } else if(input$umed_spec == "InfectiousDiseases"){
            13
        } else if(input$umed_spec == "InternalMedicine"){
            14
        } else if(input$umed_spec == "Nephrology"){
            15
        } else if(input$umed_spec == "ObstetricsandGynecology"){
            16
        } else if(input$umed_spec == "Oncology"){
            17
        } else if(input$umed_spec == "Orthopedics"){
            18
        } else if(input$umed_spec == "Orthopedics-Reconstructive"){
            19
        } else if(input$umed_spec == "Osteopath"){
            20 
        } else if(input$umed_spec == "OutreachServices"){
            21
        } else if(input$umed_spec == "Pediatrics"){
            22
        } else if(input$umed_spec == "Pediatrics-CriticalCare"){
            23
        } else if(input$umed_spec == "Pediatrics-EmergencyMedicine"){
            24
        } else if(input$umed_spec == "Pediatrics-Endocrinology"){
            25
        } else if(input$umed_spec == "Pediatrics-Hematology-Oncology"){
            26
        } else if(input$umed_spec == "Pediatrics-Neurology"){
            27
        } else if(input$umed_spec == "Pediatrics-Pulmonology"){
            28
        } else if(input$umed_spec == "PhysicalMedicineandRehabilitation"){
            29
        } else if(input$umed_spec == "PhysicianNotFound"){
            30
        } else if(input$umed_spec == "Podiatry"){
            31
        } else if(input$umed_spec == "Psychiatry"){
            32
        } else if(input$umed_spec == "Pulmonology"){
            33
        } else if(input$umed_spec == "Radiologist"){
            34
        } else if(input$umed_spec == "Radiology"){
            35
        } else if(input$umed_spec == "Surgeon"){
            36
        } else if(input$umed_spec == "Surgery-Cardiovascular/Thoracic"){
            37
        } else if(input$umed_spec == "Surgery-General"){
            38
        } else if(input$umed_spec == "Surgery-Neuro"){
            39
        } else if(input$umed_spec == "Surgery-Plastic"){
            40
        } else if(input$umed_spec == "Surgery-Thoracic"){
            41
        } else if(input$umed_spec == "Surgery-Vascular"){
            42
        } else{
            43
        }
    })
    
    
    num_lab = reactive({
        input$ulab
    })
    
    num_proced = reactive({
        input$uprod
    })
    
    num_med = reactive({
        input$umed
    })
    
    number_out = reactive({
        input$uout
    })
    
    number_emer = reactive({
        input$uemer
    })
    
    number_inp = reactive({
        input$uint
    })
    
    number_diag = reactive({
        input$udiag  
    })
    
    # Store user Glucose serum test result
    max_glu = reactive({
        if(input$uglucose == "None"){
            0
        } else if(input$uglucose == "Norm"){
            1
        } else if(input$uglucose == ">200"){
            2
        } else{
            3
        }
    })
    
    
    # Store user A1c result
    A1Cres = reactive({
        if(input$uA1c == "None"){
            0
        } else if(input$uA1c == "Norm"){
            1
        } else if(input$uA1c == ">7"){
            2
        } else{
            3
        } 
    })
    
    
    # Store user Change in Medication
    changed = reactive({
        if(input$uchange == "No"){
            0
        } else {
            1
        }
    })
    
    
    # Store user Diabetic medication
    diabetes = reactive({
        if(input$udiabetic == "No"){
            0
        } else {
            1
        } 
    })
    
    mydata = reactive({
        data.frame(gender = sex(), age = agegroup(), admission_type_id = admission_type(), 
                   discharge_disposition_id = discharge_disposition(),
                   admission_source_id = admission_source(), time_in_hospital = time_in_hos(), 
                   medical_specialty = medical_spec(), 
                   num_lab_procedures = num_lab(), num_procedures = num_proced(), 
                   num_medications = num_med(), number_outpatient = number_out(), 
                   number_emergency = number_emer(), number_inpatient = number_inp(), 
                   number_diagnoses = number_diag(), max_glu_serum = max_glu(), A1Cresult = A1Cres(),
                   change = changed(), diabetesMed = diabetes())
    })
    
    sv_pred =  reactive({
        as.character(predict(svm_classifier, newdata = mydata()))
    })
    
    quo = reactive({
        if(sv_pred() == "0"){
            "The patient is NOT likely to be readmitted within 30 days"
        } else{
            "The patient is likely to be readmitted within 30 days"
        }
    })
    
    output$svm_pred <- renderPrint({quo()})
    
})
