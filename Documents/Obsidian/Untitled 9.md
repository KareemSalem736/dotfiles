generate.sh generates from template.json - in dev mode - local dev
Pulls from DIAS in prod
aac just gets the user information, does not hold it. DIAS is only available on JWICS
SIPR does not have DIAS, including the AAC2 connector/abstraction
lums is aac in dev mode
Need to create a connector to connect to aac on SIPR that takes in user information and provides it to aac.
log into aide to reference the dias connector
ENT_COnnect_rul to connect to 
log into aide then gitlab then dias connector under aac-dias-connector project
swagger.yaml under api - model them as java records, java rest , Get request for user, hardcode java list.
swagger.yml is source of truth
csv file may need to be adapted.

glpat-oo_JX-zEgHtqal7l3PDj5G86MQp1OjN2CA.01.0y0hlo7kz