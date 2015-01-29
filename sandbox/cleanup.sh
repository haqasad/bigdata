cat alice.txt | tr A-Z a-z | tr -cd "a-z\n\t " >alice.words.txt
