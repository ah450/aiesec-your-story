angular.module 'aiesec'
  .factory 'stateToMapCoord', ->
    lookupTable =
      China:
        x: 6220
        y: 2000
        radius: 140
      Japan:
        x: 7135
        y: 1750
        radius: 10
      Thailand:
        x: 6397
        y: 2274
        radius: 25
      "United States":
        x: 1887
        y: 1747
        radius: 300
      India:
        x: 5877
        y: 2148
        radius: 20
      Malysia:
        x: 6537
        y: 2533
        radius: 5
      "Republic of Korea":
        x: 6904
        y: 1753
        radius: 5
      "Hong Kong":
        x: 6653
        y: 2124
        radius: 1
      Taiwan:
        x: 6803
        y: 2088
        radius: 2.5
      Philippines:
        x: 6873
        y: 2347
        radius: 15
      Australia:
        x: 7096
        y: 3194
        radius: 40
      Vietnam:
        x: 6551
        y: 2319
        radius: 5
      Russia:
        x: 5877
        y: 912
        radius: 30
      France:
        x: 4139
        y: 1850
        radius: 20
      Germany:
        x: 4298
        y: 1466
        radius: 20
      Israel:
        x: 4861
        y: 1940
        radius: 2
      Sweden:
        x: 4396
        y: 1078
        radius: 10
      Italy:
        x: 4362
        y: 1686
        radius: 5
      Netherlands:
        x: 4199
        y: 1438
        radius: 5
      Greece:
        x: 4559
        y: 1772
        radius: 5
      Spain:
        x: 4030
        y: 1940
        radius: 10
      Austria:
        x: 4390
        y: 1564
        radius: 5
      "United Kingdom":
        x: 4059
        y: 1417
        radius: 15
      Belgium:
        x: 4182
        y: 1478
        radius: 5
      "United Arab Emirates":
        x: 5298
        y: 2111
        radius: 3
      Kazakhstan:
        x: 5460
        y: 1507
        radius: 40
      Portugal:
        x: 3917
        y: 1761
        radius: 2.5
      "Saudi Arabia":
        x: 5081
        y: 2099
        radius: 10
      Denmark:
        x: 4281
        y: 1342
        radius: 5
      Slovenia:
        x: 4395
        y: 1593
        radius: 1.5
      Iran:
        x: 5283
        y: 1893
        radius: 15
      Norway:
        x: 4251
        y: 1174
        radius: 5
      Mexico:
        x: 1815
        y: 2079
        radius: 15
      Canada:
        x: 2000
        y: 1022
        radius: 30
      Syria:
        x: 4924
        y: 1874
        radius: 5
      Ukraine:
        x: 4704
        y: 1500
        radius: 10
      Cyprus:
        x: 4814
        y: 1862
        radius: 1.5
      "Czech Republic":
        x: 4418
        y: 1508
        radius: 2
      Switzerland:
        x: 4266
        y: 1581
        radius: 2
      Iraq:
        x: 5036
        y: 1902
        radius: 5
      Turkey:
        x: 4834
        y: 1766
        radius: 10
      Romania:
        x: 4606
        y: 1604
        radius: 10
      Lebanon:
        x: 4878
        y: 1886
        radius: 1
      Hungary:
        x: 4490
        y: 1570
        radius: 2.5
      Georgia:
        x: 5005
        y: 1681
        radius: 5
      Brazil:
        x: 2978
        y: 2812
        radius: 10
      Azerbaijan:
        x: 5113
        y: 1726
        radius: 5.5
      Palestine:
        x: 4869
        y: 1930
        radius: 1
      "Republic of Lithuania":
        x: 4563
        y: 1342
        radius: 3
      Oman:
        x: 5366
        y: 2169
        radius: 5
      Slovakia:
        x: 4489
        y: 1534
        radius: 2
      Serbia:
        x: 4528
        y: 1652
        radius: 2
      Finland:
        x: 4585
        y: 1097
        radius: 10
      Iceland:
        x: 3758
        y: 1048
        radius: 2
      "Republic of Moldova":
        x: 4691
        y: 1563
        radius: 1.5
      Bulgaria:
        x: 4619
        y: 1682
        radius: 2.5
      Macedonia:
        x: 4558
        y: 1708
        radius: 1.5
      Liechtenstein:
        x: 4277
        y: 1560
        radius: 0.5
      Jersey:
        x: 4054
        y: 1522
        radius: 0.5
      Poland:
        x: 4487
        y: 1428
        radius: 10
      Ireland:
        x: 3937
        y: 1413
        radius: 3
      Croatia:
        x: 4438
        y: 1608
        radius: 0.5
      "Bosnia and Herzegovina":
        x: 4467
        y: 1646
        radius: 2
      Estonia:
        x: 4590
        y: 1248
        radius: 2
      Latvia:
        x: 4581
        y: 1300
        radius: 2
      "Hashemite Kingdom of Jordan":
        x: 4897
        y: 1960
        radius: 1.5
      Kyrgyzstan:
        x: 5769
        y: 1689
        radius: 1.5
      "RÃ©union":
        x: 5337
        y: 3038
        radius: 0.1
      "Isle of Man":
        x: 4001
        y: 1384
        radius: 0.2
      Libya:
        x: 4481
        y: 2031
        radius: 25
      Luxembourg:
        x: 4207
        y: 1505
        radius: 0.1
      Armenia:
        x: 5036
        y: 1720
        radius: 0.5
      "British Virgin Islands":
        x: 2657
        y: 2232
        radius: 0.1
      Yemen:
        x: 5152
        y: 2288
        radius: 5
      Belarus:
        x: 4640
        y: 1394
        radius: 2
      Gibraltar:
        x: 3975
        y: 1844
        radius: 0.1
      Kenya:
        x: 4929
        y: 2583
        radius: 5
      Chile:
        x: 2578
        y: 3159
        radius: 5
      Qatar:
        x: 5234
        y: 2072
        radius: 1
      Kuwait:
        x: 5144
        y: 1986
        radius: 1
      Guadeloupe:
        x: 2733
        y: 2264
        radius: 0.1
      Martinique:
        x: 2732
        y: 2300
        radius: 0.1
      "French Guiana":
        x: 2920
        y: 2523
        radius: 2
      "Dominican Republic":
        x: 2527
        y: 2209
        radius: 2
      Guam:
        x: 7378
        y: 2310
        radius: 2
      "U.S. Virgin Islands":
        x: 2659
        y: 2227
        radius: 1
      "Puerto Rico":
        x: 2613
        y: 2225
        radius: 2
      "Mongolia":
        x: 6284
        y: 1510
        radius: 5
      "New Zealand":
        x: 7810
        y: 3720
        radius: 3
      "Singapore":
        x: 6457
        y: 2575
        radius: 2
      Indonesia:
        x: 6724
        y: 2724
        radius: 10
      Nepal:
        x: 5942
        y: 1996
        radius: 2
      "Papua New Guinea":
        x: 7353
        y: 2723
        radius: 5
      Pakistan:
        x: 5637
        y: 1960
        radius: 5
      Panama:
        x: 2300
        y: 2415
        radius: 2
      "Costa Rica":
        x: 2209
        y: 2384
        radius: 3
      "Peru":
        x: 2426
        y: 2830
        radius: 3
      Belize:
        x: 2113
        y: 2253
        radius: 1
      Nigeria:
        x: 4251
        y: 2438
        radius: 2
      Venezuela:
        x: 2626
        y: 2457
        radius: 5
      Bahamas:
        x: 2380
        y: 2100
        radius: 2
      Morocco:
        x: 3953
        y: 1950
        radius: 3
      Colombia:
        x: 2464
        y: 2512
        radius: 2
      Seychelles:
        x: 5352
        y: 2694
        radius: 0.1
      Barbados:
        x: 2769
        y: 2335
        radius: 0.1
      Egypt:
        x: 4752
        y: 2074
        radius: 40
      Argentina:
        x: 2656
        y: 3426
        radius: 10
      Brunei:
        x: 6702
        y: 2510
        radius: 2
      Bahrain:
        x: 5222
        y: 2045
        radius: 0.1
      Aruba:
        x: 2534
        y: 2345
        radius: 0.1
      "Saint Lucia":
        x: 2738
        y: 2320
        radius: 0.1
      Bangladesh:
        x: 6112
        y: 2092
        radius: 2
      Tokelau:
        x: 268
        y: 3598
        radius: 0.1
      Cambodia:
        x: 6472
        y: 2346
        radius: 2
      Macao:
        x: 6571
        y: 2160
        radius: 1
      Maldives:
        x: 5780
        y: 2528
        radius: 0.1
      




