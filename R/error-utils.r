
#' Standardized error handling function
#'
#' @param message Error message to display
#' @param class Custom error class for categorization
#' @param ... Additional context information
#' @return No return value, throws error
#' @importFrom rlang abort
#' @export
yulab_abort <- function(message, class = "yulab_error", ...) {
    abort(
        message = message,
        class = c(class, "yulab_error"),
        ...
    )
}

#' Standardized warning function
#'
#' @param message Warning message to display
#' @param class Custom warning class for categorization
#' @param ... Additional context information
#' @return No return value, issues warning
#' @importFrom rlang warn
#' @export
yulab_warn <- function(message, class = "yulab_warning", ...) {
    warn(
        message = message,
        class = c(class, "yulab_warning"),
        ...
    )
}

#' Standardized info function
#'
#' @param message Information message to display
#' @param class Custom info class for categorization
#' @param ... Additional context information
#' @return No return value, displays information
#' @importFrom rlang inform
#' @export
yulab_inform <- function(message, class = "yulab_info", ...) {
    inform(
        message = message,
        class = c(class, "yulab_info"),
        ...
    )
}

#' Check input validity with detailed error messages
#'
#' Enhanced input validation with support for basic types and improved error messages
#' @param x Object to check
#' @param type Expected type (can be basic type like "numeric", "character" or class name)
#' @param length Expected length (optional)
#' @param min_length Minimum length (optional)
#' @param max_length Maximum length (optional)
#' @param allow_null Whether NULL is allowed
#' @param arg_name Name of the argument for error messages
#' @return Invisible TRUE if valid, throws error otherwise
#' @export
check_input <- function(x, type = NULL, length = NULL, min_length = NULL, 
                       max_length = NULL, allow_null = FALSE, arg_name = "input") {
    
    # Validate function parameters
    if (!is.character(arg_name) || length(arg_name) != 1) {
        yulab_abort("arg_name must be a single character string", class = "parameter_error")
    }
    if (!is.null(type) && (!is.character(type) || length(type) != 1)) {
        yulab_abort("type must be a single character string or NULL", class = "parameter_error")
    }
    if (!is.null(length) && (!is.numeric(length) || length(length) != 1 || length <= 0)) {
        yulab_abort("length must be a single positive number or NULL", class = "parameter_error")
    }
    if (!is.null(min_length) && (!is.numeric(min_length) || length(min_length) != 1 || min_length < 0)) {
        yulab_abort("min_length must be a single non-negative number or NULL", class = "parameter_error")
    }
    if (!is.null(max_length) && (!is.numeric(max_length) || length(max_length) != 1 || max_length <= 0)) {
        yulab_abort("max_length must be a single positive number or NULL", class = "parameter_error")
    }
    
    # Check for NULL values
    if (allow_null && is.null(x)) {
        return(invisible(TRUE))
    }
    
    if (is.null(x)) {
        yulab_abort(
            paste0("Invalid ", arg_name, ": cannot be NULL"),
            class = "null_error"
        )
    }
    
    # Enhanced type checking with support for basic types
    if (!is.null(type)) {
        # Check for basic types first
        basic_types <- c("numeric", "character", "logical", "integer", "double", "complex", "raw")
        if (type %in% basic_types) {
            if (typeof(x) != type) {
                yulab_abort(
                    paste0("Invalid ", arg_name, ": expected ", type, ", got ", typeof(x)),
                    class = "type_error"
                )
            }
        } else {
            # Check for S3/S4 classes
            if (!inherits(x, type)) {
                yulab_abort(
                    paste0("Invalid ", arg_name, ": expected ", type, ", got ", class(x)[1]),
                    class = "type_error"
                )
            }
        }
    }
    
    # Length validation
    x_length <- length(x)
    
    if (!is.null(length) && x_length != length) {
        yulab_abort(
            paste0("Invalid ", arg_name, ": expected length ", length, ", got ", x_length),
            class = "length_error"
        )
    }
    
    if (!is.null(min_length) && x_length < min_length) {
        yulab_abort(
            paste0("Invalid ", arg_name, ": minimum length is ", min_length, ", got ", x_length),
            class = "length_error"
        )
    }
    
    if (!is.null(max_length) && x_length > max_length) {
        yulab_abort(
            paste0("Invalid ", arg_name, ": maximum length is ", max_length, ", got ", x_length),
            class = "length_error"
        )
    }
    
    invisible(TRUE)
}

