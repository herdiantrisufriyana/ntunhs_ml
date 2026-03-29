show_table <- function(
    data
    , name
    , caption
    , max_height = NULL
    , note = NULL
    , digits = NULL
){
  
  table_n <-
    read_csv("inst/extdata/list_of_tables.csv", show_col_types = FALSE) |>
    mutate(n = seq(n())) |>
    filter(variable == name) |>
    pull(n)
  
  # 🔹 Apply formatting
  if(!is.null(digits)){
    
    # Check named vector
    if(is.null(names(digits))){
      stop("\"digits\" must be a named vector with column names.")
    }
    
    # Validate digits
    if(any(
      !sapply(digits, \(d)
              is.numeric(d) && length(d) == 1 && d >= 0 && d == as.integer(d)
      )
    )){
      stop("All digits must be non-negative integers.")
    }
    
    # Apply per column
    data <-
      data |>
      mutate(
        across(
          all_of(names(digits))
          , \(x){
            sprintf(
              paste0("%.", digits[cur_column()], "f")
              , x
            )
          }
        )
      )
  }
  
  table <-
    data |>
    kable(
      caption = paste0("Table ", table_n, ". ", caption)
      , format = "html"
    )
  
  if(!is.null(max_height)){
    table <-
      table |>
      kable_styling(full_width = TRUE) |>
      scroll_box(height = max_height)
  }
  
  if(!is.null(note)){
    table <- table |> footnote(note)
  }
  
  table |>
    kable_classic() |>
    column_spec(seq(ncol(data)), extra_css = "vertical-align:top;")
}