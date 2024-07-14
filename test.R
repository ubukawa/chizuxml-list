library("dplyr") #データベースの操作をするためのパッケージ（filterなど）
#library("stringr") #文字列処理のパッケージ

# 読み込み
list2022 <- read.csv("2022.csv",header=FALSE,colClasses=rep("character",1),fileEncoding = "utf16")
list2023 <- read.csv("2023.csv",header=FALSE,colClasses=rep("character",1),fileEncoding = "utf16")
list2024 <- read.csv("2024.csv",header=FALSE,colClasses=rep("character",1),fileEncoding = "utf16")
shikuchoson <- read.csv("shikuchoson.csv",header=FALSE,colClasses=rep("character",2),fileEncoding = "utf8")

# 年度の付与
list2022[,2] <- 2022
list2023[,2] <- 2023
list2024[,2] <- 2024

# 市区町村ー法務局コードの抜き出し
list2022[,3] <- substr(list2022[,1],1,10)
list2023[,3] <- substr(list2023[,1],1,10)
list2024[,3] <- substr(list2024[,1],1,10)

# チェック
nrow(list2022) #2070
nrow(list2023) #2005
nrow(list2024) #2010

# 必要な情報だけに
list2022r <- select(list2022,3,2)
list2023r <- select(list2023,3,2)
list2024r <- select(list2024,3,2)

# テーブル結合
list1 <- full_join(list2022r,list2023r,by="V3")
list2 <- full_join(list1,list2024r,by="V3")

# 市区町村コードだけ抜き出し
list2[,5] <- substr(list2[,1],1,5)
list2[,5] <- as.character(list2[,5])

#市区町村追加
shikuchoson[,3] <-substr(shikuchoson[,1],1,5)
list3 <- left_join(list2,shikuchoson,by= c("V5"="V3"))


write.csv(list3,"list-utf8.csv",fileEncoding = "UTF8")
write.csv(list3,"list-sjis.csv",fileEncoding = "cp932")
