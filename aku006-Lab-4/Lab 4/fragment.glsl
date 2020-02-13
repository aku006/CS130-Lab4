varying vec4 position;
varying vec3 normal;
varying vec3 light_direction;

void main()
{
    vec4 ambient = vec4(1, 0, 0, 1);
    vec4 diffuse = vec4(0, 1, 0, 1);
    vec4 specular = vec4(0, 0, 1, 1);

    ambient = gl_FrontMaterial.ambient * gl_LightModel.ambient * gl_LightSource[gl_MaxLights];
    diffuse = gl_FrontMaterial.diffuse * gl_LightSource[0].diffuse * max(dot(normal, light_direction), 0.0);

    vec3 reflectRay = 2.0 * (dot(light_direction, normal) * normal) - light_direction; 
    vec4 reflect = vec4(reflectRay[0], reflectRay[1], reflectRay[2], 0.0);
    float specComp = pow(max(dot(-position, reflect), 0.0), gl_FrontMaterial.shininess);
    specular = gl_FrontMaterial.specular * gl_LightSource[0].specular * specComp;

    gl_FragColor = ambient + diffuse + specular;
}
