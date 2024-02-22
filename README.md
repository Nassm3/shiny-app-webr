This ReadMe is about the shiny network shared by link.

# What's inside the link ? 
the link points to a serverless shiny spps with webR, specifically an html page hosted by netlify which contains a js script that executes webr.

# Shiny app
The shiny applications used in this script take as input 2 datasets, edge.csv and node.csv, which are used to build the networks. 
Each DIABLO model has its own edge.csv and node.csv. The shiny networks link the model variables (metabolite and transcript) according to their correlation. It is important to note that all model components are used.

# How it works ??

WebR is a version of the R interpreter compiled for WebAssembly that runs directly on the user's machine, allowing the power of R to be used in a web browser with no additional effort. Only three components are required to run a serverless Shiny application: 

 * HTML to insert into your webpage
 * A Service Worker script
 * The app.R script


Hosting is provided by Netlify, a static site host. It is possible to deploy a site on Netlify from a GitHub repo. It reads a Netlify.toml configuration file, the index.html file, which runs the shiny.js JavaScript script that runs WebR. See https://github.com/georgestagg/shiny-standalone-webr-demo for more details.

# How to deploy the site ?
The git used to build the site is https://github.com/Nassm3/shiny-app-webr. It contains several subdirectories, one for each shiny application. 
So, to deploy the site from rmd, you first need to:

1. clone the GitHub repositorie: https://github.com/Nassm3/shiny-app-webr at the same level as the colocation project
2. Knit the script, taking care to remove the comments from the code used to write the input data for the Shiny applications specific to each model in the local git repository. The corresponding lines for model X (example) are :

`# write.table(matrix$node, "../../../../../shiny-app-webr/X/app/node.csv", quote = FALSE)`

`# write.table(matrix$edge, "../../../../../shiny-app-webr/X/app/edge.csv", quote = FALSE)`

3. push changes in the Git repo
4. create a netlify account and build a site from git.

