 Modified Nested Inequalities Climate-Economy (NICE) model

This repository contains source code for a modified version the NICE model. The modification is:

- solver algorithm has been modified by scaling the objective function and allowing for a different solver

# Original NICE model

The NICE model has been published in *Inequality, climate impacts on the future poor, and carbon prices, (Dennig et al., PNAS, 2015)*. The model is a modification of the RICE model by William Nordhaus and his collaborators, designed to analyse climate policy questions arising from socio-economic inequality within regions. It is written in the MATLAB programming language. See Dennig et al., PNAS, 2015 for a model description.

The original NICE model code can be found here https://github.com/Environment-Research/NICE-MATLAB. 

The re-use and modification of the original NICE model is permitted under the license found at the end of this file.

# Running the modified NICE version

Running the model requires MATLAB. Within that software, ensure that all of the files contained in this repository are included in the *path*. 

Executing the file NICE_optimisation.m replicates the original NICE model version, only subject to changes in the solver algorithm to guarantee convergence. 


The results are saved to a variable called "results". 

Essentially any parameter of the model can be chosen to alter the instance of the model being run. A number of parameters relating to the distribution of damages and mitigation cost at a sub-regional level - the original focus of the model developers - are listed in the interface files and easily changed. 

For the JEEM Publication, the following variables were varied to derive the results of the paper:
- rhov: the rate of pure time preference
- etav: the elasticity of marginal felicity
- xiv: the income elasticity of damages

# Issues 

If you encounter any issues operating the modified model, or require assistance identifying a problem or implementing a change, please contact Ulrike Kornek at kornek@mcc-berlin.net

For questions concerning the original NICE model, please contact Francis Dennig at fdennig@yale-nus.edu.sg
