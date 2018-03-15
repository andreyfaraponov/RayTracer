/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sh_triangle.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: afarapon <afarapon@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/21 16:33:57 by afarapon          #+#    #+#             */
/*   Updated: 2018/03/15 16:47:33 by afarapon         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_rtv1.h"

static short		is_in_zone(t_vector point, t_object *p)
{
	t_vector	c0;
	t_vector	e0;

	e0 = p->p2 - p->p1;
	c0 = point - p->p1;
	if (v_dot(p->dir, v_cross(e0, c0)) < 0)
		return (0);
	e0 = p->p3 - p->p2;
	c0 = point - p->p2;
	if (v_dot(p->dir, v_cross(e0, c0)) < 0)
		return (0);
	e0 = p->p1 - p->p3;
	c0 = point - p->p3;
	if (v_dot(p->dir, v_cross(e0, c0)) < 0)
		return (0);
	return (1);
}

short				triangle_cross(t_object *p, t_ray *r, float *t)
{
	float		a;
	float		t0;
	t_vector	v;

	a = v_dot(p->dir, r->dir);
	if (a)
	{
		v = p->p3 - r->orig; 
		t0 = v_dot(v, p->dir) / a;
		if (t0 >= 0)
		{
			if (!is_in_zone(r->orig + v_mult_d(r->dir, t0), p))
				return (0);
			*t = t0;
			return (1);
		}
	}
	return (0);
}

short				get_triangle_data(t_ray *ray, t_object triangle, float t)
{
	ray->p_hit = ray->orig + v_mult_d(ray->dir, t);
	ray->n_hit = triangle.dir;
	return (1);
}
