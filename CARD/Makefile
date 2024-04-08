all: AEAG MAKAHO MAKAHOapp Explore2_diag Explore2_proj
.PHONY: AEAG MAKAHO MAKAHOapp Explore2_diag Explore2_proj

## 1. ________________________________________________________________
AEAG:
	./CARD_parser.R -iow -l AEAG [ QA QMNA VCN10 tDEB_etiage tCEN_etiage ]


## 2. ________________________________________________________________
### 2.1. _____________________________________________________________
MAKAHO:
	./CARD_parser.R -iow -l MAKAHO [ Resume [ QJXA QA VCN10 ] Crue [ QJXA tQJXA fQA10 fQA05 fQA01 ] Crue_Nivale [ dt_BF v_BF tDEB_BF tCEN_BF tFIN_BF ] Moyennes_Eaux [ QA10 QA25 QA50 QA75 QA90 QA ] Étiage [ QNA QMNA VCN10 dt_etiage vDEF_etiage tDEB_etiage tCEN_etiage tFIN_etiage ] ]

### 2.2. _____________________________________________________________
MAKAHOapp:
	./CARD_parser.R -iow -l MAKAHOapp [ Température [ TA TSA_season TMA_month ] Hautes_Eaux [ QJXA tQJXA VCX3 tVCX3 VCX10 tVCX10 Q01A Q05A Q10A fQ01A fQ05A fQ10A dtFlood ] Moyennes_Eaux [ QA Q75A Q50A Q25A QSA_season QMA_month ] Basses_Eaux [ VCN10 tVCN10 QNA QMNA VCN3 VCN30 Q90A Q95A Q99A startLF centerLF endLF dtLF vLF ] Débit_de_Base [ startBF centerBF endBF dtBF vBF ] Précipitations [ RCXA1 RCXA5 dtRA20mm dtRSA20mm_season dtRMA20mm_month dtRA50mm dtRSA50mm_season dtRMA50mm_month RA RSA_season RMA_month RAl RSAl_season RMAl_month RAl_ratio RAs RSAs_season RMAs_month RAs_ratio dtRA01mm dtRSA01mm_season dtRMA01mm_month dtCWDA dtCWDSA_season dtCWDMA_month dtCDDA dtCDDSA_season dtCDDMA_month ] ]              


## 3. ________________________________________________________________
Explore2_diag:
	./CARD_parser.R -iow -t 2 -l Explore2_diag [ criteria [ all [ KGE KGEracine NSE NSEracine NSElog NSEinv Biais Biais_SEA STD Rc epsilon_P epsilon_P,SEA epsilon_T epsilon_T,SEA RAT_T RAT_P RAT_ET0 Q10 QJXA-10 alphaQJXA median{tQJXA} median{dtCrue} Q50 mean{QA} alphaCDC alphaQA Q90 QMNA-5 VCN30-2 VCN10-5 alphaVCN10 median{tVCN10} median{dtRec} BFI BFM ] select [ KGEracine Biais epsilon_T,DJF epsilon_T,JJA epsilon_P,DJF epsilon_P,JJA RAT_T RAT_P Q10 median{tQJXA} alphaCDC alphaQA Q90 median{tVCN10} ] ] serie [ QM RA QA median{QJ} median{QJ}C5 FDC ] ]

Explore2_proj:
	./CARD_parser.R -iow -t 1 -l Explore2_proj [ serie [ QA QA_janv QA_fevr QA_mars QA_avr QA_mai QA_juin QA_juill QA_aout QA_sept QA_oct QA_nov QA_dec QA_DJF QA_MAM QA_JJA QA_SON QA05 QA10 QA50 QA90 QA95 QJXA VCX3 QMNA VCN10 VCN3 ] check [ tQJXA tCEN_etiage_check ] delta [ deltaQA ] ]
