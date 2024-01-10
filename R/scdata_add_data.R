#' Function to add single-cell data to the 'scdata' package for simple retrieval
#'
#' This function add single-cell data to the 'scdata' package for simple retrieval
#' @param package_path Path to 'scdata' package
#' @param file_name File name of input data
#' @param sample_path Path to input data (do not include file_name)
#' @param sample_id Name of sample for 'scdata' storage & retrieval (if 'file_name' is the 'sample_id', then add 'file_name')
#' @param file_type Input data file type used to select appropriate Read function (default is "10x_h5")
#' @param multi FALSE if data is NOT multi-modal (default); TRUE if data is multi-modal and input file contains multiple slots (only reads "Gene Expression" slot)
#' @param feature_type Define feature (row names) recovered from input data - if 10x GEX/RNA data, select "ENS" for Ensembl ID or "ID" for gene ID
#' @param overwrite If TRUE, overwrite data present in 'scdata' if Sample_ID already exists in 'scdata' library; If FALSE, there will be an Error flag if Sample_ID already exists in 'scdata' library
#' @return Data added to the 'scdata' package
#' @export
#' @examples
#' scdata_add_data(package_path=path/to/scdata, sample_id=sample_id, sample_path=path/to/sample_id, file_name=filtered_feature_bc_matrix.h5, file_type="10x_h5", multi=FALSE, feature_type="ENS")
#
scdata_add_data <- function(
	package_path=package_path,
	file_name=file_name,
	sample_path=sample_path,
	sample_id=sample_id,
	file_type="10x_h5",
	multi=FALSE,
	feature_type="ENS",
	overwrite=TRUE) {
	#
	cat("Sample ID:", sample_id, "\n")
	cat("Sample Path:", sample_path, "\n")
	cat("File Name:", file_name, "\n")
	cat("File Type:", file_type, "\n")
	cat("\n")
	
	# Load metadata file
	data(scdata_metadata, package="scdata")
	
	#
	if (overwrite == FALSE & length(intersect(scdata_metadata$Sample_ID, sample_id)) > 0) {
		#
		cat("\n")
		cat("ERROR: Sample_ID Already Exists in Library: ... New Sample_ID must be unique ... or ... Set 'overwrite' to 'TRUE'", "\n")
		cat("\n")
		#
	} else {

		#
		if (feature_type == "ENS") {
			#
			use_names <- FALSE
			#
		} else if (feature_type == "ID") {
			#
			use_names <- TRUE
			#
		}

		#
		if (file_type == "10x_h5" & multi == FALSE) {
			#
			data_input <- suppressMessages(Seurat::Read10X_h5(file.path(sample_path, file_name), use.names=use_names))
			#
		} else if (file_type == "10x_h5" & multi == TRUE) {
			#
			data_input <- suppressMessages(Seurat::Read10X_h5(file.path(sample_path, file_name), use.names=use_names)[["Gene Expression"]])
			#
		} else {
			#
			cat("FAILURE: Unknown File Type !!!", "\n")
			#
		}

		#
		cat(paste("Save '", sample_id, "' to 'scdata' package 'data' directory", sep=""), "\n")
		#
		path_orig <- getwd()
		#
		setwd(file.path(package_path, "data"))

		# Assign variable name ('x') to data_input 'value'
		assign(x=sample_id, value=data_input)
  	
  		# Add data directly to 'data' directory in 'scdata'
  		do.call("use_data", list(as.name(sample_id), overwrite = TRUE))
		#
		setwd(path_orig)
		#
		return(data_input)
		#
	}
}
#
