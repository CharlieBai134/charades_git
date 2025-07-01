library(ggplot2)
library(xlsx)
library(ggrain)
library(ggsignif)
library(egg)
library(grid)
library(eoffice)
setwd("C:/Users/baich/Desktop/21心健白昌林/fNIRS_亲子项目初期准备/结果图表/图/fig0行为结果")
dataFig1 <- read.xlsx("fig0行为结果.xlsx",1)
#####parent guess#####
behav_pG <- ggplot(dataFig1,aes(x=factor(condition,levels = c("independent","collaborative")),
                             y=correct_n_pG,
                             fill=group,
                             colour = group))+
  geom_rain(alpha = .5, rain.side = 'l',
            boxplot.args = list(color = "black", outlier.shape = NA),
            boxplot.args.pos = list(
              position = ggpp::position_dodgenudge(x = -.12), width = 0.5),
            point.args = rlang::list2(alpha = 0))+
  theme_bw()+
  theme(panel.grid=element_blank())+
  scale_y_continuous(limits = c(0,25))+
  theme(axis.title.x =element_text(size=16), axis.title.y=element_text(size=16),
        axis.text = element_text(size = 14),
        legend.title = element_text(size=16),legend.text = element_text(size=14))+
  scale_colour_manual(values = c("#F7685D","#10CF9B"))+
  scale_fill_manual(values = c("#F7685D","#10CF9B"))+
  facet_wrap(~ word, nrow = 1)
behav_pG
topptx(behav_pG, filename = 'behav_pG.pptx', width = 10, height = 7)

#####adolescent guess#####
behav_aG <- ggplot(dataFig1,aes(x=factor(condition,levels = c("independent","collaborative")),
                                y=correct_n_aG,
                                fill=group,
                                colour = group))+
  geom_rain(alpha = .5, rain.side = 'l',
            boxplot.args = list(color = "black", outlier.shape = NA),
            boxplot.args.pos = list(
              position = ggpp::position_dodgenudge(x = -.12), width = 0.5),
            point.args = rlang::list2(alpha = 0))+
  theme_bw()+
  theme(panel.grid=element_blank())+
  scale_y_continuous(limits = c(0,25))+
  theme(axis.title.x =element_text(size=16), axis.title.y=element_text(size=16),
        axis.text = element_text(size = 14),
        legend.title = element_text(size=16),legend.text = element_text(size=14))+
  scale_colour_manual(values = c("#F7685D","#10CF9B"))+
  scale_fill_manual(values = c("#F7685D","#10CF9B"))+
  facet_wrap(~ word, nrow = 1)
behav_aG
topptx(behav_aG, filename = 'behav_aG.pptx', width = 10, height = 7)



## ggplot_build(P2)$data, 查看作图的信息，如颜色
#geom_signif(annotations = c("NS.", "**","NS.","NS.")
 #           ,y_position = c(25, 25,25,25)
  #          ,xmin = c(1,2,3,4)
   #         ,xmax = c(1.3, 2.3,3.3, 4.3)
    #        ,color="black")
