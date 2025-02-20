divide_into_folds <- function(df, k=10, num_fold_cols=1, cat_col=NULL, id_col=NULL) {
  groupdata2::fold(df,
        k = k,
        cat_col = cat_col,
        id_col = id_col,
        num_fold_cols = num_fold_cols,
        parallel = TRUE)
}