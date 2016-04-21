# Some function definitions

### Preprocessing function #####################################################
# text is character vector
# http://stackoverflow.com/questions/8697079/remove-all-punctuation-except-apostrophes-in-r
preProcess <- function(text, rm.sw = FALSE, stem = FALSE) {
    require(tm)
    # Remove all punctuation except apostrophes
    ppt <- gsub("[^[:alnum:][:space:]']", "", text)
    # Convert to lowercase
    ppt <- tolower(ppt)
    # Remove stopwords
    if (rm.sw == TRUE) {
        ppt <- removeWords(ppt, stopwords("english"))
    }
    # Stemming
    if (stem == TRUE) {
        ppt <- stemDocument(ppt, "english")
    }
    # Fix I
    ppt <- gsub("^i ", "I ", ppt)
    ppt <- gsub(" i$", " I", ppt)
    ppt <- gsub(" i ", " I ", ppt)
    ppt <- gsub("i'", "I'", ppt)
    # Eliminate extra whitespace
    ppt <- gsub("[[:space:]]{2,}", " ", ppt)
    # Eliminate leading and trailing whitespace
    ppt <- gsub("^\\s+|\\s+$", "", ppt)
    ppt
}
################################################################################

### Most common word ###########################################################
mcw <- function(word.list, states, Xhat) {
    # If only one word in list, nothing to do
    if (length(word.list) == 1) {
        mcword <- word.list
    }
    else {
        # Determine word popularity
        word.pop <- Xhat[states %in% word.list]
        # Single out most popular word(s)
        mcword <- word.list[which(word.pop == max(word.pop))]
        # If more than one, pick one at random
        if (length(mcword >= 1)) {
            mcword <- sample(mcword, 1)
        }
    }
    mcword
}
################################################################################

### ninvert function ###########################################################
# Grab n last characters from string and return as character vector, inverted
ninvert <- function(n, string) {
    chv <- unlist(strsplit(string, " "))
    len <- length(chv)
    chv[len:(len-n+1)]
}
################################################################################

### Prediction function (n >= 2) ###############################################
# input.words: character(n), last word first
predictMn <- function(input.words, n, m, states, Xhat, lambda, Q, single = FALSE) {
    require(Matrix)
    # Most common word (to use as prediction if input.words not in dictionary)
    pred.word <- states[which(Xhat == max(Xhat))]
    coverage <- sum(input.words %in% states)
    if (coverage != 0) {
        # Get x vectors
        x <- list()
        for (a in 1:n) {
            x[[a]] <- numeric(m)
            if (input.words[a] %in% states) {
                pos <- which(states == input.words[a])
                x[[a]][pos] <- 1
            }
        }
        # Compute model prediction: y = sum(lambda*x*Q)
        y <- numeric(m)
        for (a in 1:n) {
            y <- y + lambda[a] * x[[a]] %*% Q[[a]]
        }
        y <- y[1, ]
        pred.word <- states[which(y == max(y))]
    }
    if (single == TRUE) {
        pred.word <- mcw(pred.word, states, Xhat)
    }
    pred.word
}
################################################################################

###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
###
