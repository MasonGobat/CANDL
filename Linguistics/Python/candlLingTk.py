def distance(w1, w2):
    w1 = list(w1.lower())
    w2 = list(w2.lower())
    dist = len(w1) - len(w2) if len(w1) > len(w2) else 0 ## The minimum possible distance between the two words...sorta

    if len(w1) == 0 or len(w2) == 0:
        return abs(len(w1) - len(w2))
    
    while w1 != w2:
        if len(w1) == len(w2): ## Sub or transpose
            for i in range(len(w1)):
                if w1[i] != w2[i]:
                    dist += 1

                    if i+1 < len(w1) and w1[i+1] == w2[i] and w1[i] == w2[i+1]:
                        w1[i], w1[i+1] = w1[i+1], w1[i]
                    else:
                        w1[i] = w2[i]
        else: ## add or delete
            last_dist = 1
            w1_new = []

            for i in range(len(w2)):
                if w2[i] not in w1[:last_dist]:
                    last_dist += 1
                    dist += 1

                    w1_new.append(w2[i])
                else:
                    ind = w1.index(w2[i])

                    if ind != 0:
                        w1_new = w1_new[:-ind]
                        dist -= ind

                        w1_new.extend(w1[:last_dist])

                        w1 = w1[last_dist:]
                        last_dist = 1
                    else:
                        last_dist = 1

                        w1_new.append(w1[0])
                        w1.pop(0)
                if len(w1_new) == len(w2):
                    w1 = w1_new
                    break

    return(dist)

def ngram(corp, n=2):
    new_gram = []
    for i in range(len(corp)):
        temp_gram = []
        if i + n > len(corp):
            break
        for j in range(n):
            temp_gram.extend([corp[i + j]])
        new_gram.append(temp_gram)
    return new_gram if len(new_gram) > 1 else corp

def freqDict(ngram):
    freqDict = {}

    for (k, v) in ngram:
        if k in freqDict and v in freqDict[k]:
            freqDict[k][v] += 1
        elif k in freqDict:
            freqDict[k][v] = 1
        else:
            freqDict[k] = {}
            freqDict[k][v] = 1
    return freqDict

print(distance("mover", "losers"))