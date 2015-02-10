hadoop/bin/hadoop  jar ./hadoop-streaming-2.6.0.jar \
    -input input/stream1 \
    -output output/stream1 \
    -mapper /bin/cat \
    -reducer /usr/bin/wc

