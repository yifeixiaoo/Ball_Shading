varying vec4 V_Normal_VCS;
varying vec4 V_ViewPosition;
varying mat3 vMatrix;

void main() {

	// ADJUST THESE VARIABLES TO PASS PROPER DATA TO THE FRAGMENTS
	V_ViewPosition = -modelViewMatrix * vec4(position, 1.0);
	// V_ViewPosition = viewVector / viewVector.w;
	V_Normal_VCS = vec4(normalMatrix * normal, 0.0);
	// V_ViewPosition = vec4(1.0,0.0,0.0, 1.0);
	vMatrix = mat3(modelViewMatrix);

	gl_Position = projectionMatrix *  modelViewMatrix * vec4(position, 1.0);
}