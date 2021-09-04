varying vec4 V_Color;
varying vec3 vertPos;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightPosition;

void main() {
	// COMPUTE COLOR ACCORDING TO GOURAUD HERE
	
	// ambient
	vec3 ambient = ambientColor;

	// diffuse
	vec3 norm = vec3(normalMatrix * normal);
	vec3 normalVector = normalize(norm);

	vec4 viewVector = -modelViewMatrix * vec4(position, 1.0);
	vertPos = vec3(viewVector) / viewVector.w;
	// vec3 lightVector = normalize(lightPosition - vertPos);
	vec3 lightVector = normalize(mat3(modelViewMatrix) * lightPosition);

	float NLAngle = max(0.0, dot(normalVector, lightVector));
	vec3 diffuse = lightColor * NLAngle;

	// specular
	vec3 reflectionVector = reflect(-lightVector, normalVector);
	float specAmount = pow(max(0.0,dot(reflectionVector, normalize(vec3(viewVector)))), shininess);
	vec3 specular = specAmount * lightColor;
	// Color
	V_Color = vec4((kAmbient * ambient) + (kDiffuse * diffuse) + (kSpecular * specular), 1.0);
	// Position
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}