#' Check if required packages are installed with informative errors
#'
#' Enhanced package checking with better error messages and validation
#' @rdname check_packages
#' @param packages Character vector of package names
#' @param reason Reason why these packages are needed
#' @return Invisible TRUE if all packages are available, throws error otherwise
#' @export
check_packages <- function(packages, reason = "for this functionality") {
    
    # Validate input parameters
    if (!is.character(packages) || length(packages) == 0) {
        yulab_abort("packages must be a non-empty character vector", class = "parameter_error")
    }

    if (is.null(reason)) {
        call <- sys.call(1L)
        reason <- sprintf("for %s()", as.character(call)[1])
    }

    if (!is.character(reason) || length(reason) != 1) {
        yulab_abort("reason must be a single character string", class = "parameter_error")
    }
    
    # Remove duplicates and empty strings
    packages <- unique(packages[packages != ""])
    
    if (length(packages) == 0) {
        yulab_warn("No valid package names provided", class = "empty_package_list_warning")
        return(invisible(TRUE))
    }
    
    # Check for missing packages
    # missing_pkgs <- packages[!sapply(packages, requireNamespace, quietly = TRUE)]
    
    missing_pkgs <- packages[!vapply(packages, is.installed, logical(1))]

    if (length(missing_pkgs) > 0) {
        pkg_list <- paste(missing_pkgs, collapse = ", ")
        yulab_abort(
            paste0("Missing required packages ", reason, ": ", pkg_list, ". ",
                  "Please install with: install.packages(c(", 
                  paste0("\"", missing_pkgs, "\"", collapse = ", "), "))"),
            class = "missing_package_error"
        )
    }
    
    invisible(TRUE)
}

#' @rdname check_packages
#' @export
check_pkg <- check_packages

#' Handle file operations with proper error messages
#'
#' Enhanced file validation with comprehensive checks and better error messages
#' @param path File path
#' @param operation Operation being performed (read, write, etc.)
#' @param must_exist Whether the file must exist
#' @return Invisible TRUE if operation can proceed, throws error otherwise
#' @export
check_file <- function(path, operation = "read", must_exist = TRUE) {
    
    # Validate input parameters
    if (!is.character(path) || length(path) != 1 || path == "") {
        yulab_abort("path must be a single non-empty character string", class = "parameter_error")
    }
    if (!is.character(operation) || length(operation) != 1) {
        yulab_abort("operation must be a single character string", class = "parameter_error")
    }
    
    # Normalize path for better error messages
    normalized_path <- normalizePath(path, winslash = "/", mustWork = FALSE)
    
    if (must_exist) {
        if (!file.exists(path)) {
            yulab_abort(
                paste0("File not found for ", operation, ": ", normalized_path),
                class = "file_not_found_error"
            )
        }
        
        # Additional checks for read operations
        if (grepl("read", operation, ignore.case = TRUE)) {
            if (file.access(path, 4) != 0) {  # 4 is read permission
                yulab_abort(
                    paste0("No read permission for file: ", normalized_path),
                    class = "file_permission_error"
                )
            }
        }
    } else {
        # For files that shouldn't exist (e.g., write operations)
        if (file.exists(path)) {
            yulab_warn(
                paste0("File already exists and will be overwritten: ", normalized_path),
                class = "file_overwrite_warning"
            )
            
            # Check write permissions if file exists
            if (file.access(path, 2) != 0) {  # 2 is write permission
                yulab_abort(
                    paste0("No write permission for existing file: ", normalized_path),
                    class = "file_permission_error"
                )
            }
        }
    }
    
    invisible(TRUE)
}

