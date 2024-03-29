# 10/29/2016. Author: Manu Garcia-Quismondo


get.mean.auc.values = function(model.name, selected.subtable) {
    score.data = c()
    auc.data = c()
    prediction.table = selected.subtable
    possible.iterations = unique(selected.subtable$Iteration)
    if (nrow(prediction.table) > 0) {
        for (iteration in possible.iterations) {
            iteration.subtable = subset(prediction.table, Iteration == iteration)
            if (nrow(iteration.subtable) > 2) {
                class.subset = iteration.subtable[, "TrueClass"]
                if (length(unique(class.subset)) > 1) {
                    score.data = iteration.subtable[, "Score"]
                    if(any( score.data > 0)){
                        auc.data = c(auc.data, roc(as.numeric(as.factor(class.subset)), score.data, na.rm = T)$auc)
                    }
                }
            }
        }
    }
    setwd(source.route)
    mean(auc.data)
}