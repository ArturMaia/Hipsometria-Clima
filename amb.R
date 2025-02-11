library(ggplot2)
library(raster)
library(RColorBrewer)
library(dplyr)
library(rnaturalearth)
library(geodata)
library(elevatr)

#CORES
climacor <- brewer.pal(11, "RdYlBu")
climacor <- colorRampPalette(climacor)(50)
climacor <- rev(climacor)
coresolo <- brewer.pal(11, "BrBG")
coresolo <- colorRampPalette(coresolo)(50)

#arquivo raster
clim<-getData('worldclim', var='bio', res=10)
clima<-clim$bio1/10
terra<-getData('worldclim', var='alt', res=10)

#Area 
br<-read_state(code_state = "all",year = 2010)
cont<-ne_countries(continent  = 'sOUTH AMERICA' , returnclass = 'sf')

#--------------------------------------------------------------------------------
#MUNDIAL
plot(clima,col=climacor,
     legend.width= 1.5,  axis.args=list(cex.axis=0.6),
     legend.args=list(text="Temperatura (B:C)",
     side=3, line=0.5, cex=0.8))+title("MC)dia climC!tica mundial")

plot(terra,col=coresolo,
     legend.width= 1.5,  axis.args=list(cex.axis=0.6),
     legend.args=list(text="Altitude (mt)",
      side=3, line=0.5, cex=0.8))+title('Hipsometria mundial')

#--------------------------------------------------------------------------------
#CONTINENTE CREA
sa<-crop(clima,cont)
cores <- brewer.pal(11, "RdYlBu")
cores <- colorRampPalette(cores)(50)
cores <- rev(cores)
plot(sa,col=cores,
     legend.width= 1.5,  axis.args=list(cex.axis=0.6),
     legend.args=list(text="Temperatura (B:C)",side=3, line=0.5, cex=0.8))+
  plot(cont$geom,add=T)+
  title("MC)dia climC!tica da AmC)rica do Sul")

sam<-crop(terra,cont)
plot(sam,col=coresolo,
     legend.width= 1.5,  axis.args=list(cex.axis=0.6),
     legend.args=list(text="Altitude (mt)",
     side=3, line=0.5, cex=0.8))+
  plot(cont$geom,add=T)+title('Hipsometria da AmC)rica do Sul')

#--------------------------------------------------------------------------
# PAC
recortado<-crop(terra,br)
brasil<-mask(recortado,br)
plot(brasil,col=coresolo,
     legend.width= 1.5,  axis.args=list(cex.axis=0.6),
     legend.args=list(text="Altitude (mt)",side=3, line=0.5, cex=0.8))+
  plot(br$geom,add=T)+
  title('Hipsometria do brasil')

recortado2<-crop(clima,br)
brasil2<-mask(recortado2,br)
plot(brasil2,col=climacor,
     legend.width= 1.5,  axis.args=list(cex.axis=0.6),
     legend.args=list(text="Temperatura (B:C)",side=3, line=0.5, cex=0.8))+
  plot(br$geom,add=T)+
  title('Clima do brasil')
