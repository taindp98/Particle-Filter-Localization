# Particle Filter on Localisation

PF is a technique for implementing recursive Bayesian Filter by Monte Carlo sampling.
The idea to represent th posterior density by a set of random particles with associated weights.
PF compute estimates based on these samples and weights.

## Mathematical Background:
+ Sampling from the proposal and not the posterior for estimation.
+ To take into account that we will be sampling from wrong distribution, the samples have to be likelihood weight by ratio of posterior and proposal distribution.
+ Thus, weight of PF should be changed depending on observation for current frame.

## Paricle Filter Algorithm:
+ We can use a different distribution g to generate samples from f
+ Account for the differences between g and f using a weight w=f/g
+ Target f
+ Proposal g
