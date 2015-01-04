#  Straight from https://github.com/quantopian/zipline/blob/master/README.md

wget https://gist.githubusercontent.com/cw4/27f00395b86d34192ff2/raw/0af5481a749aea352e27f1faa7b0a5ec0aed7838/dual_moving_avg.py

run_algo.py -f dual_moving_avg.py --symbols AAPL --start 2011-1-1 --end 2012-1-1 -o dma.pickle
