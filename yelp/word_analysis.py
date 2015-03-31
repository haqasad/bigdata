import re

from mrjob.job import MRJob
from mrjob.protocol import JSONValueProtocol

MINIMUM_OCCURENCES = 100

def avg_and_total(iterable):
    """Compute the average over a numeric iterable."""
    items = 0
    total = 0.0

    for item in iterable:
        total += item
        items += 1

    return total / items, total

class PositiveWords(MRJob):
    """Find the most positive words in the dataset."""

    # The input is the dataset - interpret each line as a single json
    # value (the key will be None)
    INPUT_PROTOCOL = JSONValueProtocol

    def mapper(self, _, data):
        """Walk over reviews, emitting each word and its rating."""
        if data['type'] != 'review':
            return

        # normalize words by lowercasing and dropping non-alpha
        # characters
        norm = lambda word: re.sub('[^a-z]', '', word.lower())
        # only include a word once per-review (which de-emphasizes
        # proper nouns)
        words = set(norm(word) for word in data['text'].split())

        for word in words:
            yield word, data['stars']

    def reducer(self, word, ratings):
        """Emit average star rating, word in a format we can easily
        sort with the unix sort command: 
        [star average * 100, total count], word.
        """
        avg, total = avg_and_total(ratings)

        if total < MINIMUM_OCCURENCES:
            return

        yield (int(avg * 100 + 10000), total), word

if __name__ == "__main__":
    PositiveWords().run()
