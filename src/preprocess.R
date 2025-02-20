preprocess_fn <- function(train_data, test_data, formula, hyperparameters) {
  hyperparameters <- cvms::update_hyperparameters(
    use_imputation = TRUE,
    hyperparameters = hyperparameters
  )
  base_imputation_model = 'not applied'

  if (hyperparameters[["use_imputation"]]) {
    mode_col_list <- list(city='mode', 
                          gender='mode', 
                          relevent_experience='mode', 
                          enrolled_university='mode',
                          education_level='mode',
                          major_discipline='mode',
                          experience='mode',
                          company_size='mode',
                          company_type='mode',
                          last_new_job='mode')
    mean_col_list <- list(training_hours='mean', 
                          city_development_index='mean')


    base_imputation_model <- create_base_imputation_model(train_data, 
                                                          append(mode_col_list, mean_col_list))

    # Preprocessing pipeline
    train_data <- train_data %>% base_imputation(base_imputation_model)
    test_data <- test_data %>% base_imputation(base_imputation_model)
  }

  # Create data frame with applied preprocessing parameters
  preprocess_parameters <- data.frame(base_imputation_model=base_imputation_model)
  
  # Return list with these names
  list("train" = train_data,
       "test" = test_data,
       "parameters" = preprocess_parameters)
}