#' Check if value is within specified range
#'
#' Validates that a numeric value falls within the specified range
#' @param x Numeric value to check
#' @param min Minimum allowed value (optional)
#' @param max Maximum allowed value (optional)
#' @param inclusive Whether bounds are inclusive (default: TRUE)
#' @param arg_name Name of the argument for error messages
#' @return Invisible TRUE if valid, throws error otherwise
#' @export
check_range <- function(x, min = NULL, max = NULL, inclusive = TRUE, arg_name = "value") {
    
    # Validate parameters
    if (!is.numeric(x) || length(x) != 1) {
        yulab_abort(paste0(arg_name, " must be a single numeric value"), class = "parameter_error")
    }
    if (!is.null(min) && (!is.numeric(min) || length(min) != 1)) {
        yulab_abort("min must be a single numeric value or NULL", class = "parameter_error")
    }
    if (!is.null(max) && (!is.numeric(max) || length(max) != 1)) {
        yulab_abort("max must be a single numeric value or NULL", class = "parameter_error")
    }
    if (!is.logical(inclusive) || length(inclusive) != 1) {
        yulab_abort("inclusive must be a single logical value", class = "parameter_error")
    }
    
    # Range validation
    if (!is.null(min)) {
        if (inclusive && x < min) {
            yulab_abort(
                paste0("Invalid ", arg_name, ": minimum value is ", min, ", got ", x),
                class = "range_error"
            )
        } else if (!inclusive && x <= min) {
            yulab_abort(
                paste0("Invalid ", arg_name, ": must be greater than ", min, ", got ", x),
                class = "range_error"
            )
        }
    }
    
    if (!is.null(max)) {
        if (inclusive && x > max) {
            yulab_abort(
                paste0("Invalid ", arg_name, ": maximum value is ", max, ", got ", x),
                class = "range_error"
            )
        } else if (!inclusive && x >= max) {
            yulab_abort(
                paste0("Invalid ", arg_name, ": must be less than ", max, ", got ", x),
                class = "range_error"
            )
        }
    }
    
    invisible(TRUE)
}

#' Check if directory exists and is accessible
#'
#' Validates directory existence and accessibility with options to create if missing
#' @param path Directory path
#' @param create_if_missing Whether to create directory if it doesn't exist
#' @param check_write_permission Whether to verify write permissions
#' @param arg_name Name of the argument for error messages
#' @return Invisible TRUE if valid, throws error otherwise
#' @export
check_directory <- function(path, create_if_missing = FALSE, check_write_permission = TRUE, arg_name = "directory") {
    
    # Validate parameters
    if (!is.character(path) || length(path) != 1 || path == "") {
        yulab_abort("path must be a single non-empty character string", class = "parameter_error")
    }
    if (!is.logical(create_if_missing) || length(create_if_missing) != 1) {
        yulab_abort("create_if_missing must be a single logical value", class = "parameter_error")
    }
    if (!is.logical(check_write_permission) || length(check_write_permission) != 1) {
        yulab_abort("check_write_permission must be a single logical value", class = "parameter_error")
    }
    
    # Normalize path
    normalized_path <- normalizePath(path, winslash = "/", mustWork = FALSE)
    
    if (!dir.exists(path)) {
        if (create_if_missing) {
            # Attempt to create directory
            dir_created <- tryCatch({
                dir.create(path, recursive = TRUE, showWarnings = FALSE)
                TRUE
            }, error = function(e) FALSE)
            
            if (!dir_created) {
                yulab_abort(
                    paste0("Failed to create directory: ", normalized_path),
                    class = "directory_creation_error"
                )
            }
            
            yulab_inform(paste0("Created directory: ", normalized_path), class = "directory_created_info")
        } else {
            yulab_abort(
                paste0("Directory does not exist: ", normalized_path),
                class = "directory_not_found_error"
            )
        }
    }
    
    # Check write permissions if requested
    if (check_write_permission) {
        if (file.access(path, 2) != 0) {  # 2 is write permission
            yulab_abort(
                paste0("No write permission for directory: ", normalized_path),
                class = "directory_permission_error"
            )
        }
    }
    
    invisible(TRUE)
}