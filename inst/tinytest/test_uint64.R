zarr_c <- system.file("extdata", "zarr_examples", "column-first", "uint64.zarr",
                      package = "Rarr")
index <- list(1:30, 1:20, 1)

## Shouldn't be any warnings for this input
expect_silent( column_major <- read_zarr_array(zarr_c, index = index) )

## we return an array
expect_inherits(column_major, "array")

## dimensions equal to the index
expect_equal(dim(column_major), c(30,20,1))

## first row should be sequence 1 to 20
expect_equal(column_major[1,,], 1:20)
## first column should be all 1s
expect_equal(column_major[,1,], rep(1,30))

## this data point should be outside the range of an int32 and throw a warning 
expect_warning( column_major <- read_zarr_array(zarr_c, index = list(30,20,10)) )
expect_true( all(is.na(column_major)) )

