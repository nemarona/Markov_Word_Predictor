Markov Word Predictor
========================================================
author: Eduardo Rodríguez
date: April 20, 2016

Word Prediction
========================================================

- When you type text on your smartphone, it offers you several alternatives
  for the next word you might want to type.
- Your keyboard app compares the words you have written
  with those in a text database, and searches for the next most likely word.
- This is called an "n-gram model," where n refers to the number of words
  used to predict the next one.
- We have built an n-gram model as an n-th order Markov chain,
  a process that undergoes transitions from one "state" to another
  with a given probability.
- Our states are all the words known to the app.

The Shiny App
========================================================

<img class="center" src="shinyapp-screenshot.png" height=250>

Shiny app hosted on the Shiny Apps server 
([click here](https://nemarona.shinyapps.io/Markov_Word_Predictor/)).
Clean and simple interface:

1. Type a sentence
2. Hit Submit button
3. Get a prediction for the next word

The Model
========================================================

- Our model is an $n$-th order Markov chain, following the implementation
  suggested by Ching et al. (paper available [here](http://dx.doi.org/10.1002/nav.20017)).
- The state of the system at time $t$ depends on the $n$ previous states,
  $X_{t} = \sum_{k=1}^{n} \lambda_{k} X_{t-k} Q_{k}$.
- Here, $Q_{k}$ is a $k$-th order transition matrix, estimated from the text corpus,
  and $\lambda_{k}$ are (positive) coefficients subject to the restriction
  $\lambda_{1} + \lambda_{2} + \cdots + \lambda_{n} = 1$.
- The $\lambda$-coefficients are computed by solving the following linear programming problem:
  $\min_{\lambda} \left\lVert \sum_{k=1}^{n} \lambda_{k} \hat{X} Q_{k} - \hat{X} \right\rVert$,
  where $\hat{X}$ is the stationary distribution (again, estimated from the text corpus).

Current limitations and future improvements
========================================================

- Testing shows that our model has low accuracy, about 12%.
- Model size (25,000 words, 2nd order Markov chain)
  was limited by available computing power.
- A larger model (more words in vocabulary, 3rd or higher order Markov chain)
  would likely perform better, although size may be limited
  by speed concerns.
- The Shiny app currently requires the user to hit a Submit button.
  An improved version may predict as you type.
- Offer several alternatives for the next word,
  showing each prediction as a button, [SwiftKey](https://swiftkey.com/)-style.
- An improved model must be able to **learn**.





