//
//  EightBitThresholdFilter.metal
//  WWDC23SampleApp
//
//  Created by 藤井陽介 on 2023/06/12.
//

#include <metal_stdlib>
using namespace metal;

// ZX Spectrum Dim
constant half3 dimSpectrum[] = {
    half3(float(0x00)/255.0, float(0x00)/255.0, float(0x00)/255.0),
    half3(float(0x00)/255.0, float(0x00)/255.0, float(0xCD)/255.0),
    half3(float(0xCD)/255.0, float(0x00)/255.0, float(0x00)/255.0),
    half3(float(0xCD)/255.0, float(0x00)/255.0, float(0xCD)/255.0),
    half3(float(0x00)/255.0, float(0xCD)/255.0, float(0x00)/255.0),
    half3(float(0x00)/255.0, float(0xCD)/255.0, float(0xCD)/255.0),
    half3(float(0xCD)/255.0, float(0xCD)/255.0, float(0x00)/255.0),
    half3(float(0xCD)/255.0, float(0xCD)/255.0, float(0xCD)/255.0),
};
// ZX Spectrum Bright
constant half3 brightSpectrum[] = {
    half3(float(0x00)/255.0, float(0x00)/255.0, float(0x00)/255.0),
    half3(float(0x00)/255.0, float(0x00)/255.0, float(0xFF)/255.0),
    half3(float(0xFF)/255.0, float(0x00)/255.0, float(0x00)/255.0),
    half3(float(0xFF)/255.0, float(0x00)/255.0, float(0xFF)/255.0),
    half3(float(0x00)/255.0, float(0xFF)/255.0, float(0x00)/255.0),
    half3(float(0x00)/255.0, float(0xFF)/255.0, float(0xFF)/255.0),
    half3(float(0xFF)/255.0, float(0xFF)/255.0, float(0x00)/255.0),
    half3(float(0xFF)/255.0, float(0xFF)/255.0, float(0xFF)/255.0),
};
// VIC-20
constant half3 vic20[] = {
    half3(0.0/255.0, 0.0/255.0, 0.0/255.0),
    half3(255.0/255.0, 255.0/255.0, 255.0/255.0),
    half3(141.0/255.0, 62.0/255.0, 55.0/255.0),
    half3(114.0/255.0, 193.0/255.0, 200.0/255.0),
    half3(128.0/255.0, 52.0/255.0, 139.0/255.0),
    half3(85.0/255.0, 160.0/255.0, 73.0/255.0),
    half3(64.0/255.0, 49.0/255.0, 141.0/255.0),
    half3(170.0/255.0, 185.0/255.0, 93.0/255.0),
    half3(139.0/255.0, 84.0/255.0, 41.0/255.0),
    half3(213.0/255.0, 159.0/255.0, 116.0/255.0),
    half3(184.0/255.0, 105.0/255.0, 98.0/255.0),
    half3(135.0/255.0, 214.0/255.0, 221.0/255.0),
    half3(170.0/255.0, 95.0/255.0, 182.0/255.0),
    half3(148.0/255.0, 224.0/255.0, 137.0/255.0),
    half3(128.0/255.0, 113.0/255.0, 204.0/255.0),
    half3(191.0/255.0, 206.0/255.0, 114.0/255.0),
};
// C-64
constant half3 c64[] = {
    half3(0.0/255.0, 0.0/255.0, 0.0/255.0),
    half3(255.0/255.0, 255.0/255.0, 255.0/255.0),
    half3(136.0/255.0, 57.0/255.0, 50.0/255.0),
    half3(103.0/255.0, 182.0/255.0, 189.0/255.0),
    half3(139.0/255.0, 63.0/255.0, 150.0/255.0),
    half3(85.0/255.0, 160.0/255.0, 73.0/255.0),
    half3(64.0/255.0, 49.0/255.0, 141.0/255.0),
    half3(191.0/255.0, 206.0/255.0, 114.0/255.0),
    half3(139.0/255.0, 84.0/255.0, 41.0/255.0),
    half3(87.0/255.0, 66.0/255.0, 0.0/255.0),
    half3(184.0/255.0, 105.0/255.0, 98.0/255.0),
    half3(80.0/255.0, 80.0/255.0, 80.0/255.0),
    half3(120.0/255.0, 120.0/255.0, 120.0/255.0),
    half3(148.0/255.0, 224.0/255.0, 137.0/255.0),
    half3(120.0/255.0, 105.0/255.0, 196.0/255.0),
    half3(159.0/255.0, 159.0/255.0, 159.0/255.0),
};
// Apple II
constant half3 appleII[] = {
    half3(0.0/255.0, 0.0/255.0, 0.0/255.0),
    half3(114.0/255.0, 38.0/255.0, 64.0/255.0),
    half3(64.0/255.0, 51.0/255.0, 127.0/255.0),
    half3(228.0/255.0, 52.0/255.0, 254.0/255.0),
    half3(14.0/255.0, 89.0/255.0, 64.0/255.0),
    half3(128.0/255.0, 128.0/255.0, 128.0/255.0),
    half3(27.0/255.0, 154.0/255.0, 254.0/255.0),
    half3(191.0/255.0, 179.0/255.0, 255.0/255.0),
    half3(64.0/255.0, 76.0/255.0, 0.0/255.0),
    half3(228.0/255.0, 101.0/255.0, 1.0/255.0),
    half3(128.0/255.0, 128.0/255.0, 128.0/255.0),
    half3(241.0/255.0, 166.0/255.0, 191.0/255.0),
    half3(27.0/255.0, 203.0/255.0, 1.0/255.0),
    half3(191.0/255.0, 204.0/255.0, 128.0/255.0),
    half3(141.0/255.0, 217.0/255.0, 191.0/255.0),
    half3(255.0/255.0, 255.0/255.0, 255.0/255.0),
};

half3 calc(half3 color, constant half3 *palette, int arraySize) {
    float dist = distance(color, palette[0]);
    half3 returnColor = palette[0];

    for (int i = 1; i < arraySize; i++) {
        if (distance(color, palette[i]) < dist) {
            dist = distance(color, palette[i]);
            returnColor = palette[i];
        }
    }

    return returnColor;
}

[[stitchable]] half4 eightBitThresholdFilter(float2 position, half4 color, int paletteIndex) {
    half3 colorHalf = half3(color.x, color.y, color.z);

    if (paletteIndex == 0) {
        return half4(calc(colorHalf, dimSpectrum, 8), 1.0);
    } else if (paletteIndex == 1) {
        return half4(calc(colorHalf, brightSpectrum, 8), 1.0);
    } else if (paletteIndex == 2) {
        return half4(calc(colorHalf, vic20, 16), 1.0);
    } else if (paletteIndex == 3) {
        return half4(calc(colorHalf, c64, 16), 1.0);
    } else {
        return half4(calc(colorHalf, appleII, 16), 1.0);
    }
}

