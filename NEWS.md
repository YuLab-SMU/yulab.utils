
# yulab.utils 0.1.1.003

+ `set_translate_option()` allows users to use their own appid and key (2023-12-13, Wed)
+ tools to switch from PCRE or TRE in regular expression (2023-12-13, Wed)
+ `cn2en()` (2023-12-12, Tue)

# yulab.utils 0.1.1

+ `baidu_translate()` and `en2cn()` to translate sentences (2023-12-11, Mon)
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

