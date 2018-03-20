
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   renderer.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: vkozlov <vkozlov@student.unit.ua>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/01/23 19:44:26 by vkozlov           #+#    #+#             */
/*   Updated: 2018/01/24 13:08:21 by vkozlov          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_rtv1.h"

static t_ray			dir_light(t_vector p_hit, t_vector l_dir, t_vector n, float *d)
{
	t_ray	light;
	
	light.dir = l_dir;
	light.orig = p_hit + v_mult_d(n, BIAS);
	*d = INFINITY;
	light.dir = -v_normalize(light.dir);
	return (light);
}

static t_ray			point_light(t_vector p_hit, t_vector l_pos, t_vector n, float *d)
{
	t_ray	light;
	
	light.dir = p_hit - l_pos;
	light.orig = p_hit + v_mult_d(n, BIAS);
	*d = v_length(light.dir);
	light.dir = -v_normalize(light.dir);
	return (light);
}

static float			get_shiness(float lambertian, float specular, float light_intensity, t_ray ray, t_ray light)
{
	float			c_gt;
	t_vector		shine;
	float			corel;

	shine = v_mult_d(ray.n_hit, 2 * lambertian) - light.dir;
	c_gt = v_dot(shine, -ray.dir);
	if (c_gt <= 0)
		return (0);
	if (specular <= 2)
		corel = 0.04;
	else if (specular <= 10)
		corel = 0.08;
	else if (specular <= 50)
		corel = 0.1;
	else if (specular <= 250)
		corel = 0.15;
	else if (specular <= 1250)
		corel = 0.2;
	else
		corel = 1;
	return (light_intensity * native_powr(c_gt, specular) * corel);
}

static float get_pattern(t_ray ray)
{
	return (((ray.texX * 8.0 - (int)(ray.texX * 8.0)) > 0.5) ^ ((ray.texY * 8.0 - (int)(ray.texY * 8.0)) > 0.5));
}

float					calc_light(__global t_object	*o,
									__global t_light	*l,
									t_object h, t_ray ray)
{
	int				i;
	float			lt;
	float			vis;
	float			ret_col;
	float			distance;
	float			shader_distance;
	float			light_intensity;
	t_object		shader;
	t_ray			light;
	float			pattern;

	i = -1;
	ret_col = 0;
	light_intensity = 0.0;
	shader.refract = 0;
	pattern = 1;
	while (l[++i].type)
	{
		lt = v_dot(ray.n_hit, light.dir);
		if (lt > 0 && shader.refract)
		{
			light_intensity = lt * l[i].intence * shader.refract;
			if (h.specular > 0)
				light_intensity += get_shiness(lt, h.specular, light_intensity, ray, light);
			ret_col += vis * light_intensity * lt;
		} 

		if (l[i].type == L_AMBIENT)
			ret_col += l[i].intence;
		else
		{
			if (l[i].type == L_DIR)
				light = dir_light(ray.p_hit, l[i].pos, ray.n_hit, &distance);
			else
				light = point_light(ray.p_hit, l[i].pos, ray.n_hit, &distance);
			vis = ft_trace(o, l, &shader_distance, &shader, &(light)) ? 0 : 1;
			if (shader_distance > distance || (l[i].type == L_DIR && vis) || shader.refract)
				vis = 1;
			if (shader.refract)
				vis = shader.refract;
			lt = v_dot(ray.n_hit, light.dir);
			if (lt > 0 && shader.refract)
			{
				light_intensity = lt * l[i].intence * shader.refract;
				if (h.specular > 0)
					light_intensity += get_shiness(lt, h.specular, light_intensity, ray, light);
				ret_col += vis * light_intensity * lt;
			} 
			else if (lt > 0)
			{
				light_intensity = lt * l[i].intence;
				if (h.specular > 0)
					light_intensity += get_shiness(lt, h.specular, light_intensity, ray, light);
				ret_col += vis * light_intensity * lt;
			}
		}
	}
	if (h.permutation_id)
	{
		pattern = get_pattern(ray);
	}
	return (ret_col * 0.5 + ret_col * pattern * 0.5);
}