uniform sampler2D rocksTexture;
varying vec2 texCoord;
varying vec4 V_Normal_VCS;
varying vec4 V_ViewPosition;
varying mat3 vMatrix;

void main() {
	

	V_ViewPosition = -modelViewMatrix * vec4(position, 1.0);
	// V_ViewPosition = viewVector / viewVector.w;
	V_Normal_VCS = vec4(normalMatrix * normal, 0.0);
    vMatrix = mat3(modelViewMatrix);
    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    texCoord = uv;
}
