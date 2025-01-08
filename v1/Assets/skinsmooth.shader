Shader "Custom/SkinSmoothing"
{
    Properties
    {
        _MainTex ("Base Texture", 2D) = "white" { }
        _SmoothingAmount ("Smoothing Amount", Range(0.0, 1.0)) = 0.5
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
            float _SmoothingAmount;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            
            half4 frag(v2f i) : SV_Target
            {
                // Sample texture and apply a smoothing effect
                half4 color = tex2D(_MainTex, i.uv);
                color.rgb = lerp(color.rgb, half3(0.8, 0.8, 0.8), _SmoothingAmount); // Apply smoothing by mixing with a neutral color
                return color;
            }
            ENDCG
        }
    }
    Fallback "Unlit/Texture"
}
