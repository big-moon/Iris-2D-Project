//
// Globals
//

matrix WorldMatrix;
matrix ProjMatrix;

float CmpPixel;

texture PreTex;
texture MaskTex;
texture TargetTex;

//
// Sampler
//

sampler S0 = sampler_state
{
	Texture = (PreTex);
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
};

sampler S1 = sampler_state
{
	Texture = (MaskTex);
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
};

sampler S2 = sampler_state
{
	Texture = (TargetTex);
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
};

struct PS_INPUT {
	float2 uv : TEXCOORD;
};

struct PS_OUTPUT {
	vector color : COLOR;
};

PS_OUTPUT ps_main(PS_INPUT input) {
	PS_OUTPUT output = (PS_OUTPUT)0;
	float4 preColor = tex2D(S0, input.uv);
	float4 maskColor = tex2D(S1, input.uv);
	float4 targetColor = tex2D(S2, input.uv);

	if (maskColor.a >= CmpPixel)
		output.color = targetColor;
	else
		output.color = preColor;

	return output;
}

// 
// Effect
//

technique LightAndTexture
{
	pass P0
	{
		//
		// Set Misc render states.

		pixelshader = compile ps_2_0 ps_main();
	    // fvf = XYZ | Normal | Tex1;
		fvf = XYZ | Tex1;
		Lighting = true;
		NormalizeNormals = true;
		SpecularEnable = true;

		//
		// Set Transformation States

		WorldTransform[0] = (WorldMatrix);
		ProjectionTransform = (ProjMatrix);

	}

}
