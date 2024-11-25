

m <- matrix(runif(1e5), ncol = 100)
tf1 <- tempfile(fileext = ".zarr")
chunk_dim <- c(50,50)
z1 <- writeZarrArray(m, tf1, chunk_dim = chunk_dim)

expect_inherits(z1, class = "ZarrArray")

# getters
expect_equal(chunkdim(z1), chunk_dim)
## We use grepl here because Rarr appends a trailing slash to the path
## Not sure if we actually want to do that
expect_true(grepl(x = path(z1), pattern = tf1, fixed = TRUE))

# ways to get the array from disk to memory
expect_equal(extract_array(z1, index = list(NULL, NULL)), m)
expect_equal(realize(z1, BACKEND = NULL), m)