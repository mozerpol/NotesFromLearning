Firstly I'll decribe RTG4 from
[here](https://www.microsemi.com/product-directory/rad-tolerant-fpgas/3576-rtg4#documents)
[date of access: 23.12.2021]. Exactly *RTG4 FPGAs Technical Brief* from *Product
Brief* column: <br/>
![a](https://user-images.githubusercontent.com/43972902/147283409-ec826d5e-363d-4451-a9a5-ef7f9e35ee62.png)

In the introduction of pdf we can read about: <br>
1. *SerDes* - it's a Serializer/Deserializer (pronounced sir-deez or sir-dez),
a pair of functional blocks commonly used in high speed communications to
compensate for limited input/output. These blocks convert data between serial
data and parallel interfaces in each direction. <br/>

||
|:--:|
|![a](https://user-images.githubusercontent.com/43972902/147286951-7873a8c7-35fc-496d-a285-4c035c5df665.png)|
|The principle of a SerDes|
|Source: *https://en.wikipedia.org/wiki/SerDes*|

2. LEO - low Earth orbit (160 km - 1,600 km), MEO - medium Earth orbit (10,000 -
20,000 km), GEO (35,786 km above Earth) - geostationary or geosynchronous
orbit. Satellites do not operate between LEO and MEO because of the inhospitable
(pol. *nieprzyjazny*) environment for electronic components in that area, which
is caused by the
[Van Allen radiation belt](https://en.wikipedia.org/wiki/Van_Allen_radiation_belt).

3. SEU - single-event upset - also known as a single-event error (SEE). It's a
type of error caused by the impact of a single ionizing particle (ions,
electrons, photons ...) into important part of micro-electronic device, such
as in a microprocessor. SEUs do not destroy the circuits involved, but they can
cause errors.

Later at third page we can find a new abbreviations: <br/>
1. EDAC - error detection and correction or error control. They're error control
techniques that enable reliable delivery of digital data over unreliable 
communication channels. In other words, error detection is the detection of
errors caused by noise or other impairments during transmission from the
transmitter to the receiver, but error correction is the detection of errors and
reconstruction of the original, error-free data. 
2. SpaceWire - spacecraft communication network. SpaceWire covers two (physical
and data-link) of the seven layers of the OSI model for communications.
