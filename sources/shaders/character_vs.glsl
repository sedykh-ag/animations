#version 330

struct VsOutput
{
  vec3 EyespaceNormal;
  vec3 WorldPosition;
  vec2 UV;
};

uniform mat4 Transform;
uniform mat4 ViewProjection;
uniform mat4 BonesTransform[128];

layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 UV;
layout(location = 3) in vec4 BoneWeights;
layout(location = 4) in uvec4 BoneIndex;

out VsOutput vsOutput;
out vec3 boneColors;

vec3 get_random_color(uint x)
{
  x += 1u;
  vec3 col = vec3(1.61803398875);
  col = fract(col) * vec3(x,x,x);
  col = fract(col) * vec3(1,x,x);
  col = fract(col) * vec3(1,1,x);
  return fract(col);
}

void main()
{
  mat4 weightedBoneTransform = mat4(0);

  for (int i = 0; i < 4; i++)
    weightedBoneTransform += BonesTransform[BoneIndex[i]] * BoneWeights[i];

  mat4 Model = Transform * weightedBoneTransform;

  vec3 VertexPosition = (Model * vec4(Position, 1)).xyz;
  vsOutput.EyespaceNormal = normalize((Model * vec4(Normal, 0)).xyz);

  gl_Position = ViewProjection * vec4(VertexPosition, 1);
  vsOutput.WorldPosition = VertexPosition;

  vsOutput.UV = UV;
  boneColors = vec3(0);

  for (int  i = 0; i < 4; i++)
    boneColors += get_random_color(BoneIndex[i]) * BoneWeights[i];
}