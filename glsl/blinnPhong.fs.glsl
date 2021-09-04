
varying vec4 V_ViewPosition;
varying vec4 V_Normal_VCS;
varying mat3 vMatrix;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightPosition;

void main() {

	// COMPUTE LIGHTING HERE
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
	vec3 halfVector = normalize(lightVector + normalize(vec3(V_ViewPosition)));
	float specAmount = pow(max(0.0,dot(normalVector, halfVector)), shininess);
	vec3 specular = specAmount * lightColor;

	gl_FragColor = vec4((kAmbient * ambient) + (kDiffuse * diffuse) + (kSpecular * specular), 1.0);
}