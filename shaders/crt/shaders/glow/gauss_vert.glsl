// GLSL shader autogenerated by cg2glsl.py.
#if defined(VERTEX)

#if __VERSION__ >= 130
#define COMPAT_VARYING out
#define COMPAT_ATTRIBUTE in
#define COMPAT_TEXTURE texture
#else
#define COMPAT_VARYING varying
#define COMPAT_ATTRIBUTE attribute
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif
COMPAT_VARYING     float VARone;
COMPAT_VARYING     vec2 VARpix_no;
struct data {
    vec2 VARpix_no;
    float VARone;
};
struct input_dummy {
    vec2 _video_size;
    vec2 _texture_size;
    vec2 _output_dummy_size;
};
vec4 _oPosition1;
data _oData1;
input_dummy _IN1;
vec4 _r0006;
COMPAT_ATTRIBUTE vec4 VertexCoord;
COMPAT_ATTRIBUTE vec4 TexCoord;
 
uniform mat4 MVPMatrix;
uniform int FrameDirection;
uniform int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
void main()
{
    _r0006 = VertexCoord.x*MVPMatrix[0];
    _r0006 = _r0006 + VertexCoord.y*MVPMatrix[1];
    _r0006 = _r0006 + VertexCoord.z*MVPMatrix[2];
    _r0006 = _r0006 + VertexCoord.w*MVPMatrix[3];
    _oPosition1 = _r0006;
    VARpix_no = TexCoord.xy*TextureSize - vec2( 0.00000000E+00, 5.00000000E-01);
    VARone = 1.00000000E+00/TextureSize.y;
    gl_Position = _r0006;
} 
#elif defined(FRAGMENT)

#if __VERSION__ >= 130
#define COMPAT_VARYING in
#define COMPAT_TEXTURE texture
out vec4 FragColor;
#else
#define COMPAT_VARYING varying
#define FragColor gl_FragColor
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif
COMPAT_VARYING     float VARone;
COMPAT_VARYING     vec2 VARpix_no;
struct data {
    vec2 VARpix_no;
    float VARone;
};
struct input_dummy {
    vec2 _video_size;
    vec2 _texture_size;
    vec2 _output_dummy_size;
};
vec4 _ret_0;
vec3 _TMP3;
vec3 _TMP7;
float _TMP11;
float _TMP10;
float _TMP9;
vec3 _TMP6;
float _TMP14;
float _TMP13;
float _TMP12;
float _TMP5;
vec3 _TMP4;
vec3 _TMP2;
vec4 _TMP1;
vec4 _TMP0;
input_dummy _IN1;
data _vertex1;
uniform sampler2D Texture;
vec2 _c0024;
vec3 _wid0026;
vec3 _weights0026;
vec3 _x0038;
vec3 _a0046;
vec3 _TMP53;
vec3 _x0054;
vec3 _wid0064;
vec3 _weights0064;
vec3 _x0076;
vec3 _a0084;
vec3 _TMP91;
vec3 _x0092;
 
uniform int FrameDirection;
uniform int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
void main()
{
    vec2 _texel;
    float _phase;
    vec2 _tex;
    float _dist1;
    vec3 _scanline;
    vec3 _TMP18;
    _texel = floor(VARpix_no);
    _phase = VARpix_no.y - _texel.y;
    _tex = (_texel + 5.00000000E-01)/TextureSize;
    _TMP0 = COMPAT_TEXTURE(Texture, _tex);
    _c0024 = _tex + vec2(0.00000000E+00, VARone);
    _TMP1 = COMPAT_TEXTURE(Texture, _c0024);
    _dist1 = 1.00000000E+00 - _phase;
    _TMP9 = pow(_TMP0.x, 4.00000000E+00);
    _TMP10 = pow(_TMP0.y, 4.00000000E+00);
    _TMP11 = pow(_TMP0.z, 4.00000000E+00);
    _TMP4 = vec3(_TMP9, _TMP10, _TMP11);
    _wid0026 = 2.00000000E+00 + 2.00000000E+00*_TMP4;
    _TMP5 = abs(_phase);
    _weights0026 = vec3(_TMP5/3.00000012E-01, _TMP5/3.00000012E-01, _TMP5/3.00000012E-01);
    _x0038 = 5.00000000E-01*_wid0026;
    _TMP12 = inversesqrt(_x0038.x);
    _TMP13 = inversesqrt(_x0038.y);
    _TMP14 = inversesqrt(_x0038.z);
    _TMP6 = vec3(_TMP12, _TMP13, _TMP14);
    _a0046 = _weights0026*_TMP6;
    _TMP9 = pow(_a0046.x, _wid0026.x);
    _TMP10 = pow(_a0046.y, _wid0026.y);
    _TMP11 = pow(_a0046.z, _wid0026.z);
    _TMP7 = vec3(_TMP9, _TMP10, _TMP11);
    _x0054 = -_TMP7;
    _TMP9 = pow(2.71828198E+00, _x0054.x);
    _TMP10 = pow(2.71828198E+00, _x0054.y);
    _TMP11 = pow(2.71828198E+00, _x0054.z);
    _TMP53 = vec3(_TMP9, _TMP10, _TMP11);
    _TMP2 = ((2.00000000E+00*_TMP0.xyz)*_TMP53)/(6.00000024E-01 + 2.00000003E-01*_wid0026);
    _TMP9 = pow(_TMP1.x, 4.00000000E+00);
    _TMP10 = pow(_TMP1.y, 4.00000000E+00);
    _TMP11 = pow(_TMP1.z, 4.00000000E+00);
    _TMP4 = vec3(_TMP9, _TMP10, _TMP11);
    _wid0064 = 2.00000000E+00 + 2.00000000E+00*_TMP4;
    _TMP5 = abs(_dist1);
    _weights0064 = vec3(_TMP5/3.00000012E-01, _TMP5/3.00000012E-01, _TMP5/3.00000012E-01);
    _x0076 = 5.00000000E-01*_wid0064;
    _TMP12 = inversesqrt(_x0076.x);
    _TMP13 = inversesqrt(_x0076.y);
    _TMP14 = inversesqrt(_x0076.z);
    _TMP6 = vec3(_TMP12, _TMP13, _TMP14);
    _a0084 = _weights0064*_TMP6;
    _TMP9 = pow(_a0084.x, _wid0064.x);
    _TMP10 = pow(_a0084.y, _wid0064.y);
    _TMP11 = pow(_a0084.z, _wid0064.z);
    _TMP7 = vec3(_TMP9, _TMP10, _TMP11);
    _x0092 = -_TMP7;
    _TMP9 = pow(2.71828198E+00, _x0092.x);
    _TMP10 = pow(2.71828198E+00, _x0092.y);
    _TMP11 = pow(2.71828198E+00, _x0092.z);
    _TMP91 = vec3(_TMP9, _TMP10, _TMP11);
    _TMP3 = ((2.00000000E+00*_TMP1.xyz)*_TMP91)/(6.00000024E-01 + 2.00000003E-01*_wid0064);
    _scanline = _TMP2 + _TMP3;
    _TMP18 = _scanline/1.14999998E+00;
    _ret_0 = vec4(_TMP18.x, _TMP18.y, _TMP18.z, 1.00000000E+00);
    FragColor = _ret_0;
    return;
} 
#endif
