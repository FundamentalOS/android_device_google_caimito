#!/system/bin/sh
# FundamentalOS (caimito): force 5G NSA+SA for all carriers.
# Google's per-carrier configs (e.g. chinamobile_cn) restrict carrier_nr_availabilities to
# NSA-only ([1]); China Mobile and others run 5G SA, so SA never engages -> LTE only.
# Override it to [1,2] (NSA+SA) via the persistent carrier-config override layer, which is
# merged AFTER the carrier-app config (wins over it) and keeps every other key intact.
# `cmd phone cc` needs ROOT_UID (this service runs as root); -p persists + is restored by
# CarrierConfigLoader on every config reload.
i=0
while [ $i -lt 40 ]; do
    case "$(getprop gsm.sim.state)" in *LOADED*) break;; esac
    sleep 2; i=$((i+1))
done
for slot in 0 1 2; do
    cmd phone cc set-value -s "$slot" -p carrier_nr_availabilities_int_array 1 2 2>/dev/null
done
