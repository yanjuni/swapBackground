
varying  vec2 qt_TexCoord0;
uniform float qt_Opacity;
uniform sampler2D effectSource;
uniform int dir;
uniform float percent;
uniform float sideUp;
uniform float sideDown;
uniform float sideR;
uniform float sideG;
uniform float sideB;
uniform float mouseX;
uniform float mouseY;
uniform float xx;
uniform float r;
uniform int rowCount;
uniform int columnCount;

void main()
{
    float alpha = 1.0;
    float y = 0.370;

    vec4 color = texture2D(effectSource, qt_TexCoord0);
    vec2 pos = qt_TexCoord0;
    float mouseP = pow(pos.x-mouseX,2.0)+pow(pos.y-mouseY,2.0);
    float mousePos = pow(r,2.0);
    float gray = (color.r + color.g  + color.b)/3.0;
    float td = 30.0;
/*

             color.r-sideDown<sideR<color.r+sideUp
           &&color.g-sideDown<sideG<color.g+sideUp
           &&color.b-sideDown<sideB<color.b+sideUp

*/
    if(mouseP>mousePos){
        if(
                color.r>sideR||
                color.g>sideG||
                color.b>sideB
          )
        {
            color=vec4(0.0,0.0,0.0,0);
        }
    }
    gl_FragColor =color;
}




