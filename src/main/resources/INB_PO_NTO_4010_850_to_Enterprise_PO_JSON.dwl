%dw 2.0
output application/json
var poNumber = payload.TransactionSets.v004010."850".Heading."020_BEG".BEG03[0]
---
payload.TransactionSets.v004010."850" map ( v850 , indexOfV850 ) -> {
		PurchaseOrder: {
			POPurpose: if ( v850.Heading."020_BEG".BEG01 == "00" ) "New" else if ( v850.Heading."020_BEG".BEG01 == "01" ) "Cancel" else "Update",
			POType: v850.Heading."020_BEG".BEG02 default "",
			PONumber: v850.Heading."020_BEG".BEG03 default "",
			CustomerId: "A43836686",
			CustomerName: "Ohana Incorporated",
			BuyerName: v850.Heading."060_PER".PER02[0] default "",
			BuyerEmailID: v850.Heading."060_PER".PER04[0] default "",
			PODate: v850.Heading."020_BEG".BEG05 as String default "",
			POLineItems: v850.Detail."010_PO1_Loop" map ( v010PO1Loop , indexOfV010PO1Loop ) -> {
				PurchaseOrderLineId: poNumber ++ "-" ++ indexOfV010PO1Loop,
				LineNum: v010PO1Loop."010_PO1".PO101 default "",
				Quantity: v010PO1Loop."010_PO1".PO102 as String default "",
				UnitPrice: v010PO1Loop."010_PO1".PO104 as String default "",
				ItemDescription: v010PO1Loop."050_PID_Loop"."050_PID".PID05[0] default "",
				SupplierItemNum: v010PO1Loop."010_PO1".PO109 default "",
				POLineLocation: {
					LineLocationId: v010PO1Loop."350_N1_Loop"."350_N1".N104[0] default "",
					ShipToLocation: {
						ShipToLocationCode: v010PO1Loop."350_N1_Loop"."350_N1".N104[0] default "",
						ShipToLocationName: v010PO1Loop."350_N1_Loop"."350_N1".N102[0] default "",
						Address: {
							AddressLine1: v010PO1Loop."350_N1_Loop"."370_N3"[0].N301[0] default "",
							AddressLine2: v010PO1Loop."350_N1_Loop"."370_N3"[0].N302[0] default "",
							City: v010PO1Loop."350_N1_Loop"."380_N4".N401[0] default "",
							PostalCode: v010PO1Loop."350_N1_Loop"."380_N4".N403[0] default "",
							State: v010PO1Loop."350_N1_Loop"."380_N4".N402[0] default "",
							Country: v010PO1Loop."350_N1_Loop"."380_N4".N404[0] default ""
						}
					}
				}
			}
		}
	}