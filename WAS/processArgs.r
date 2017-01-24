
# Parse the arguments input by the user
# if argument 'test' is used then run test phenome scan
processArgs <- function() {

if (opt$test==TRUE) {

	datadir='../testWAS/data/';
	opt$traitofinterestfile <<- paste(datadir,'exposure.csv', sep="");
	opt$outcomefile <<-  paste(datadir,'phenotypes.csv', sep="");
	opt$variablelistfile <<- '../testWAS/variable-lists/outcome-info.tsv';
	opt$datacodingfile <<- '../testWAS/variable-lists/data-coding-ordinal-info.txt';
	opt$traitofinterest <<- 'exposure';
	opt$resDir <<- '../testWAS/results/';
	opt$userId <<- 'userId';
	opt$sensitivity <<- FALSE;
	opt$genetic <<- TRUE;

	processParts(opt$partIdx, opt$numParts);	
}
else {

	if (is.null(opt$outcomefile)){
	  print_help(opt_parser)
	  stop("outcomefile argument must be supplied", call.=FALSE)
	}
	if (is.null(opt$traitofinterestfile)){
	  print_help(opt_parser)
	  stop("traitofinterestfile argument must be supplied", call.=FALSE)
	}
	if (is.null(opt$variablelistfile)){
	  print_help(opt_parser)
	  stop("variablelistfile argument must be supplied", call.=FALSE)
	}
	if (is.null(opt$datacodingfile)){
	  print_help(opt_parser)
	  stop("datacodingfile argument must be supplied", call.=FALSE)
	}
	if (is.null(opt$traitofinterest)){
	  print_help(opt_parser)
	  stop("traitofinterest argument must be supplied", call.=FALSE)
	}
	if (is.null(opt$resDir)){
	  print_help(opt_parser)
	  stop("resDir argument must be supplied", call.=FALSE)
	}

	processParts(opt$partIdx, opt$numParts);
}
	
# just some information to the user
if (opt$sensitivity==TRUE & opt$genetic==TRUE) {
	print("Adjusting for age, sex, genetic batch, top 10 genetic principal components and assessment centre")
}
else if (opt$sensitivity==FALSE & opt$genetic==TRUE) {
	print("Adjusting for age, sex and genetic batch")
}
else if (opt$sensitivity==TRUE & opt$genetic==FALSE) {
	print("Adjusting for age, sex and assessment centre")
}
else if	(opt$sensitivity==FALSE & opt$genetic==FALSE) {
        print("Adjusting for age and sex")
}

}

# Parse the 'part' arguments and check they are valid
processParts <- function(pIdx, nParts) {

	if (is.null(pIdx) && is.null(nParts)) {
                opt$varTypeArg <<- "all";
		print(paste("Running with all traits in phenotype file:", opt$outcomefile));
        }
	else if (is.null(pIdx)) {
                print_help(opt_parser)
                stop("pIdx argument must be supplied when nParts argument is supplied", call.=FALSE)
        }
	else if (is.null(nParts)) {
                print_help(opt_parser)
                stop("nParts argument must be supplied when pIdx argument is supplied", call.=FALSE)
        }
	else if (pIdx<1 || pIdx>nParts) {
		print_help(opt_parser)
                stop("pIdx arguments must be between 1 and nParts inclusive", call.=FALSE)
	}
	else {
                opt$varTypeArg <<- paste(pIdx, "-", nParts, sep="");
        	print(paste("Running with part",pIdx,"of",nParts," in phenotype file:", opt$outcomefile));
	}

}
