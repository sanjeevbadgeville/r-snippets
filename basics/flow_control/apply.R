# lapply vs apply
dfs <- list(Ing_Ply_Cnt_Nov, Ing_Ply_Cnt_Dec, Ing_Ply_Cnt_Jan, Ing_Ply_Cnt_Feb)
lapply(dfs, function(x) {
  class(x)
})
for (j in dfs) 
{
  str(j)
  for (i in c(3:17)) 
  {
    j[,i] <- as.numeric(as.character(j[,i]))
  }
}
colsToConvertFactorsToNumeric <- c(3:17)
Ing_Ply_Cnt_Nov [,colsToConvertFactorsToNumeric] <- apply(Ing_Ply_Cnt_Nov[,colsToConvertFactorsToNumeric], 2, function(x) as.numeric(as.character(x)))
