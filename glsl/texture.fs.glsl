// Create shared variable. The value is given as the interpolation between normals computed in the vertex shader
uniform sampler2D rocksTexture;
varying vec2 texCoord;

varying vec4 V_Normal_VCS;
varying vec4 V_ViewPosition;
varying mat3 vMatrix;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightPosition;

uniform int rcState;
void main() {

	// LOOK UP THE COLOR IN THE TEXTURE

  	// ambient
	vec3 ambient = ambientColor;

	// diffuse
	vec3 normalVector = normalize(vec3(V_Normal_VCS));
	
	vec3 vertPos = vec3(V_ViewPosition) / V_ViewPosition.w;
	// vec3 lightVector = normalize(lightPosition - vertPos);
	vec3 lightVector = normalize(vMatrix * lightPosition);

	float NLAngle = max(0.0, dot(normalVector, lightVector));
	vec3 diffuse = lightColor * NLAngle;

	// specular
	vec3 reflectionVector = reflect(-lightVector, normalVector);
	float specAmount = pow(max(0.0,dot(reflectionVector, normalize(vec3(V_ViewPosition)))), shininess);
	vec3 specular = specAmount * lightColor;

  if (rcState == 1){gl_FragColor = texture2D(rocksTexture, texCoord);}
  // Set final rendered color according to the surface normal
  if (rcState == 2){gl_FragColor = texture2D(rocksTexture, texCoord) * vec4((kAmbient * ambient) + (kDiffuse * diffuse) + (kSpecular * specular), 1.0);}
}
