
library(zoo)
library(tidyverse)
library(lubridate)

tmp_14<-tempfile(fileext=".xlsx")
download.file("https://www.tarimorman.gov.tr/BUGEM/Belgeler/Bitkisel%20%C3%9Cretim/Organik%20Tar%C4%B1m/%C4%B0statistikler/2014/2014%20Organik%20Tar%C4%B1msal%20%C3%9Cretim%20Verileri.xlsx",destfile=tmp_14, mode="wb")
raw_tar_14<-readxl::read_excel(tmp_14,col_names=FALSE,skip=1)
file.remove(tmp_14)

tmp_15<-tempfile(fileext=".xlsx")
download.file("https://www.tarimorman.gov.tr/BUGEM/Belgeler/Bitkisel%20%C3%9Cretim/Organik%20Tar%C4%B1m/%C4%B0statistikler/2015/2015%20Organik%20Tar%C4%B1msal%20%C3%9Cretim%20Verileri.xlsx",destfile=tmp_15, mode="wb")
raw_tar_15<-readxl::read_excel(tmp_15,col_names=FALSE,skip=1)
file.remove(raw_tar_15)

tmp_16<-tempfile(fileext=".xlsx")
download.file("https://www.tarimorman.gov.tr/BUGEM/Belgeler/Bitkisel%20%C3%9Cretim/Organik%20Tar%C4%B1m/%C4%B0statistikler/2016/2016%20Organik%20Tar%C4%B1msal%20%C3%9Cretim%20Verileri.xlsx",destfile=tmp_16, mode="wb")
raw_tar_16<-readxl::read_excel(tmp_16,col_names=FALSE,skip=1)
file.remove(raw_tar_16)

tmp_17<-tempfile(fileext=".xlsx")
download.file("https://www.tarimorman.gov.tr/BUGEM/Belgeler/Bitkisel%20%C3%9Cretim/Organik%20Tar%C4%B1m/%C4%B0statistikler/2017/2017%20Organik%20Tar%C4%B1msal%20%C3%9Cretim%20Verileri%20(005).xlsx",destfile=tmp_17, mode="wb")
raw_tar_17<-readxl::read_excel(tmp_17,col_names=FALSE,skip=1)
file.remove(raw_tar_17)

tmp_18<-tempfile(fileext=".xlsx")
download.file("https://www.tarimorman.gov.tr/BUGEM/Belgeler/Bitkisel%20%C3%9Cretim/Organik%20Tar%C4%B1m/%C4%B0statistikler/2018/2018%20Organik%20Tar%C4%B1msal%20%C3%9Cretim%20Verileri.xlsx",destfile=tmp_18, mode="wb")
raw_tar_18<-readxl::read_excel(tmp_18,col_names=FALSE,skip=1)
file.remove(raw_tar_18)

tar_14<- select(raw_tar_14, 1,2,8)
tar_15<- select(raw_tar_15, 1,2,8)
tar_16<- select(raw_tar_16, 1,2,8)
tar_17<- select(raw_tar_17, 1,2,8)
tar_18<- select(raw_tar_18, 1,2,8)

colnames(tar_14) <- as.character(unlist(tar_14[3,]))
tar_14<- slice(tar_14, 4:2551)
colnames(tar_15) <- as.character(unlist(tar_15[2,]))
tar_15<- slice(tar_15, 3:2402)
colnames(tar_16) <- as.character(unlist(tar_16[1,]))
tar_16<- slice(tar_16, 2:3061)
colnames(tar_17) <- as.character(unlist(tar_17[2,]))
tar_17<- slice(tar_17, 3:2639)
colnames(tar_18) <- as.character(unlist(tar_18[2,]))
tar_18<- slice(tar_18, 3:2852)

tar_14$`Üretim miktarı (ton) Toplamı`[is.na(tar_14$`Üretim miktarı (ton) Toplamı`)] <- 0
tar_15$`Üretim miktarı (ton) Toplamı`[is.na(tar_15$`Üretim miktarı (ton) Toplamı`)] <- 0
tar_16$`Üretim miktarı (ton) Toplamı`[is.na(tar_16$`Üretim miktarı (ton) Toplamı`)] <- 0
tar_17$`Üretim miktarı (ton) Toplamı`[is.na(tar_17$`Üretim miktarı (ton) Toplamı`)] <- 0
tar_18$`Üretim miktarı (ton) Toplamı`[is.na(tar_18$`Üretim miktarı (ton) Toplamı`)] <- 0

