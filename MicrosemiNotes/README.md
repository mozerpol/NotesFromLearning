In this repo I described (for now) two brief desc of MicroSemi devices from
their website.
_____

### Table of contents <a name="tof"></a>
1. [RTG4](#rtg4)
   1. [SerDes](#SerDes)
   2. [LEO](#LEO)
   3. [SEU](#SEU)
   4. [EDAC](#EDAC)
   5. [SpaceWire](#SpaceWire)
   6. [LPDDR](#LPDDR)
   7. [SSTL](#SSTL)
   8. [PLL](#PLL)
   9. [TMR](#TMR)
   10. [PMA](#PMA)
   11. [XGMII](#XGMII)
   12. [XAUI](#XAUI)
   13. [AHB](#AHB)
   14. [POR Generator](#PORGenerator)
   15. [LVTTL](#LVTTL)
2. [SmartFusion2](#SmartFusion2)
   1. [AES](#AES)
   2. [SHA256](#SHA256)
   3. [PUF](#PUF)
   4. [NRBG](#NRBG)
   5. [Flash*Freeze](#FlashFreeze)
   6. [MMUART](#MMUART)
   7. [WDT](#WDT)
   8. [FIIC](#FIIC)
   9. [APB](#APB)
   10. [PDMA](#PDMA)
   11. [OTG ULPI](#OTGULPI)
   12. [FIC](#FIC)
   13. [tse](#TSE)
   14. [eNVM](#envm)
   15. [OSC](#OSC)
   16. [HPDMA](#HPDMA)

Firstly I'll decribe **RTG4** <a name="rtg4"></a> from
[here](https://www.microsemi.com/product-directory/rad-tolerant-fpgas/3576-rtg4#documents)
[date of access: 23.12.2021]. Exactly *RTG4 FPGAs Technical Brief* from *Product
Brief* column: <br/>
![a](https://user-images.githubusercontent.com/43972902/147283409-ec826d5e-363d-4451-a9a5-ef7f9e35ee62.png)

In the introduction of pdf we can read about: <br>
1. *SerDes* <a name="SerDes"></a> - it's a Serializer/Deserializer (pronounced
sir-deez or sir-dez), a pair of functional blocks commonly used in high speed
communications to compensate for limited input/output. These blocks convert data
between serial data and parallel interfaces in each direction. <br/>

||
|:--:|
|![a](https://user-images.githubusercontent.com/43972902/147286951-7873a8c7-35fc-496d-a285-4c035c5df665.png)|
|The principle of a SerDes|
|Source: *https://en.wikipedia.org/wiki/SerDes*|

2. LEO <a name="LEO"></a> - low Earth orbit (160 km - 1,600 km), MEO - medium
Earth orbit (10,000 -
20,000 km), GEO (35,786 km above Earth) - geostationary or geosynchronous
orbit. Satellites do not operate between LEO and MEO because of the inhospitable
(pol. *nieprzyjazny*) environment for electronic components in that area, which
is caused by the
[Van Allen radiation belt](https://en.wikipedia.org/wiki/Van_Allen_radiation_belt).

3. SEU <a name="SEU"></a> - single-event upset - also known as a single-event
error (SEE). It's a
type of error caused by the impact of a single ionizing particle (ions,
electrons, photons ...) into important part of micro-electronic device, such
as in a microprocessor. SEUs do not destroy the circuits involved, but they can
cause errors.

Later at third page we can find a new abbreviations:

4. EDAC <a name="EDAC"></a> - error detection and correction or error control.
They're error control
techniques that enable reliable delivery of digital data over unreliable
communication channels. In other words, error detection is the detection of
errors caused by noise or other impairments during transmission from the
transmitter to the receiver, but error correction is the detection of errors and
reconstruction of the original, error-free data.

5. SpaceWire <a name="SpaceWire"></a> - spacecraft communication network.
SpaceWire covers two (physical
and data-link) of the seven layers of the OSI model for communications.

6. LPDDR <a name="LPDDR"></a> - Low-Power Double Data Rate. It is a type of
synchronous dynamic
random-access memory that consumes less power and is targeted for mobile
computers and devices such as mobile phones. Older variants are also known as
mDDR (mobile-DDR). LPDDR technology standards are developed independently of DDR
standards. In contrast with standard SDRAM, used in stationary devices and
laptops and usually connected over a 64-bit wide memory bus, LPDDR also permits
16- or 32-bit wide channels.

Page 4:

7. SSTL <a name="SSTL"></a> - Stub Series Terminated Logic. It is a group of
electrical standards
for driving transmission lines commonly used with DRAM based DDR memory IC's and
memory modules. Also we can distinguish HSSTL - high-speed transceiver logic.
Four voltage levels for SSTL are defined:

| Name: | Voltage [V]: |
|:--:|:--:|
| SSTL3 | 3.3 |
| SSTL2 | 2.5 |
| SSTL18 | 1.8 |
| SSTL15 | 1.5 |

8. PLL <a name="PLL"></a> - was described
[here](https://github.com/mozerpol/NotesFromLearning/tree/main/FPGAodPoczatkuDoKonca#pll).

9. TMR <a name="TMR"></a> - triple modular redundancy. It is a fault-tolerant
form of N-modular
redundancy, in which three systems perform a process and that result is
processed by a majority-voting system to produce a single output. If any one of
the three systems fails, the other two systems can correct and mask the fault.

How *mathblocks* looks like in FPGA. For better understanding I'll compare math
block and logic element in SmartFusion2: <br/>
|Logic Element: |
|:--:|
|![b](https://user-images.githubusercontent.com/43972902/147354481-f7417c23-0f71-464c-90de-1dc899530f19.png)|
|**Math Block**|
|![a](https://user-images.githubusercontent.com/43972902/147354464-7a45ff13-ddce-405c-ae25-65a7386f2d33.png)|
|Source: *https://microchipdeveloper.com/fpga:overview*|

Page 5: <br/>
|RTG4 Device Block Diagram|
|:--:|
|![a](https://user-images.githubusercontent.com/43972902/147385653-cebc2711-58ae-4434-9fe8-7b80a8b16012.png)|
|Source: *https://www.microsemi.com/document-portal/doc_download/134430-rtg4-fpgas-technical-brief*|

10. PMA <a name="PMA"></a> - Physical Medium Attachment layer. It's to help to
define the physical layer of computer network protocols. It's a part (sublayer) of
[Physical medium dependent](https://en.wikipedia.org/wiki/Physical_medium_dependent).
This sublayers define the details of transmission and reception (pol. odbiór) of
individual bits on a physical medium. Common examples are specifications for
Fast Ethernet, Gigabit Ethernet and 10 Gigabit Ethernet defined by IEEE.

11. XGMII <a name="XGMII"></a> - 10 gigabit media-independent interface. It's a
standard
designed for connecting full duplex 10 Gigabit Ethernet (10GbE) ports to each
other and to other electronic devices on a printed circuit board (PCB). XGMII
features two 32-bit datapaths (Rx & Tx) and two four-bit control flows (Rxc and
Txc), operating at 156.25 MHz DDR (312.5 MT/s).

12. XAUI <a name="XAUI"></a> - 10 Gigabit Attachment Unit Interface (proun.
ZOW-ee). It is a standard
for extending the XGMII.

13. AHB <a name="AHB"></a> - Advanced High-performance Bus. It is a bus
protocol, is used for
connecting components that need higher bandwidth on a shared bus. These could be
a internal memory or an external memory interface, DMA , DSP etc.

14. POR Generator <a name="PORGenerator"></a> - power-on reset. It is an
electronic device incorporated into
the integrated circuit that detects the power applied to the chip and generates
a reset impulse that goes to the entire circuit placing it into a known state.
A simple PoR uses the charging of a capacitor, in series with a resistor, to
measure a time period during which the rest of the circuit is held in a reset
state.

15. LVTTL <a name="LVTTL"></a> - Low Voltage TTL.
- The switching range at output is 0.4V to 2.4V for 3.3V LVTTL version.
- The switching range at output is 0.4V to 2.2V for 2.5V LVTTL version.

|Low Voltage Logic Threshold Levels|
|:--:|
|![a](https://user-images.githubusercontent.com/43972902/147385995-de0a5cb1-056d-4c46-ae3d-88f4a2d87b1e.png)|
|Source: *http://www.interfacebus.com/voltage_LV_threshold.html*|

Now, I'll decribe **SmartFusion2** from <a name="SmartFusion2"></a>
[here](https://www.microsemi.com/product-directory/soc-fpgas/1692-smartfusion2#overview).
But in contrast before I won't use pdf file, but only main page where is a brief
desc of this devs.

|SmartFusion2 SoC FPGA Architecture|
|:--:|
|![a](https://user-images.githubusercontent.com/43972902/147388071-21f9870d-1c9f-4946-94a4-016e5089eaf1.png)|
|Source: *https://www.microsemi.com/product-directory/soc-fpgas/1692-smartfusion2#overview*|

1. AES <a name="AES"></a> - Advanced Encryption Standard. It is a specification
for the encryption of electronic data. 256 is a key length.

2. SHA256 <a name="SHA256"></a> - Secure Hash Algorithm. It's a set of
cryptographic hash functions.

3. PUF <a name="PUF"></a> - physical unclonable function. It is a physical object that for a given
input and conditions, provides a physically defined "digital fingerprint" output
(response) that serves as a unique identifier, most often for a semiconductor
device such as a microprocessor. PUFs are most often based on unique physical
variations which occur naturally during semiconductor manufacturing.
A PUF is a physical entity embodied in a physical structure. Starting in 2010,
PUF gained attention in the smartcard market as a promising way to provide
"silicon fingerprints", creating cryptographic keys that are unique to
individual smartcards.

4. NRBG <a name="NRBG"></a> - on-deterministic Random Bit Generator.

5. Flash*Freeze <a name="FlashFreeze"></a> - enables entering and exiting an
ultra-low power mode while retaining (while retaining - *zachowując*) SRAM and
register data.

6. MMUART <a name="MMUART"></a> - Multi-Mode UART.

7. WDT <a name="WDT"></a> - Watchdog Timer.

8. FIIC <a name="FIIC"></a> - Fabric Interface Interrupt Controller. It's manages MSS
(microcontroller subsystem) to fabric (M2F) and fabric to MSS (F2M) interrupts.
The MSS interrupts are connected to the nested vectored interrupt controller
(NVIC) of the ARM Cortex-M3 microcontroller. These interrupts are also routed to
the FPGA fabric through the FIIC. In addition, user logic can interrupt the
ARM Cortex-M3 microcontroller via this block or by configuring the general
purpose I/O (GPIO) to trigger an interrupt on an input that is connected to the
FPGA fabric.

9. APB <a name="APB"></a> - Advanced Peripheral Bus. It is designed for low
bandwidth control
accesses, for example register interfaces on system peripherals. This bus has an
address and data phase similar to AHB, but a much reduced, low complexity signal
list. Furthermore (pol. *dodatkowo*), it is an interface designed for a low
frequency system with a low bit width (32 bits).

10. PDMA <a name="PDMA"></a> - Peripheral DMA.

11. OTG ULPI <a name="OTGULPI"></a> - It is a standards based interface designed
to provide a high
capacity point-to-point connection between an SoC or ASIC to a Hi-Speed USB
Transceiver.

12. FIC <a name="FIC"></a> - Fabric Interface Controller.
13. TSE <a name="TSE"></a> - Triple Speed Ethernet.
14. eNVM <a name="envm"></a> - nonvolatile (flash) memory.
15. OSC <a name="OSC"></a> - oscillator.
16. HPDMA <a name="HPDMA"></a> - High-performance DMA.
