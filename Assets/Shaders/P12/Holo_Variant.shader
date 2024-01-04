Shader "Custom/Holo_Variant"
{
    Properties
    {
        _BumpMap("NormalMap", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }

        CGPROGRAM
        #pragma surface surf nolight noambient alpha:fade

        sampler2D _BumpMap;

        struct Input
        {
            float2 uv_BumpMap;
            float3 viewDir;
            float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            //o.Albedo = c.rgb;
            o.Emission = float3(0, 1, 0);
            float rim = saturate(dot(o.Normal, IN.viewDir));
            rim = saturate(pow(1 - rim, 3) + pow(frac(IN.worldPos.g * 20 - _Time.y), 5) * 0.1);
            o.Alpha = rim;
        }

        float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten)
        {
            return float4(0,0,0,s.Alpha);
        }
        ENDCG
    }
    FallBack "Transparent/Diffuse"
}
