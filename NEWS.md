# yulab.utils 0.2.1 

+ export `user_dir()` (2025-08-16, Sat)

# yulab.utils 0.2.0

+ bug fixed in `get_caller_package()` (2025-01-08, Wed)

# yulab.utils 0.1.9

+ `c2()` to concate two vectors into a 'chunked_array' object (2024-12-03, Tue)

# yulab.utils 0.1.8

+ add new citation (The Innovation 2024) (2024-11-07, Thu)
+ `pload()` now supports github package (2024-11-06, Wed)
+ bug fixed in `pkg_ref()` (2024-08-26, Mon)

# yulab.utils 0.1.7

+ `has_internet()` for testing internet connection (2024-08-26, Mon)
+ `pkg_ref()` to access textVersion of package reference (2024-08-21, Wed)
+ export `str_detect()` (20024-08-19, Mon)
+ `user_dir()` to setup user data dir (20024-08-17, Sat)
+ `which_os()` to return the system name
+ `has_bin()` to check whether a command is exist in the system 

# yulab.utils 0.1.6

+ `mydownload()` for downloading online file (2024-08-17, Sat)
    - internally use 'httr2' and is 'https' friendly
+ update `bib_ggtree()` and `bib_knowledge()` with all previous related publications (2024-08-12, Mon)
+ remove memory caching and disable file cache by default in `yread()` and `yread_tsv()` (2024-07-27, Sat)
+ `bib_ggtree()` and `bib_knowledge()` (2024-07-27, Sat)

# yulab.utils 0.1.5

+ `yulab_msg()` for startup message of packages developed by YuLab (2024-07-26, Fri)

# yulab.utils 0.1.4

+ `str_extract()` to extract substring using a regular expression pattern (2024--01-25, Thu)

# yulab.utils 0.1.3

+ with cache ability (2023-12-27, Wed)
    - `initial_cache()`
    - `initial_cache_item()`
    - `get_cache()`
    - `get_cache_item()`
    - `get_cache_element()`
    - `rm_cache_item()`
    - `rm_cache()`

# yulab.utils 0.1.2

+ mv translate functions to the 'fanyi' package (2023-12-14, Thu)
+ tools to switch from PCRE or TRE in regular expression (2023-12-13, Wed)

# yulab.utils 0.1.1

+ use `normalizePath()` in `o()` to convert file paths to canonical form (2023-10-06, Fri, #4)
+ change the default parameter, `ref = "master"` to `ref = "HEAD"` in the `install_zip_gh()` function to use the default branch of the GitHub repo (2023-10-02, Mon)

# yulab.utils 0.1.0

+ `install_zip()` allows both binary and source zip files (2023-09-20, Wed)
+ `pload()` for loading package with the ability to install it if not available (2023-09-16, Sat)
+ `get_dependencies()` and `packageTitle()` (2023-09-11, Mon)
+ import 'fs' and 'digest' (2023-09-07, Thu)

# yulab.utils 0.0.9

+ `ls2df()` convert list of vector to a data.frame (2023-09-01, Fri)

# yulab.utils 0.0.8

+ `mat2list()` and `combinations()` (2023-08-22, Tue)
+ remove default 'params' setting in `yread_tsv()` (2023-08-15, Tue)

# yulab.utils 0.0.7

+ update `check_pkg()` to call `rlang::check_installed()` with reason set automatically (2023-08-03, Thu)
+ `yread()` and `yread_tsv()` that read file with caching (2023-08-02, Wed) 
+ `rbindlist()` to rbind a list (2023-08-01, Tue)
+ `exec()` to run system command (2023-06-19, Mon)
+ `scale_range()` to normalize data by range (2023-06-18, Sun)

# yulab.utils 0.0.6

+ `mat2df()` to convert matrix to a tidy data frame (2022-12-20, Tue)
+ `str_starts()` and `str_ends()` (2022-07-29, Fri)

# yulab.utils 0.0.5

+ `get_fun_from_pkg()` outputs friendly message if the pkg is not installed (2022-06-08, Wed)
+ `show_in_excel()`, `CRANpkg()`, `Biocpkg()`, `Githubpkg()`, `mypkg()` (2021-10-13, Wed)

# yulab.utils 0.0.4

+ `str_wrap()` (2021-10-09, Sat)

# yulab.utils 0.0.3

+ `read.cb()` (2021-08-17)

# yulab.utils 0.0.2

+ `o()`, `install_zip()`, `get_fun_from_pkg()`

# yulab.utils 0.0.1

+ `is.installed()`, `scihub_dl()`, `sudo_install()`

