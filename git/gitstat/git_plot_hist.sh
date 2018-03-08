#!/bin/bash
gnuplot<<EOF
set terminal png truecolor
set output "$1.png"
set grid
set xtic rotate by 90
set style data histograms
set style fill solid 1.00 border -1
plot "plot_data.txt" using 2:xtic(1) title "mgzf-arch", '' using 3 title "mgzf-cust", '' using 4 title "mgzf-fina",'' using 5 title "mgzf-flat",'' using 6 title "mgzf-sale",'' using 7 title "mgzf-supp", '' using 8 title "mgzf-tp"
EOF
