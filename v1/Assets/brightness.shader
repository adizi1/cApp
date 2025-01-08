Shader "Custom/EyeEnhancement"
{
    Properties
    {
        _MainTex ("Base Texture", 2D) = "white" { }
        _EyeBrightness ("Eye Brightness", Range(0.0, 1.0)) = 0.3
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };
            
            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            
            sampler2D _MainTex;
            float _EyeBrightness;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            
            half4 frag(v2f i) : SV_Target
            {
                // Sample the texture and enhance eye brightness
                half4 color = tex2D(_MainTex, i.uv);
                color.rgb += _EyeBrightness; // Increase brightness for eye area
                color.rgb = saturate(color.rgb); // Ensure color doesn't exceed [0,1] range
                return color;
            }
            ENDCG
        }
    }
    Fallback "Unlit/Texture"
}
