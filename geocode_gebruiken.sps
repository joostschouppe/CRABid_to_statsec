
* OPEN JE DATA.
DATASET NAME werkbestand WINDOW=FRONT.

sort cases CRAB_HUISNUMMER_ID (a).
compute geocode_huisnrid = CRAB_HUISNUMMER_ID.

* voeg toe op basis van huisnummerid.
GET
  FILE='C:\Users\plu3532\Documents\crab\verwerkt\koppel_statsec.sav'.
DATASET NAME crabid WINDOW=FRONT.

dataset activate werkbestand.
MATCH FILES /FILE=*
  /TABLE='crabid'
  /BY geocode_huisnrid.
EXECUTE.
dataset close crabid.

* voeg toe op basis van straatnaamid.
dataset activate werkbestand.
compute streetcode_straatnaam_id=CRAB_STRAAT_ID.
sort cases streetcode_straatnaam_id (a).
GET
  FILE='C:\Users\plu3532\Documents\crab\verwerkt\koppel_statsec_op_straatnaam.sav'.
DATASET NAME crabid WINDOW=FRONT.

dataset activate werkbestand.
MATCH FILES /FILE=*
  /TABLE='crabid'
  /BY streetcode_straatnaam_id.
EXECUTE.
dataset close crabid.

string statsec (a9).
compute statsec=geocode_statsec_clean.
if geocode_statsec_clean="" & streetcode_straatnaam_correctheid>0.975 statsec=streetcode_statsec_clean.
EXECUTE.