tar_14<- na.locf(tar_14, na.rm = TRUE)
tar_15<- na.locf(tar_15, na.rm = TRUE)
tar_16<- na.locf(tar_16, na.rm = TRUE)
tar_17<- na.locf(tar_17, na.rm = TRUE)
tar_18<- na.locf(tar_18, na.rm = TRUE)

tar_14<- tar_14 %>% filter(!str_detect(tar_14$İller, "Toplam"))
tar_15<- tar_15 %>% filter(!str_detect(tar_15$İller, "Toplam"))
tar_16<- tar_16 %>% filter(!str_detect(tar_16$İller, "Toplam"))
tar_17<- tar_17 %>% filter(!str_detect(tar_17$İller, "Toplam"))
tar_18<- tar_18 %>% filter(!str_detect(tar_18$İller, "Toplam"))

head(tar_14)
tail(tar_14)
head(tar_15)
tail(tar_15)
head(tar_16)
tail(tar_16)
tar_16<- tar_16 %>% filter(!str_detect(tar_16$İller, "TOPLAM"))
tail(tar_16)
head(tar_17)
tail(tar_17)
head(tar_18)
tail(tar_18)

tar_14["Yıl"] <- NA
tar_14$Yıl <- "31.12.2014"

tar_15["Yıl"] <- NA
tar_15$Yıl <- "31.12.2015"

tar_16["Yıl"] <- NA
tar_16$Yıl <- "31.12.2016"

tar_17["Yıl"] <- NA
tar_17$Yıl <- "31.12.2017"

tar_18["Yıl"] <- NA
tar_18$Yıl <- "31.12.2018"

colnames(tar_14)[1] <- "İl"
colnames(tar_14)[2] <- "Ürün Adı"
colnames(tar_14)[3] <- "Üretim Miktarı"

colnames(tar_15)[1] <- "İl"
colnames(tar_15)[2] <- "Ürün Adı"
colnames(tar_15)[3] <- "Üretim Miktarı"

colnames(tar_16)[1] <- "İl"
colnames(tar_16)[2] <- "Ürün Adı"
colnames(tar_16)[3] <- "Üretim Miktarı"

colnames(tar_17)[1] <- "İl"
colnames(tar_17)[2] <- "Ürün Adı"
colnames(tar_17)[3] <- "Üretim Miktarı"

colnames(tar_18)[1] <- "İl"
colnames(tar_18)[2] <- "Ürün Adı"
colnames(tar_18)[3] <- "Üretim Miktarı"

data1415<- full_join(tar_14,tar_15)
data141516<- full_join(data1415, tar_16)
data14151617<- full_join(data141516, tar_17)
tar_data<- full_join(data14151617, tar_18)

glimpse(tar_data)
str(tar_data)
tar_data$`Üretim Miktarı` <- as.numeric(tar_data$`Üretim Miktarı`)

glimpse(tar_data)

tar_data$Yıl <- dmy(tar_data$Yıl)
glimpse(tar_data)


to.plain <- function(s) {
  
  # 1 character substitutions
  old1 <- "çğşıüöÇĞŞİÖÜ"
  new1 <- "cgsiuocgsiou"
  s1 <- chartr(old1, new1, s)
  
  # 2 character substitutions
  old2 <- c("œ", "ß", "æ", "ø")
  new2 <- c("oe", "ss", "ae", "oe")
  s2 <- s1
  for(i in seq_along(old2)) s2 <- gsub(old2[i], new2[i], s2, fixed = TRUE)
  
  s2
}

tar_data$İl<- as.vector(sapply(tar_data$İl,to.plain))
tar_data$`Ürün Adı`<- as.vector(sapply(tar_data$`Ürün Adı`,to.plain))

tar_data<-data.frame(lapply(tar_data, function(v) {
  if (is.character(v)) return(tolower(v))
  else return(v)
}))

save(tar_data, file= "tarim_data.RData")


