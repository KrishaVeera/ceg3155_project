library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ReceiverController is
 Port (
    Greset, CLK: in std_logic;
    RxD, RDRF: in std_logic;
    RSRload, RSRshiftR: out std_logic;
    RDRload: out std_logic;
    RDRFload, RDRFin: out std_logic;
    FEload, FEin: out std_logic;
    OEload, OEin: out std_logic
 );
end ReceiverController;

architecture struct of ReceiverController is
    signal CLKCTRload, CLKCTRinc, CLKCTRSEL, SCTRload, SCTRinc: std_logic;
    signal CLKCTRout, SCTRout: std_logic;
    signal Y10_i, Y9_i, Y8_i, Y7_i, Y6_i, Y5_i, Y4_i, Y3_i, Y2_i, Y1_i, Y0_i: std_logic;
    signal y10, y9, y8, y7, y6, y5, y4, y3, y2, y1, y0: std_logic;
    signal y10Bar, y9Bar, y8Bar, y7Bar, y6Bar, y5Bar, y4Bar, y3Bar, y2Bar, y1Bar, y0Bar: std_logic;
    signal resetcondition: std_logic;
begin

    resetcondition <= (y10Bar and y9Bar and y8Bar and y7Bar and y6Bar and y5Bar and y4Bar and y3Bar and y2Bar and y1Bar and y0Bar);

    Y10_i <= (y8 or y9);
    Y9_i <= (y5 and not RxD);
    Y8_i <= (y7 and (RDRF and not RxD));
    Y7_i <= (y6) or (y7 and (RDRF and RxD));
    Y6_i <= (y5 and RxD);
    Y5_i <= (y4 and not CLKCTRout);
    Y4_i <= (y2 and not SCTRout) or (y4 and CLKCTRout);
    Y3_i <= (y2 and SCTRout) or (y3 and CLKCTRout);
    Y2_i <= (y1 and not CLKCTRout) or (y3 and not CLKCTRout);
    Y1_i <= (y1 and CLKCTRout) or (y0 and not RxD);
    Y0_i <= resetcondition or (y0 and RxD) or (y7 and not RDRF);

    Counter: entity work.Counter(struct)
        port map(SCTRload, SCTRinc, CLK, SCTRout);

    CLKCounter: entity work.CLKCounter(struct)
        port map(CLKCTRload, CLKCTRinc, CLKCTRSEL, CLK, CLKCTRout);

    DFF0: entity work.dFF_2(rtl)
        port map(Y0_i, CLK, y0, y0Bar);
    DFF1: entity work.dFF_2(rtl)
        port map(Y1_i, CLK, y1, y1Bar);
    DFF2: entity work.dFF_2(rtl)
        port map(Y2_i, CLK, y2, y2Bar);
    DFF3: entity work.dFF_2(rtl)
        port map(Y3_i, CLK, y3, y3Bar);
    DFF4: entity work.dFF_2(rtl)
        port map(Y4_i, CLK, y4, y4Bar);
    DFF5: entity work.dFF_2(rtl)
        port map(Y5_i, CLK, y5, y5Bar);
    DFF6: entity work.dFF_2(rtl)
        port map(Y6_i, CLK, y6, y6Bar);
    DFF7: entity work.dFF_2(rtl)
        port map(Y7_i, CLK, y7, y7Bar);
    DFF8: entity work.dFF_2(rtl)
        port map(Y8_i, CLK, y8, y8Bar);
    DFF9: entity work.dFF_2(rtl)
        port map(Y9_i, CLK, y9, y9Bar);
    DFF10: entity work.dFF_2(rtl)
        port map(Y10_i, CLK, y10, y10Bar);

    --signals
    CLKCTRload <= y0 or y1 or y2 or y3 or y4;
    CLKCTRinc <= y1 or y3 or y4;
    CLKCTRSEL <= y0;    --dont add y2 even tho signal is there bc signal has to be 0
    SCTRload <= y1 or y2;
    SCTRinc <= y2;

    --outputs
    RSRload <= y2;
    RSRshiftR <= y2;
    RDRload <= y6;
    RDRFload <= y6;
    RDRFin <= y6;
    FEload <= y9;
    FEin <= y9;
    OEload <= y8;
    OEin  <= y8;

end ;