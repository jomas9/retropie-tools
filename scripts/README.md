# Scripts



- `attract-mode-menu.sh`- após ter o Attract-Mode instalado, este script possibilita criar uma entrada no menu Retropie para alternar entre inicialização padrão no EmulationStation ou Attract-Mode. 
- `lr-mame2003_midway.sh`- libretro core MAME 0.78 com otimizações para jogos da Midway.
- `screenshot.sh` - Realiza capturas de tela remotamente através do SSH.
- `XML_to_AM.py`- converte gamelist.xml para o formato .txt (Attract-Mode). Para usar, basta ter o arquivo .xml na mesma pasta do script, abrir o terminal e executar python **XML_to_AM.py**, será gerado um arquivo chamado **my_file.txt**, basta abrir e editar, substituindo a palavra EMULATOR_REPLACE pelo devido nome do emulador do Attract-Mode (ex.: Super Nintendo Entertainment System), e, eliminar o .\ antes dos nomes das roms.