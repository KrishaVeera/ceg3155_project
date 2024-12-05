library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Receiver is
 Port (
    Greset, CLK: in std_logic;
    RxD, RDRF: in std_logic;
    RDRFload, RDRFin: out std_logic;
    FEload, FEin: out std_logic;
    OEload, OEin: out std_logic;
    RDRout: out std_logic_vector(7 downto 0)
 );
end Receiver;

architecture struct of Receiver is
    signal RSRload, RSRshiftR, RDRload: std_logic;
    signal RSRout: std_logic_vector(7 downto 0);
begin
    RDR: entity work.Reg_8b(struct)
        port map(RDRload, CLK, RSRout, RDRout);

    RSR: entity work.in_ARShiftReg_8b(struct)
        port map(RSRload, RSRshiftR, CLK, RxD, "00000000", RSRout);

    Controller: entity work.ReceiverController(struct)
        port map(Greset, CLK, RxD, RDRF, RSRload, RSRshiftR, RDRload, RDRFload, RDRFin, FEload, FEin, OEload, OEin);

end ;