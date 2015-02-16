hadoop/bin/hadoop  jar ./hadoop-streaming-2.6.0.jar \
    -input input2 \
    -output output2 \
    -mapper ./mapper.books.py \
    -reducer ./reducer.books.py

