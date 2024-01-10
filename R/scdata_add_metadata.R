#' Function to add sample MetaData to the 'scdata' package to review available data
#'
#' This function add single-cell data to the 'scdata' package for simple retrieval
#' @param package_path Path to 'scdata' package
#' @param annotation_file_name Name of annotation file (likely "scdata_annotation.csv")
#' @param annotation_path Path to input annotation file (do not include file_name)
#' @param print_sample_id TRUE to print all sample IDs listed in annotation file; FALSE to NOT print sample IDs (Default = TRUE)
#' @return MetaData added to the 'scdata' package
#' @export
#' @examples
#' scdata_add_metadata(package_path=path/to/scdata, annotation_file_name=scdata_annotation, annotation_path=path/to/annotation, print_sample_id=TRUE)
#
scdata_add_metadata <- function(
	package_path=package_path,
	annotation_file_name=annotation_file_name,
	annotation_path=annotation_path,
	print_sample_id=TRUE) {
	#
	annotation <- suppressWarnings(read.csv(file.path(annotation_path, annotation_file_name), stringsAsFactors=FALSE))
	rownames(annotation) <- annotation$Sample_ID
	#
	if (print_sample_id == TRUE) {
		#
		for (i in 1:nrow(annotation)) {
			#
			cat("Sample", i, "of", nrow(annotation), "\n")
			print(t(annotation[i,]))
			cat("\n")
			#
		}
	}

	#
	cat(paste("Save MetaData to 'scdata' package 'data' directory", sep=""), "\n")
	#
	path_orig <- getwd()
	#
	setwd(file.path(package_path, "data"))

  	# Remove "Sample_Path" column from metadata
	scdata_metadata <- annotation[,colnames(annotation) != "Sample_Path"]
	
  	# Add data directly to 'data' directory in 'scdata'
	usethis::use_data(scdata_metadata, overwrite=TRUE)
	#
	setwd(path_orig)
	#
	return(scdata_metadata)
	#
}
#
