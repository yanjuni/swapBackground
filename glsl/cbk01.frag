
varying  vec2 qt_TexCoord0;
uniform float qt_Opacity;
uniform sampler2D effectSource;
uniform float percent;

uniform float sideRu;
uniform float sideGu;
uniform float sideBu;
uniform float sideRd;
uniform float sideGd;
uniform float sideBd;


uniform float pX01;
uniform float pX02;
uniform float pX03;
uniform float pX04;
uniform float pX05;
uniform float pX06;
uniform float pX07;
uniform float pX08;
uniform float pX09;
uniform float pX10;

uniform float pY01;
uniform float pY02;
uniform float pY03;
uniform float pY04;
uniform float pY05;
uniform float pY06;
uniform float pY07;
uniform float pY08;
uniform float pY09;
uniform float pY10;

uniform float pR01;
uniform float pR02;
uniform float pR03;
uniform float pR04;
uniform float pR05;
uniform float pR06;
uniform float pR07;
uniform float pR08;
uniform float pR09;
uniform float pR10;



uniform float mouseX;
uniform float mouseY;
uniform float r;
uniform int cntRecod;

void main()
{
    float alpha = 1.0;
    float y = 0.370;

    vec4 color = texture2D(effectSource, qt_TexCoord0);
    vec4 tmpCol;
    vec2 pos = qt_TexCoord0;
    vec2 mousePoint = vec2(mouseX,mouseY);
    float dis = distance(pos,mousePoint);
    float gray = (color.r + color.g  + color.b)/3.0;
    float td = 30.0;
/*

             color.r-sideDown<sideR<color.r+sideUp
           &&color.g-sideDown<sideG<color.g+sideUp
           &&color.b-sideDown<sideB<color.b+sideUp

*/
    tmpCol=color;
    if(dis>r){
        if(
                (sideRd<=color.r&&color.r<=sideRu)&&
                (sideGd<=color.g&&color.g<=sideGu)&&
                (sideBd<=color.b&&color.b<=sideBu)
          )
        {
            tmpCol=vec4(0,0,0,0);
        }
    }
    float pRTmp = 0.0;
    for(int i =0;i<cntRecod;i++){
         if(i==0){
             dis = distance(pos,vec2(pX01,pY01));
             pRTmp=pR01;
         }else if(i==1){
             dis = distance(pos,vec2(pX02,pY02));
             pRTmp=pR02;
         }else if(i==2){
             dis = distance(pos,vec2(pX03,pY03));
             pRTmp=pR03;
         }else if(i==3){
             dis = distance(pos,vec2(pX04,pY04));
             pRTmp=pR04;
         }else if(i==4){
             dis = distance(pos,vec2(pX05,pY05));
             pRTmp=pR05;
         }else if(i==5){
             dis = distance(pos,vec2(pX06,pY06));
             pRTmp=pR06;
         }else if(i==6){
             dis = distance(pos,vec2(pX07,pY07));
             pRTmp=pR07;
         }else if(i==7){
             dis = distance(pos,vec2(pX08,pY08));
             pRTmp=pR08;
         }else if(i==8){
             dis = distance(pos,vec2(pX09,pY09));
             pRTmp=pR09;
         }else if(i==9){
             dis = distance(pos,vec2(pX10,pY10));
             pRTmp=pR10;
         }

         if(dis<pRTmp){
             tmpCol=color;
             break;
         }
    }
    gl_FragColor =tmpCol;
}




