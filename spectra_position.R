
# <script src="https://gist.github.com/mzarowka/cd0f581839c2f23af4084d76ee1307c5.js"></script>
#   Find spectra positions and get the index values
# spectra-position.R
# Using purrr 1.0: equals to ~ which.min(abs(.x...)

spectra_position <- function(raster, spectra) {
  # Find index (position) of selected spectra by comparing choice and names
  spectraIndex <- purrr::map(spectra, \(x) which.min(abs(x - zzz))) |>
    # Get positions
    purrr::as_vector()

  # Create tibble with spectra of choice and respective position
  spectraIndex <- dplyr::tibble(
    spectra = spectra,
    position = spectraIndex) |>
    # Group by position
    dplyr::group_by(position) |>
    # Keep second observation if duplicates are present - this needs to be actually adressed somehow?
    # From experience closer to desired product
    dplyr::slice_tail()

  # Return values
  return(spectraIndex)
}

# Examples
spectra <- c(550, 570, 590, 615, 630, 649:701, 730, 790, 845, 900)

# This actually is result of: names(raster) argument in the function
raster_names <- c(395.50, 397.00, 398.49, 399.99, 401.49, 402.99, 404.48, 405.98, 407.48, 408.98, 410.48, 411.98, 413.48, 414.98, 416.49, 417.99, 419.49, 420.99, 422.49, 424.00, 425.50, 427.01, 428.51, 430.02, 431.52, 433.03, 434.53, 436.04, 437.55, 439.05, 440.56, 442.07, 443.58, 445.08, 446.59, 448.10, 449.61, 451.12, 452.63, 454.14, 455.66, 457.17, 458.68, 460.19, 461.70, 463.22, 464.73, 466.24, 467.76, 469.27, 470.79, 472.30, 473.82, 475.34, 476.85, 478.37, 479.89, 481.40, 482.92, 484.44, 485.96, 487.48, 489.00, 490.52, 492.04, 493.56, 495.08, 496.60, 498.12, 499.65, 501.17, 502.69, 504.21, 505.74, 507.26, 508.79, 510.31, 511.84, 513.36, 514.89, 516.42, 517.94, 519.47, 521.00, 522.52, 524.05, 525.58, 527.11, 528.64, 530.17, 531.70, 533.23, 534.76, 536.29, 537.82, 539.36, 540.89, 542.42, 543.95, 545.49, 547.02, 548.56, 550.09, 551.63, 553.16, 554.70, 556.23, 557.77, 559.31, 560.84, 562.38, 563.92, 565.46, 567.00, 568.54, 570.08, 571.62, 573.16, 574.70, 576.24, 577.78, 579.32, 580.86, 582.41, 583.95, 585.49, 587.04, 588.58, 590.12, 591.67, 593.21, 594.76, 596.31, 597.85, 599.40, 600.95, 602.49, 604.04, 605.59, 607.14, 608.69, 610.24, 611.79, 613.34, 614.89, 616.44, 617.99, 619.54, 621.09, 622.65, 624.20, 625.75, 627.31, 628.86, 630.41, 631.97, 633.52, 635.08, 636.64, 638.19, 639.75, 641.31, 642.86, 644.42, 645.98, 647.54, 649.10, 650.65, 652.21, 653.77, 655.33, 656.90, 658.46, 660.02, 661.58, 663.14, 664.70, 666.27, 667.83, 669.40, 670.96, 672.52, 674.09, 675.65, 677.22, 678.79, 680.35, 681.92, 683.49, 685.05, 686.62, 688.19, 689.76, 691.33, 692.90, 694.47, 696.04, 697.61, 699.18, 700.75, 702.32, 703.89, 705.47, 707.04, 708.61, 710.19, 711.76, 713.33, 714.91, 716.48, 718.06, 719.63, 721.21, 722.79, 724.36, 725.94, 727.52, 729.10, 730.68, 732.26, 733.83, 735.41, 736.99, 738.57, 740.16, 741.74, 743.32, 744.90, 746.48, 748.06, 749.65, 751.23, 752.82, 754.40, 755.98, 757.57, 759.15, 760.74, 762.33, 763.91, 765.50, 767.09, 768.67, 770.26, 771.85, 773.44, 775.03, 776.62, 778.21, 779.80, 781.39, 782.98, 784.57, 786.16, 787.75, 789.35, 790.94, 792.53, 794.13, 795.72, 797.31, 798.91, 800.50, 802.10, 803.70, 805.29, 806.89, 808.49, 810.08, 811.68, 813.28, 814.88, 816.48, 818.08, 819.68, 821.28, 822.88, 824.48, 826.08, 827.68, 829.28, 830.88, 832.49, 834.09, 835.69, 837.30, 838.90, 840.51, 842.11, 843.72, 845.32, 846.93, 848.53, 850.14, 851.75, 853.36, 854.96, 856.57, 858.18, 859.79, 861.40, 863.01, 864.62, 866.23, 867.84, 869.45, 871.06, 872.68, 874.29, 875.90, 877.51, 879.13, 880.74, 882.36, 883.97, 885.59, 887.20, 888.82, 890.43, 892.05, 893.67, 895.28, 896.90, 898.52, 900.14, 901.76, 903.38, 905.00, 906.62, 908.24, 909.86, 911.48, 913.10, 914.72, 916.35, 917.97, 919.59, 921.21, 922.84, 924.46, 926.09, 927.71, 929.34, 930.96, 932.59, 934.22, 935.84, 937.47, 939.10, 940.73, 942.35, 943.98, 945.61, 947.24, 948.87, 950.50, 952.13, 953.76, 955.39, 957.03, 958.66, 960.29, 961.92, 963.56, 965.19, 966.82, 968.46, 970.09, 971.73, 973.36, 975.00, 976.64, 978.27, 979.91, 981.55, 983.19, 984.82, 986.46, 988.10, 989.74, 991.38, 993.02, 994.66, 996.30, 997.94, 999.58, 1001.23, 1002.87, 1004.51, 1006.15, 1007.80, 1009.44)
zzz <- raster_names


time1 <- Sys.time()

for (i in 1:10000){
  spectraIndex <- purrr::map(spectra, \(x) which.min(abs(x - zzz))) |>
    # Get positions
    purrr::as_vector()

  # Create tibble with spectra of choice and respective position
  spectraIndex <- dplyr::tibble(
    spectra = spectra,
    position = spectraIndex) |>
    # Group by position
    dplyr::group_by(position) |>
    # Keep second observation if duplicates are present - this needs to be actually adressed somehow?
    # From experience closer to desired product
    dplyr::slice_tail()
}

print(Sys.time() - time1)











