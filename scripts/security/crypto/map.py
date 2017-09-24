#!/usr/bin/env python
# -*- coding: utf-8 -*-
import string

original = """
fpiOa ig r VaBinina PiAan nrBa ugaY TjiBrjipt in ZnPpigK rnY UjanOK.hKa nrBa Mrg BdgJ TdTuprj in JKa SC in JKa ciOJdjirn ajr rnY rJ JKa Jujn dV JKa 20JK OanJujt. RJ Krg qaan TdTuprjixaY qt fpiOa in XdnYajprnY, qt maMig erjjdpp. RJ Mrg rpgd TdTuprj in JKa ciOJdjirn ajr Yua Jd hKa sjinOagg fpiOa, r YruPKJaj dV wuaan ciOJdjir. Rn JKa SC, fpiOa LddgaAapJ mdnPMdjJK, YruPKJaj dV hKadYdja LddgaAapJ, Mrg dOOrgidnrppt yndMn rg "sjinOagg fpiOa" in JKa Tjagg rnY ingTijaY r gdnP OrppaY fpiOa Gpua zdMn. Rn jaOanJ tarjg in JKa SC, JKa ArjirnJg fpiOir, fpigdn, rnY r gKdjJ VdjB, fppia, KrAa qaan Bdja TdTuprj nrBag: in 2010, fpigdn Mrg JKa 38JK BdgJ TdTuprj; fpiOir Mrg JKa 220JK BdgJ TdTuprj,rnY fppia Mrg JKa 189JK BdgJ TdTuprj. fpp JKjaa nrBag KrAa BupJiTpa gTappinP ArjirnJg MKiOK rja rpgd Mapp-ugaY. fptggr, JKa 20JK BdgJ TdTuprj in 2010, Brt gdunY piya r ArjirnJ, quJ iJ ig KigJdjiOrppt dV YiVVajanJ djiPin, VjdB JKa VpdMaj fptgguB.
hKa VprP ig gTijiJ{eKrjrOJajUjaNuanOtCJrJigJiOg}.
"""

intab = "rqOYaVPKi***BndTNjgJuAMbtxfGeWZUzIRkHmloDswLChScXFvE"
outtab =  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
transtab = string.maketrans(intab, outtab)

print(original.translate(transtab))
