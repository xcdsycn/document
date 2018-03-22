#!/bin/bash
gnuplot<<EOF
set terminal png truecolor
set output "$1.png"
set grid
set xtic rotate by 90
set style data histograms
set style fill solid 1.00 border -1
plot "plot_data.txt" using 2:xtic(1) title "a-arch", '' using 3 title "a-cust", '' using 4 title "a-fina",'' using 5 title "a-flat",'' using 6 title "a-sale",'' using 7 title "a-supp", '' using 8 title "a-tp"
EOF
