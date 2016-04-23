Markov Word Predictor
========================================================
author: Eduardo Rodríguez
date: April 22, 2016
font-import: http://fonts.googleapis.com/css?family=Roboto
font-family: 'Roboto'

Word Prediction
========================================================

- When you enter text on your smartphone, it offers you several alternatives
  for the next word you might want to type.
- Your keyboard app compares the words you have written
  with those in a text database, and searches for the next most likely word.
- This is called an "[n-gram](https://en.wikipedia.org/wiki/N-gram)
  model," where n refers to the number of words
  used to predict the next one.
- We have built an n-gram model as an n-th order Markov chain,
  a process that undergoes transitions from one state to another
  with a given probability.

The Shiny App
========================================================

<img class="center" src="shinyapp-screenshot.png" height=200>

[Shiny app](https://nemarona.shinyapps.io/Markov_Word_Predictor/)
hosted on the Shiny Apps server.  
Clean and simple interface:

1. Type some words
2. Hit Predict button
3. Get a prediction for the next word

The Model
========================================================

- Our model is an $n$-th order Markov chain, as suggested by
  [Ching et al. (2004)](http://dx.doi.org/10.1002/nav.20017).
- The state of the system at time $t$ depends on the $n$ previous states,
  $X_{t} = \sum_{k=1}^{n} \lambda_{k} X_{t-k} Q_{k}$.
- Here, $Q_{k}$ is a $k$-th order transition matrix,
  and $\lambda_{k}$ are (positive) coefficients subject to
  $\lambda_{1} + \cdots + \lambda_{n} = 1$.
- The $\lambda$-coefficients are computed by minimizing
  $\left\lVert \sum_{k=1}^{n} \lambda_{k} \hat{X} Q_{k} - \hat{X} \right\rVert$,
  where $\hat{X}$ is the stationary distribution.

Accuracy
========================================================

- Testing against real texts yields 12% accuracy.
- Model size (25,000 words, 2nd order Markov chain)
  was limited by available computing power.
- A larger model would likely perform better,
  although size may be limited by speed concerns.
- Instead of relying on a "Predict" button,
  predict-as-you-type, [SwiftKey](https://swiftkey.com/)-style,
  should be faster and more accurate.
- A future model must be able to _learn_ from the user.





