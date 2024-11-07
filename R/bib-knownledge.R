bib_knownledge <- function(id) {
    bib <- c(
        innovation2024 = bib_clusterProfiler_innovation2024,
        np2024 = bib_clusterProfiler_np2024,
        innovation2021 = bib_clusterProfiler_innovation2021,
        omics2012 = bib_clusterProfiler_omics2012,
        chipseeker2022 = bib_chipseeker_cp2022,
        chipseeker2015 = bib_chipseeker_bioinfo2015,
        gosemsim2020 = bib_gosemsim_mmb2020,
        gosemsim2010 = bib_gosemsim_bioinfo2010,
        meshes2018 = bib_meshes_bioinfo2018,
        reactome2016 = bib_reactomepa_mbs20016,
        dose2015 = bib_dose_bioinfo2015
    )

    if (!id %in% names(bib)) return(NULL)

    bib[id]
}

ref_knownledge <- function() {
    refs <- c(
        ChIPseeker_CP = paste(
            "Qianwen Wang, Ming Li, Tianzhi Wu, Li Zhan, Lin Li, Meijun Chen, Wenqin Xie, Zijing Xie, Erqiang Hu, Shuangbin Xu, Guangchuang Yu.",
            "Exploring epigenomic datasets by ChIPseeker.",
            "Current Protocols. 2022, 2(10): e585"),
        ChIPseeker = paste(
            "Guangchuang Yu, Li-Gen Wang, and Qing-Yu He.",
            "ChIPseeker: an R/Bioconductor package for ChIP peak annotation, comparison and visualization.",
            "Bioinformatics. 2015, 31(14):2382-2383"),
        GOSemSim_MMB = paste(
            "Guangchuang Yu.",
            "Gene Ontology Semantic Similarity Analysis Using GOSemSim.",
            "In: Kidder B. (eds) Stem Cell Transcriptional Networks.",
            "Methods in Molecular Biology. 2020, 2117:207-215.",
            "Humana, New York, NY."),
        GOSemSim = paste(
            "Guangchuang Yu, Fei Li, Yide Qin, Xiaochen Bo, Yibo Wu and Shengqi Wang.",
            "GOSemSim: an R package for measuring semantic similarity among GO terms and gene products.",
            "Bioinformatics. 2010, 26(7):976-978"),
        DOSE = paste(
            "Guangchuang Yu, Li-Gen Wang, Guang-Rong Yan, Qing-Yu He.",
            "DOSE: an R/Bioconductor package for Disease Ontology Semantic and Enrichment analysis.",
            "Bioinformatics. 2015, 31(4):608-609"),         
        ReactomePA = paste(
            "Guangchuang Yu, Qing-Yu He.",
            "ReactomePA: an R/Bioconductor package for reactome pathway analysis and visualization.",
            "Molecular BioSystems. 2016, 12(2):477-479"),
        clusterProfiler_NP = paste(
            "S Xu, E Hu, Y Cai, Z Xie, X Luo, L Zhan, W Tang,",
            "Q Wang, B Liu, R Wang, W Xie, T Wu, L Xie, G Yu.", 
            "Using clusterProfiler to characterize multiomics data.", 
            "Nature Protocols. 2024, 19(11):3292-3320"),
        clusterProfiler_Innovation2024 = paste(
            "G Yu.", 
            "Thirteen years of clusterProfiler.", 
            "The Innovation. 2024, 5(6):100722"),
        clusterProfiler_Innovation = paste(
            "T Wu, E Hu, S Xu, M Chen, P Guo, Z Dai, T Feng, L Zhou,",
            "W Tang, L Zhan, X Fu, S Liu, X Bo, and G Yu.", 
            "clusterProfiler 4.0: A universal enrichment tool for interpreting omics data.", 
            "The Innovation. 2021, 2(3):100141"),
        clusterProfiler = paste(
            "Guangchuang Yu, Li-Gen Wang, Yanyan Han and Qing-Yu He.",
            "clusterProfiler: an R package for comparing biological themes among gene clusters.",
            "OMICS: A Journal of Integrative Biology. 2012, 16(5):284-287"),
        meshes = paste(
            "Guangchuang Yu.",
            "Using meshes for MeSH term enrichment and semantic analyses.",
            "Bioinformatics. 2018, 34(21):3766-3767, doi:10.1093/bioinformatics/bty410")        
         )
         
    return(refs)
}


