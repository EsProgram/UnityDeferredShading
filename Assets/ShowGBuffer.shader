Shader "DeferedShadingTest/ShowGBuffer"
{
	Properties
	{
		[KeywordEnum(DIFF, SPEC, NORM, LIGHT, DEPTH, SHADOW_MAP)]
		_GB("G-Buffer Selecter", Float) = 0
	}

	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma shader_feature _GB_DIFF _GB_SPEC _GB_NORM _GB_LIGHT _GB_DEPTH _GB_SHADOW_MAP

			#define SHADOWS_SCREEN

			#include "UnityCG.cginc"
			#include "GBufferVariant.cginc"
			#include "UnityDeferredLibrary.cginc"

			fixed4 frag (v2f_img i) : SV_Target
			{
				#ifdef _GB_DIFF
					return tex2D(_CameraGBufferTexture0, i.uv);
				#elif _GB_SPEC
					return tex2D(_CameraGBufferTexture1, i.uv);
				#elif _GB_NORM
					return tex2D(_CameraGBufferTexture2, i.uv);
				#elif _GB_LIGHT
					return tex2D(_CameraGBufferTexture3, i.uv);
				#elif _GB_DEPTH
					return Linear01Depth(tex2D(_CameraDepthTexture, i.uv).r);
				#else
					return tex2D(_ShadowMapTexture, i.uv);
				#endif
			}
			ENDCG
		}
	}
}
