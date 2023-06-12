//
//  CRTColorFilter.metal
//  WWDC23SampleApp
//
//  Created by 藤井陽介 on 2023/06/12.
//

#include <metal_stdlib>
using namespace metal;

[[stitchable]] half4 crtColor(float2 position, half4 color, float pixelWidth, float pixelHeight) {
    int columnIndex = int(fmod(position.x / pixelWidth, 3.0));
    int rowIndex = int(fmod(position.y, pixelHeight));

    float scanlineMultiplier = (rowIndex == 0 || rowIndex == 1) ? 0.3 : 1.0;

    half red = (columnIndex == 0) ? color.r : color.r * ((columnIndex == 2) ? 0.3 : 0.2);
    half green = (columnIndex == 1) ? color.g : color.g * ((columnIndex == 2) ? 0.3 : 0.2);
    half blue = (columnIndex == 2) ? color.b : color.b * 0.2;

    return half4(red * scanlineMultiplier, green * scanlineMultiplier, blue * scanlineMultiplier, 1.0);
}
