function distance(w1, w2)
    w1 = split(lowercase(w1), "")
    w2 = split(lowercase(w2), "")
    dist = length(w1) > length(w2) ? length(w1) - length(w2) : 0

    while w1 != w2
        if length(w1) - length(w2) == 0
            for i in eachindex(w1)
                if w1[i] != w2[i]
                    dist += 1

                    if i+1 < length(w1) && w1[i+1] == w2[i] && w1[i] == w2[i+1]
                        w1[i], w1[i+1] = w1[i+1], w1[i]
                    else
                        w1[i] = w2[i]
                    end
                end
            end
        else
            last_dist = 2
            w1_new = []

            for i in eachindex(w2)
                if !in(w2[i], w1[1:last_dist])
                    last_dist += 1
                    dist += 1

                    push!(w1_new, w2[i])
                else
                    ind = indexin(w2[i], w1)[1]
                    if ind != 1 && ind !== nothing
                        w1_new = w1_new[1:end-ind]
                        dist -= ind

                        push!(w1_new, w1[1:last_dist])

                        w1 = w1[last_dist:end]
                        last_dist = 1
                    else
                        last_dist = 1

                        push!(w1_new, w1[1])
                        popfirst!(w1)
                    end
                end
                if length(w1_new) == length(w2)
                    w1 = w1_new
                    break
                end
            end
        end
    end
    return dist
end

#=
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
    ## Take the first item, count its following items and their frequencies
    ## assign all of this into a dictionary
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
=#

println(distance("losers","mover")) ## Not working, figure out