ref2 <- ref_knownledge()

bib_clusterProfiler_innovation2024 <- citEntry(
    entry  ="ARTICLE",
	title = "Thirteen years of clusterProfiler",
	author = c(person("Guangchuang", "Yu")),
	url = "https://doi.org/10.1016/j.xinn.2024.100722",
    doi = "10.1016/j.xinn.2024.100722",
    journal = "The Innovation",
    month = "Nov",
	year = "2024",
    volume  = "5",
    number  = "6",
    pages = "100722",
    textVersion = ref2['clusterProfiler_Innovation2024']
)


bib_clusterProfiler_np2024 <- citEntry(
    entry  ="ARTICLE",
	title = "Using clusterProfiler to characterize multiomics data",
	author = c(
        person("Shuangbin", "Xu"),
        person("Erqiang", "Hu"),
        person("Yantong", "Cai"),
        person("Zijing", "Xie"),
        person("Xiao", "Luo"),
        person("Li", "Zhan"),
        person("Wenli", "Tang"),
        person("Qianwen", "Wang"),
        person("Bingdong", "Liu"),
        person("Rui", "Wang"),
        person("Wenqin", "Xie"),
        person("Tianzhi", "Wu"),
        person("Liwei", "Xie"),
        person("Guangchuang", "Yu")
        ),
    issn = "1750-2799",
	url = "https://www.nature.com/articles/s41596-024-01020-z",
    doi = "10.1038/s41596-024-01020-z",
    journal = "Nature Protocols",
    month = "Nov",
	year = "2024",
    volume  = "19",
    number  = "11",
    pages = "3292-3320",
    textVersion = ref2['clusterProfiler_NP']
)

bib_clusterProfiler_innovation2021 <- citEntry(entry  ="ARTICLE",
         title  = "clusterProfiler 4.0: A universal enrichment tool for interpreting omics data",
         author = c(
             person("Tianzhi", "Wu"),
             person("Erqiang", "Hu"),
             person("Shuangbin", "Xu"),
             person("Meijun", "Chen"),
             person("Pingfan", "Guo"),
             person("Zehan", "Dai"),
             person("Tingze", "Feng"),
             person("Lang", "Zhou"),
             person("Wenli", "Tang"),
             person("Li", "Zhan"),
             person("xiaochong", "Fu"),
             person("Shanshan", "Liu"),
             person("Xiaochen", "Bo"),
             person("Guangchuang", "Yu")
             ),
         journal = "The Innovation",
         year    = "2021",
         volume  = "2",
         number  = "3",
         pages   = "100141",
         PMID    = "",
         doi     = "10.1016/j.xinn.2021.100141",
         textVersion = ref2['clusterProfiler_Innovation']
         )

bib_clusterProfiler_omics2012 <- citEntry(entry  ="ARTICLE",
         title  = "clusterProfiler: an R package for comparing biological themes among gene clusters",
         author = personList(
             as.person("Guangchuang Yu"),
             as.person("Li-Gen Wang"),
             as.person("Yanyan Han"),
             as.person("Qing-Yu He")
             ),
         journal = "OMICS: A Journal of Integrative Biology",
         year    = "2012",
         volume  = "16",
         number  = "5",
         pages   = "284-287",
         PMID    = "22455463",
         doi     = "10.1089/omi.2011.0118",
         textVersion = ref2['clusterProfiler']
         )


bib_meshes_bioinfo2018 <- citEntry(entry  ="ARTICLE",
         title  = "Using meshes for MeSH term enrichment and semantic analyses ",
         author = as.person("Guangchuang Yu"),
         journal = "Bioinformatics",
         year    = "2018",
         volume  = "34",
         number  = "21",
         pages   = "3766-3767",
         PMID    = "29790928",
         doi     = "10.1093/bioinformatics/bty410",
         textVersion = ref2["meshes"]
         )

