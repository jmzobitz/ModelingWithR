### Cover art image of unstable spiral

eq_1 <- c( dx ~ x-y, dy~x+y)

phaseplane(eq_1,'x','y') +
  geom_point(data=tibble(x=0,y=0),aes(x=x,y=y),color='red',size=3.5) +
  theme_bw() +
  theme(
    legend.position = "bottom",
    legend.text = element_text(size = 14),
    axis.title = element_blank(),
    axis.text = element_blank()
  )

ggsave('../CRC-220419/cover-art/spiral-v2.pdf',width=5,height=3.5)

phaseplane(eq_1,'x','y') +
   geom_point(data=tibble(x=0,y=0),aes(x=x,y=y),color='red',size=3) +
  theme_bw() +
  theme(
    legend.position = "bottom",
    legend.text = element_text(size = 14),
    axis.title.x = element_text(size = 18),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    axis.title.y = element_text(size = 18)
  )