bib_reactomepa_mbs20016 <- citEntry(entry  = "ARTICLE",
         title  = "ReactomePA: an R/Bioconductor package for reactome pathway analysis and visualization",
         author = c(
             person("Guangchuang", "Yu"),
             person("Qing-Yu", "He")
             ),
         journal = "Molecular BioSystems",
         year    = "2016",
         volume  = "12",
         number  = "12",
         pages   = "477-479",
         PMID    = "26661513",
         url     = "http://pubs.rsc.org/en/Content/ArticleLanding/2015/MB/C5MB00663E",
         doi     = "10.1039/C5MB00663E",
         textVersion = ref2['ReactomePA']
         )

bib_dose_bioinfo2015 <- citEntry(entry  = "ARTICLE",
         title  = "DOSE: an R/Bioconductor package for Disease Ontology Semantic and Enrichment analysis",
         author = c(
             person("Guangchuang", "Yu"),
             person("Li-Gen", "Wang"),
             person("Guang-Rong", "Yan"),
             person("Qing-Yu", "He")
             ),
         journal = "Bioinformatics",
         year    = "2015",
         volume  = "31",
         number  = "4",
         pages   = "608-609",
         PMID    = "",
         url     = "http://bioinformatics.oxfordjournals.org/content/31/4/608",
         doi     = "10.1093/bioinformatics/btu684",
         textVersion = ref2['DOSE']
         )


bib_chipseeker_cp2022 <- citEntry(entry  ="ARTICLE",
         title  = "Exploring epigenomic datasets by ChIPseeker",
         author = c(
             person("Qianwen", "Wang"),
             person("Ming", "Li"),
             person("Tianzhi", "Wu"),
             person("Li", "Zhan"),
             person("Lin", "Li"),
             person("Meijun", "Chen"),
             person("Wenqin", "Xie"),
             person("Zijing", "Xie"),
             person("Erqiang", "Hu"),
             person("Shuangbin", "Xu"),
             person("Guangchuang", "Yu", email = "guangchuangyu@gmail.com")
             ),
         journal = "Current Protocols",
         year    = "2022",
         volume  = "2",
         number  = "10",
         pages   = "e585",
         PMID    = "36286622",
         doi     = "10.1002/cpz1.585",
         url     = "https://onlinelibrary.wiley.com/share/author/GYJGUBYCTRMYJFN2JFZZ?target=10.1002/cpz1.585",
         textVersion = ref2['ChIPseeker_CP']
         )


bib_chipseeker_bioinfo2015 <- citEntry(entry  ="ARTICLE",
         title  = "ChIPseeker: an R/Bioconductor package for ChIP peak annotation, comparison and visualization",
         author = personList(
             as.person("Guangchuang Yu"),
             as.person("Li-Gen Wang"),
             as.person("Qing-Yu He")
             ),
         journal = "Bioinformatics",
         year    = "2015",
         volume  = "31",
         number  = "14",
         pages   = "2382-2383",
         PMID    = "25765347",
         doi     = "10.1093/bioinformatics/btv145",
         textVersion = ref2['ChIPseeker']
         )


bib_gosemsim_mmb2020 <- citEntry(entry  ="ARTICLE",
         title = "Gene Ontology Semantic Similarity Analysis Using GOSemSim",
         author = person("Guangchuang", "Yu"),
         journal = "Methods in Molecular Biology",
         shortjournal = "Methods Mol. Biol.",
         year = "2020",
         volume = "2117",
         pages = "207-215",
         PMID = "31960380",
         issn = "1940-6029",
         doi = "10.1007/978-1-0716-0301-7_11",
         textVersion = ref2['GOSemSim_MMB']
)

bib_gosemsim_bioinfo2010 <- citEntry(entry  ="ARTICLE",
         title  = "GOSemSim: an R package for measuring semantic similarity among GO terms and gene products",
         author = personList(
             as.person("Guangchuang Yu"),
             as.person("Fei Li"),
             as.person("Yide Qin"),
             as.person("Xiaochen Bo"),
             as.person("Yibo Wu"),
             as.person("Shengqi Wang")
             ),
         journal = "Bioinformatics",
         year    = "2010",
         volume  = "26",
         number  = "7",
         pages   = "976-978",
         PMID    = "20179076",
         doi     = "10.1093/bioinformatics/btq064",
         textVersion = ref2['GOSemSim']
         )


